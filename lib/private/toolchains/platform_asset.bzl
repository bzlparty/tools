"Platform Asset"

load("//lib/private:helpers.bzl", "ReleaseInfo")
load("//toolchains:external.bzl", "JQ_TOOLCHAIN_TYPE")

def _platform_asset_impl(ctx):
    source = ctx.actions.declare_file("%s_/%s_info.json" % (ctx.label.name, ctx.label.name))
    merger = ctx.actions.declare_file("%s_/%s_merger.sh" % (ctx.label.name, ctx.label.name))
    jq = ctx.toolchains[JQ_TOOLCHAIN_TYPE].jqinfo.bin
    out = ctx.actions.declare_file("%s.json" % ctx.label.name)
    json_template = ctx.file._json_template
    if ctx.attr.url:
        url = ctx.attr.url
    else:
        url = "{}/{}".format(ctx.attr.url_flag[ReleaseInfo].value, ctx.attr.binary)
    ctx.actions.expand_template(
        output = source,
        template = json_template,
        substitutions = {
            "%NAME%": ctx.label.name,
            "%PLATFORM%": ctx.attr.platform,
            "%URL%": url,
            "%BINARY%": ctx.attr.binary,
            "[]": json.encode(ctx.attr.files),
        },
        is_executable = False,
    )
    ctx.actions.expand_template(
        output = merger,
        template = ctx.file._merger_template,
        substitutions = {
            "%ALGO%": ctx.attr.algo,
            "%SOURCE%": source.path,
            "%OUT%": out.path,
            "%JQ%": jq.path,
            "%INTEGRITY%": ctx.file.integrity.path,
        },
        is_executable = True,
    )

    ctx.actions.run(
        outputs = [out],
        inputs = [source, ctx.file.integrity],
        executable = merger,
        tools = [jq],
        mnemonic = "PlatformAsset",
    )

    return [
        DefaultInfo(
            files = depset([out]),
        ),
    ]

_ATTRS = {
    "url": attr.string(),
    "url_flag": attr.label(mandatory = False),
    "binary": attr.string(),
    "algo": attr.string(default = "384"),
    "platform": attr.string(),
    "files": attr.string_list(default = []),
    "integrity": attr.label(allow_single_file = True),
    "_json_template": attr.label(
        allow_single_file = True,
        default = "@bzlparty_tools//lib/private/toolchains:asset.template.json",
    ),
    "_merger_template": attr.label(
        allow_single_file = True,
        default = "@bzlparty_tools//lib/private/toolchains:merger.template.sh",
    ),
}

platform_asset = rule(
    _platform_asset_impl,
    attrs = _ATTRS,
    toolchains = [
        JQ_TOOLCHAIN_TYPE,
    ],
)
