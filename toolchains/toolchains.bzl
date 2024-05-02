# buildifier: disable=module-docstring
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
TYPOS_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:typos_toolchain_type"
XSV_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:xsv_toolchain_type"

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

typos_resolved_toolchain = rule(
    implementation = _resolved_toolchain_impl(TYPOS_TOOLCHAIN_TYPE),
    toolchains = [TYPOS_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

xsv_resolved_toolchain = rule(
    implementation = _resolved_toolchain_impl(XSV_TOOLCHAIN_TYPE),
    toolchains = [XSV_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)
