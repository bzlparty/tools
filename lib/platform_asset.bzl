# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load(":platforms.bzl", "is_windows")

def _platform_asset_impl(ctx):
    launcher = ctx.actions.declare_file("%s_/%s" % (ctx.label.name, ctx.label.name))
    sha = ctx.toolchains["@bzlparty_tools//toolchains:sha_toolchain_type"].binary_info.binary
    out = ctx.actions.declare_file("%s.meta" % ctx.label.name)
    ctx.actions.write(
        output = launcher,
        is_executable = True,
        content = """
integrity=$({sha} {url})
echo "{platform} {url} {binary} {algo} ${{integrity}}" > {out}
      """.format(
            url = ctx.attr.url,
            binary = ctx.attr.binary,
            algo = ctx.attr.algo,
            platform = ctx.attr.platform,
            sha = sha.path,
            out = out.path,
        ),
    )

    ctx.actions.run(
        outputs = [out],
        inputs = [launcher],
        executable = launcher,
        tools = [sha],
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
    toolchains = ["@bzlparty_tools//toolchains:sha_toolchain_type"],
)

def _switch(val, arms, default = None):
    for k, v in arms.items():
        if k == val:
            return v
    return default

def _os(platform):
    return platform.split("_")[0]

# buildifier: disable=function-docstring
def multi_platform_assets(name, url, platforms, darwin_ext = "tar.gz", windows_ext = "zip", linux_ext = "tar.gz", binary = None, prefix = "", platforms_map = {}):
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
            binary = prefix.format(platform = _platform) + (binary or name) + (".exe" if is_windows(platform) else ""),
            url = url.format(
                platform = _platform,
                ext = ext,
            ),
        )

    assets(srcs = binaries)

def assets(name = "assets", **kwargs):
    native.genrule(
        name = name,
        outs = ["%s_bzl" % name],
        tools = ["@bzlparty_tools//lib:assets.awk"],
        cmd = """
cat $(SRCS) |
./$(GOAWK_BIN) -f $(location @bzlparty_tools//lib:assets.awk) > $(OUTS)
        """,
        toolchains = ["@bzlparty_tools//toolchains:goawk"],
        **kwargs
    )

    write_source_file(
        name = "update_%s" % name,
        in_file = "%s" % name,
        out_file = ":assets.bzl",
    )
