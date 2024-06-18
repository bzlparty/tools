"# Toolchains"

load("@local_config_platform//:constraints.bzl", "HOST_CONSTRAINTS")
load(":platforms.bzl", "HOST_PLATFORM", "PLATFORMS")

def _binary_toolchain_impl(ctx):
    binary = ctx.file.binary
    files = ctx.files.files
    default_info = DefaultInfo(
        files = depset([binary] + files),
        runfiles = ctx.runfiles(files = [binary] + files),
    )
    binary_info = BinaryToolchainInfo(
        binary = binary,
        files = files,
    )
    env = dict([("%s_BIN" % ctx.attr.prefix.upper(), binary.path)])
    variable_info = platform_common.TemplateVariableInfo(env)
    toolchain_info = platform_common.ToolchainInfo(
        binary_info = binary_info,
        template_variables = variable_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

BinaryToolchainInfo = provider(
    doc = "Binary Toolchain Provider",
    fields = {
        "binary": "Path to binary",
        "files": "Paths to library files",
    },
)

binary_toolchain = rule(
    _binary_toolchain_impl,
    attrs = {
        "binary": attr.label(mandatory = True, allow_single_file = True),
        "prefix": attr.string(mandatory = True),
        "files": attr.label_list(allow_files = True, default = []),
    },
)

EXTENSIONS = [
    "zip",
    "jar",
    "war",
    "aar",
    "tar",
    "tar.gz",
    "tgz",
    "tar.xz",
    "txz",
    ".tar.zst",
    ".tzst",
    "tar.bz2",
    ".tbz",
    ".ar",
    ".deb",
]

def _is_archive(url):
    for e in EXTENSIONS:
        if url.endswith(e):
            return True
    return False

def _platform_toolchain_impl(ctx):
    if _is_archive(ctx.attr.url):
        ctx.download_and_extract(
            url = ctx.attr.url,
            integrity = ctx.attr.integrity,
        )
    else:
        ctx.download(
            url = ctx.attr.url,
            output = ctx.attr.binary,
            integrity = ctx.attr.integrity,
            executable = True,
        )

    ctx.file("BUILD.bazel", """\
load("@bzlparty_tools//lib:toolchains.bzl", "binary_toolchain")
binary_toolchain(
    name = "{prefix}_binary_toolchain",
    prefix = "{prefix}",
    binary = "{binary}",
)

alias(
  name = "bin",
  actual = "{binary}",
  visibility = ["//visibility:public"],
)
""".format(
        binary = ctx.attr.binary,
        prefix = ctx.attr.prefix,
    ))

platform_toolchain = repository_rule(
    _platform_toolchain_impl,
    attrs = {
        "url": attr.string(),
        "binary": attr.string(),
        "prefix": attr.string(),
        "integrity": attr.string(),
    },
)

# buildifier: disable=function-docstring
def register_platform_toolchains(name, assets):
    toolchains_build_file = """\
load("@bzlparty_tools//platforms:host.bzl", "HOST_PLATFORM")

alias(
    name = "{name}",
    actual = "@{name}_%s//:bin" % HOST_PLATFORM,
)
""".format(name = name)
    for (platform, config) in assets.items():
        _platform = HOST_PLATFORM if platform == "host" else platform
        _name = "%s_%s" % (name, _platform)
        platform_toolchain(
            name = _name,
            prefix = name,
            url = config.url,
            integrity = config.integrity,
            binary = config.binary,
        )
        toolchains_build_file += """\
toolchain(
    name = "{name}_{platform}_toolchain",
    toolchain = "@{name}_{platform}//:{name}_binary_toolchain",
    exec_compatible_with = {compatible_with},
    toolchain_type = "@bzlparty_tools//toolchains:{name}_toolchain_type",
    visibility = ["//visibility:public"],
)
""".format(
            name = name,
            platform = _platform,
            compatible_with = HOST_CONSTRAINTS if platform == "host" else PLATFORMS[platform],
        )

    platform_toolchains(name = name, build_file = toolchains_build_file)

platform_toolchains = repository_rule(
    implementation = lambda ctx: ctx.file("BUILD.bazel", ctx.attr.build_file),
    attrs = {
        "build_file": attr.string(mandatory = True),
    },
)

def resolved_toolchain_impl(toolchain):
    def _impl(ctx):
        toolchain_info = ctx.toolchains[toolchain]
        return [
            toolchain_info,
            toolchain_info.default,
            toolchain_info.binary_info,
            toolchain_info.template_variables,
        ]

    return _impl
