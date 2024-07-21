# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load(":utils.bzl", "get_binary_from_toolchain", "write_executable_launcher_file")

def _is_windows(platform):
    return platform.startswith("windows")

def _platform_asset_impl(ctx):
    info = ctx.actions.declare_file("%s_/%s_info.json" % (ctx.label.name, ctx.label.name))
    sha = get_binary_from_toolchain(ctx, "@bzlparty_tools//toolchains:sha_toolchain_type")
    json_bash = get_binary_from_toolchain(ctx, "@bzlparty_tools//toolchains:json_bash_toolchain_type")
    jq = ctx.toolchains["@aspect_bazel_lib//lib:jq_toolchain_type"].jqinfo.bin
    out = ctx.actions.declare_file("%s.json" % ctx.label.name)
    json_template = ctx.file._json_template
    ctx.actions.expand_template(
        output = info,
        template = json_template,
        substitutions = {
            "_name_": ctx.label.name,
            "_platform_": ctx.attr.platform,
            "_algo_": ctx.attr.algo,
            "_url_": ctx.attr.url,
            "_binary_": ctx.attr.binary,
            "[]": "[\"%s\"]" % "\", \"".join(ctx.attr.files) if len(ctx.attr.files) > 0 else "[]",
        },
        is_executable = False,
    )
    launcher = write_executable_launcher_file(
        ctx,
        content = """
integrity=$(mktemp)
integrity_json=$(mktemp)
{sha} -a "{algo}" "{url}" > "$integrity"
{json} integrity@"$integrity" > "$integrity_json"
{jq} -s '.[0] * .[1]' {info} $integrity_json > {out}
      """.format(
            algo = ctx.attr.algo,
            info = info.path,
            out = out.path,
            sha = sha.path,
            url = ctx.attr.url,
            json = json_bash.path,
            jq = jq.path,
        ),
    )

    ctx.actions.run(
        outputs = [out],
        inputs = [launcher, info],
        executable = launcher,
        tools = [sha, json_bash, jq],
        mnemonic = "AssetInfo",
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
        "_json_template": attr.label(allow_single_file = True, default = "@bzlparty_tools//lib/private:assets.template.json"),
    },
    toolchains = [
        "@bzlparty_tools//toolchains:sha_toolchain_type",
        "@bzlparty_tools//toolchains:json_bash_toolchain_type",
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
        platform_asset(
            name = _name,
            platform = platform,
            files = files,
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
    json_to_assets = get_binary_from_toolchain(ctx, "@bzlparty_tools//toolchains:json_to_assets_toolchain_type")
    script = write_executable_launcher_file(
        ctx,
        content = """\
#!/usr/bin/env bash
{jq} -s '.' $@ | {json_to_assets} > {out}
""".format(
            json_to_assets = json_to_assets.path,
            jq = jq.path,
            out = out.path,
        ),
    )

    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [out],
        arguments = [args],
        tools = [jq, json_to_assets],
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
        "srcs": attr.label_list(allow_empty = False, allow_files = True, mandatory = True),
        "out": attr.output(mandatory = True),
    },
    toolchains = [
        "@bzlparty_tools//toolchains:json_to_assets_toolchain_type",
        "@aspect_bazel_lib//lib:jq_toolchain_type",
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
