"# Toolchains"

GoawkToolchainInfo = provider(
    doc = "goawk Toolchain Provider",
    fields = {
        "executable": "goawk executable",
    },
)

def _goawk_toolchain_impl(ctx):
    executable = ctx.file.executable
    default_info = DefaultInfo(
        files = depset([executable]),
        runfiles = ctx.runfiles(files = [executable]),
    )
    goawk_info = GoawkToolchainInfo(
        executable = executable,
    )
    variable_info = platform_common.TemplateVariableInfo(
        {"GOAWK_BIN": executable.path},
    )
    toolchain_info = platform_common.ToolchainInfo(
        goawk_info = goawk_info,
        template_variables = variable_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

goawk_toolchain = rule(
    _goawk_toolchain_impl,
    attrs = {
        "executable": attr.label(mandatory = True, allow_single_file = True),
    },
)

def _resolved_toolchain_impl(ctx):
    toolchain_info = ctx.toolchains["@bzlparty_tools//toolchains:goawk_toolchain_type"]
    return [
        toolchain_info,
        toolchain_info.default,
        toolchain_info.goawk_info,
        toolchain_info.template_variables,
    ]

resolved_toolchain = rule(
    implementation = _resolved_toolchain_impl,
    toolchains = ["@bzlparty_tools//toolchains:goawk_toolchain_type"],
    incompatible_use_toolchain_transition = True,
)
