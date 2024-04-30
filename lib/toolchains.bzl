"# Toolchains"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":platforms.bzl", "PLATFORMS")

def _binary_toolchain_impl(ctx):
    binary = ctx.file.binary
    default_info = DefaultInfo(
        files = depset([binary]),
        runfiles = ctx.runfiles(files = [binary]),
    )
    binary_info = BinaryToolchainInfo(
        binary = binary,
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
    },
)

binary_toolchain = rule(
    _binary_toolchain_impl,
    attrs = {
        "binary": attr.label(mandatory = True, allow_single_file = True),
        "prefix": attr.string(mandatory = True),
    },
)

# buildifier: disable=function-docstring
def platform_toolchains(name, assets):
    toolchains_build_file = ""
    for (platform, config) in assets.items():
        _name = "%s_%s" % (name, platform)
        http_archive(
            name = _name,
            url = config.url,
            integrity = config.integrity,
            build_file_content = """\
load("@bzlparty_tools//lib:toolchains.bzl", "binary_toolchain")
binary_toolchain(
    name = "{name}_binary_toolchain",
    prefix = "{name}",
    binary = "{binary}",
)
""".format(
                binary = config.binary,
                name = name,
            ),
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
            platform = platform,
            compatible_with = PLATFORMS[platform],
        )

    _binary_toolchains(name = name, build_file = toolchains_build_file)

_binary_toolchains = repository_rule(
    implementation = lambda ctx: ctx.file("BUILD.bazel", ctx.attr.build_file),
    attrs = {
        "build_file": attr.string(mandatory = True),
    },
)

def _resolved_toolchain_impl(toolchain):
    def _impl(ctx):
        toolchain_info = ctx.toolchains[toolchain]
        return [
            toolchain_info,
            toolchain_info.default,
            toolchain_info.binary_info,
            toolchain_info.template_variables,
        ]

    return _impl

GOAWK_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:goawk_toolchain_type"
RIPGREP_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:ripgrep_toolchain_type"

goawk_resolved_toolchain = rule(
    implementation = _resolved_toolchain_impl(GOAWK_TOOLCHAIN_TYPE),
    toolchains = [GOAWK_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

ripgrep_resolved_toolchain = rule(
    implementation = _resolved_toolchain_impl(RIPGREP_TOOLCHAIN_TYPE),
    toolchains = [RIPGREP_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)
