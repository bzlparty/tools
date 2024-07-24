"Platform Asset"

load("//lib/private/utils:sha.bzl", "sha")
load(
    "//toolchains:toolchains.bzl",
    "SHA_TOOLCHAIN_TYPE",
)
load(":assets_bundle.bzl", "assets_bundle")

UrlInfo = provider(doc = "", fields = ["url"])

def _is_windows(platform):
    return platform.startswith("windows")

def _os(platform):
    return platform.split("_")[0]

def _switch(val, arms, default = None):
    for k, v in arms.items():
        if k == val:
            return v
    return default

def _platform_asset_impl(ctx):
    source = ctx.actions.declare_file("%s_/%s_info.json" % (ctx.label.name, ctx.label.name))
    merger = ctx.actions.declare_file("%s_/%s_merger.sh" % (ctx.label.name, ctx.label.name))
    jq = ctx.toolchains["@aspect_bazel_lib//lib:jq_toolchain_type"].jqinfo.bin
    out = ctx.actions.declare_file("%s.json" % ctx.label.name)
    json_template = ctx.file._json_template
    if ctx.attr.url:
        url = ctx.attr.url
    else:
        url = "{}/{}".format(ctx.attr.url_flag[UrlInfo].url, ctx.attr.binary)
    ctx.actions.expand_template(
        output = source,
        template = json_template,
        substitutions = {
            "_name_": ctx.label.name,
            "_platform_": ctx.attr.platform,
            "_url_": url,
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
        SHA_TOOLCHAIN_TYPE,
        "@aspect_bazel_lib//lib:jq_toolchain_type",
    ],
)

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
    assets = []
    for platform in platforms:
        _name = "%s_%s" % (name, platform)
        _platform = platforms_map.get(platform, platform)
        ext = _switch(_os(platform), {
            "darwin": darwin_ext,
            "linux": linux_ext,
            "windows": windows_ext,
        }, "tar.gz")
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
        assets.append(_name)

    assets_bundle(
        name = "%s_assets" % name,
        out_file = assets_file,
        srcs = assets,
    )

def _url_imp(ctx):
    if ctx.build_setting_value == "default":
        url = "no-url"
    else:
        url = ctx.build_setting_value
    return UrlInfo(url = url)

url_flag = rule(
    implementation = _url_imp,
    build_setting = config.string(flag = True),
)

# buildifier: disable=function-docstring
def cmd_assets(name, binary, integrity_map, **kwargs):
    assets = []
    for target, platform in integrity_map.items():
        _name = "%s_%s" % (name, platform)
        _ext = ".exe" if _is_windows(platform) else ""
        platform_asset(
            name = _name,
            binary = "{}_{}{}".format(binary, platform, _ext),
            platform = platform,
            integrity = target,
            **kwargs
        )
        assets.append(_name)

    assets_bundle(
        name = name,
        srcs = assets,
        write_file = False,
    )
