# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load(
    "//lib/private:helpers.bzl",
    "get_binary_from_toolchain",
    "write_executable_launcher_file",
)
load("//lib/private/utils:sha.bzl", "sha")
load(
    "//toolchains:toolchains.bzl",
    "JSON_BASH_TOOLCHAIN_TYPE",
    "SHA_TOOLCHAIN_TYPE",
    "TEMPL_TOOLCHAIN_TYPE",
)

def _is_windows(platform):
    return platform.startswith("windows")

def _platform_asset_impl(ctx):
    source = ctx.actions.declare_file("%s_/%s_info.json" % (ctx.label.name, ctx.label.name))
    merger = ctx.actions.declare_file("%s_/%s_merger.sh" % (ctx.label.name, ctx.label.name))
    jq = ctx.toolchains["@aspect_bazel_lib//lib:jq_toolchain_type"].jqinfo.bin
    out = ctx.actions.declare_file("%s.json" % ctx.label.name)
    json_template = ctx.file._json_template
    ctx.actions.expand_template(
        output = source,
        template = json_template,
        substitutions = {
            "_name_": ctx.label.name,
            "_platform_": ctx.attr.platform,
            "_url_": ctx.attr.url,
            "_binary_": ctx.attr.binary,
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

platform_asset = rule(
    _platform_asset_impl,
    attrs = {
        "url": attr.string(),
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
    },
    toolchains = [
        SHA_TOOLCHAIN_TYPE,
        JSON_BASH_TOOLCHAIN_TYPE,
        "@aspect_bazel_lib//lib:jq_toolchain_type",
    ],
)

def _switch(val, arms, default = None):
    for k, v in arms.items():
        if k == val:
            return v
    return default

def _os(platform):
    return platform.split("_")[0]

# buildifier: disable=function-docstring
def multi_platform_assets(
        name,
        url,
        platforms,
        assets_file = "assets.bzl",
        darwin_ext = "tar.gz",
        windows_ext = "zip",
        set_windows_binary_ext = True,
        linux_ext = "tar.gz",
        binary = None,
        prefix = "",
        files = [],
        platforms_map = {}):
    binaries = []
    for platform in platforms:
        _name = "%s_%s" % (name, platform)
        _platform = platforms_map.get(platform, platform)
        ext = _switch(_os(platform), {
            "darwin": darwin_ext,
            "linux": linux_ext,
            "windows": windows_ext,
        }, "tar.gz")
        binaries.append(_name)
        sha(
            name = "%s_sha" % _name,
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )
        platform_asset(
            name = _name,
            platform = platform,
            files = files,
            integrity = ":%s_sha" % _name,
            binary = prefix.format(platform = _platform) +
                     (binary or name) +
                     (".exe" if set_windows_binary_ext and _is_windows(platform) else ""),
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )

    assets(name = "%s_assets" % name, out_file = assets_file, srcs = binaries)

def _assets_impl(ctx):
    out = ctx.outputs.out
    jq = ctx.toolchains["@aspect_bazel_lib//lib:jq_toolchain_type"].jqinfo.bin
    buildifier = ctx.toolchains["@buildifier_prebuilt//buildifier:toolchain"]._tool
    templ = get_binary_from_toolchain(ctx, TEMPL_TOOLCHAIN_TYPE)
    script = write_executable_launcher_file(
        ctx,
        content = """\
#!/usr/bin/env bash
{jq} -s '.' $@ |
{templ} -template assets |
{buildifier} -mode fix -lint fix > {out}
""".format(
            templ = templ.path,
            jq = jq.path,
            out = out.path,
            buildifier = buildifier.path,
        ),
    )

    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [out],
        arguments = [args],
        tools = [jq, templ, buildifier],
        executable = script,
    )

    return [
        DefaultInfo(
            files = depset([out]),
        ),
    ]

_assets = rule(
    _assets_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_empty = False,
            allow_files = True,
            mandatory = True,
        ),
        "out": attr.output(mandatory = True),
    },
    toolchains = [
        TEMPL_TOOLCHAIN_TYPE,
        "@aspect_bazel_lib//lib:jq_toolchain_type",
        "@buildifier_prebuilt//buildifier:toolchain",
    ],
)

def assets(name = "assets", out_file = None, **kwargs):
    _assets(
        name = name,
        out = "%s_bzl" % name,
        **kwargs
    )

    write_source_file(
        name = "update_%s" % name,
        in_file = "%s_bzl" % name,
        out_file = out_file or ":%s.bzl" % name,
    )
