# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load(":utils.bzl", "is_windows")

def _platform_asset_impl(ctx):
    launcher = ctx.actions.declare_file("%s_/%s" % (ctx.label.name, ctx.label.name))
    info = ctx.actions.declare_file("%s_/%s_info.csv" % (ctx.label.name, ctx.label.name))
    sha = ctx.toolchains["@bzlparty_tools//toolchains:sha_toolchain_type"].binary_info.binary
    xsv = ctx.toolchains["@bzlparty_tools//toolchains:xsv_toolchain_type"].binary_info.binary
    out = ctx.actions.declare_file("%s.csv" % ctx.label.name)
    ctx.actions.write(
        output = info,
        is_executable = False,
        content = """\
Name,Platform,Url,Binary
{name},{platform},{url},{binary}
""".format(
            binary = ctx.attr.binary,
            name = ctx.label.name,
            platform = ctx.attr.platform,
            url = ctx.attr.url,
        ),
    )
    ctx.actions.write(
        output = launcher,
        is_executable = True,
        content = """
integrity=$({sha} -a "{algo}" "{url}")
integrity_csv=$(mktemp)
cat > "$integrity_csv" << EOF
Integrity
sha{algo}-$integrity
EOF

{xsv} cat columns {info} "$integrity_csv" > {out} 
rm -rf "$integrity_csv"
      """.format(
            algo = ctx.attr.algo,
            info = info.path,
            out = out.path,
            sha = sha.path,
            url = ctx.attr.url,
            xsv = xsv.path,
        ),
    )

    ctx.actions.run(
        outputs = [out],
        inputs = [launcher, info],
        executable = launcher,
        tools = [sha, xsv],
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
    },
    toolchains = [
        "@bzlparty_tools//toolchains:sha_toolchain_type",
        "@bzlparty_tools//toolchains:xsv_toolchain_type",
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
        linux_ext = "tar.gz",
        binary = None,
        prefix = "",
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
            binary = prefix.format(platform = _platform) +
                     (binary or name) +
                     (".exe" if is_windows(platform) else ""),
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )

    assets(name = "%s_assets" % name, out_file = assets_file, srcs = binaries)

def _assets_impl(ctx):
    script = ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))
    xsv = ctx.toolchains["@bzlparty_tools//toolchains:xsv_toolchain_type"].binary_info.binary
    goawk = ctx.toolchains["@bzlparty_tools//toolchains:goawk_toolchain_type"].binary_info.binary
    utils = ctx.toolchains["@aspect_bazel_lib//lib:coreutils_toolchain_type"].coreutils_info.bin
    out = ctx.outputs.out

    ctx.actions.write(
        output = script,
        content = """\
#!/usr/bin/env bash

{xsv} cat rows $@ |
{utils} tail +2 |
{goawk} -f {assets_awk} > {out}
      """.format(
            xsv = xsv.path,
            goawk = goawk.path,
            utils = utils.path,
            out = out.path,
            assets_awk = ctx.file._assets_awk.path,
        ),
        is_executable = True,
    )

    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)

    ctx.actions.run(
        inputs = ctx.files.srcs + [ctx.file._assets_awk],
        outputs = [ctx.outputs.out],
        arguments = [args],
        tools = [xsv, goawk, utils],
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
        "_assets_awk": attr.label(default = Label("@bzlparty_tools//lib/private:assets.awk"), allow_single_file = True),
    },
    toolchains = [
        "@bzlparty_tools//toolchains:xsv_toolchain_type",
        "@bzlparty_tools//toolchains:goawk_toolchain_type",
        "@aspect_bazel_lib//lib:coreutils_toolchain_type",
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
