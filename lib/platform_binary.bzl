# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load("//lib:platforms.bzl", "is_windows")

def platform_binary(name, url, binary, platform, algo = "384"):
    native.genrule(
        name = name,
        outs = ["%s.meta" % name],
        cmd = """(
echo -n \"{platform} \";
echo -n \"{url} \";
echo -n \"{binary} \";
echo -n \"{algo} \";
./$(location //sh:shasums) -a {algo} -u {url}
) > $(OUTS)
""".format(
            algo = algo,
            url = url,
            platform = platform,
            binary = binary,
        ),
        tools = ["//sh:shasums"],
    )

# buildifier: disable=function-docstring
def platform_binaries(name, url, platforms, binary = None, prefix = "", platforms_map = {}):
    binaries = []
    for platform in platforms:
        _name = "%s_%s" % (name, platform)
        _platform = platforms_map.get(platform, platform)
        binaries.append(_name)
        platform_binary(
            name = _name,
            platform = platform,
            binary = prefix.format(platform = _platform) + (binary or name) + (".exe" if is_windows(platform) else ""),
            url = url.format(
                platform = _platform,
                ext = "zip" if is_windows(platform) else "tar.gz",
            ),
        )

    binary_assets(
        name = "%s_assets" % name,
        srcs = binaries,
    )

    write_source_file(
        name = "update_assets",
        in_file = ":%s_assets" % name,
        out_file = ":assets.bzl",
    )

def binary_assets(name, srcs):
    native.genrule(
        name = name,
        outs = ["%s.bzl" % name],
        tools = ["//lib:platform_binary.awk"],
        cmd = """
cat $(SRCS) |
./$(GOAWK_BIN) -f $(location //lib:platform_binary.awk) > $(OUTS)
        """,
        toolchains = ["@bzlparty_tools//toolchains:goawk"],
        srcs = srcs,
    )