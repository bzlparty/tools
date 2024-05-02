# buildifier: disable=module-docstring
load("//lib:toolchains.bzl", "resolved_toolchain_impl")
load("//toolchains/goawk:assets.bzl", GOAWK_ASSETS = "ASSETS")
load("//toolchains/ripgrep:assets.bzl", RIPGREP_ASSETS = "ASSETS")
load("//toolchains/typos:assets.bzl", TYPOS_ASSETS = "ASSETS")
load("//toolchains/xsv:assets.bzl", XSV_ASSETS = "ASSETS")

TOOLS = {
    "goawk": GOAWK_ASSETS,
    "ripgrep": RIPGREP_ASSETS,
    "typos": TYPOS_ASSETS,
    "xsv": XSV_ASSETS,
}

GOAWK_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:goawk_toolchain_type"

goawk_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(GOAWK_TOOLCHAIN_TYPE),
    toolchains = [GOAWK_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

RIPGREP_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:ripgrep_toolchain_type"

ripgrep_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(RIPGREP_TOOLCHAIN_TYPE),
    toolchains = [RIPGREP_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

TYPOS_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:typos_toolchain_type"

typos_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(TYPOS_TOOLCHAIN_TYPE),
    toolchains = [TYPOS_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

XSV_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:xsv_toolchain_type"

xsv_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(XSV_TOOLCHAIN_TYPE),
    toolchains = [XSV_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

# buildifier: disable=function-docstring
def all_toolchains(name = "all_toolchains"):
    native.toolchain_type(
        name = "goawk_toolchain_type",
        visibility = ["//visibility:public"],
    )
    goawk_resolved_toolchain(
        name = "goawk",
        visibility = ["//visibility:public"],
    )
    native.toolchain_type(
        name = "ripgrep_toolchain_type",
        visibility = ["//visibility:public"],
    )
    ripgrep_resolved_toolchain(
        name = "ripgrep",
        visibility = ["//visibility:public"],
    )
    native.toolchain_type(
        name = "typos_toolchain_type",
        visibility = ["//visibility:public"],
    )
    typos_resolved_toolchain(
        name = "typos",
        visibility = ["//visibility:public"],
    )
    native.toolchain_type(
        name = "xsv_toolchain_type",
        visibility = ["//visibility:public"],
    )
    xsv_resolved_toolchain(
        name = "xsv",
        visibility = ["//visibility:public"],
    )
