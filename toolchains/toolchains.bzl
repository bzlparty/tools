"Toolchains"

load("//lib:toolchains.bzl", "resolved_toolchain_impl")

BIOME_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:biome_toolchain_type"

biome_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(BIOME_TOOLCHAIN_TYPE),
    toolchains = [BIOME_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

FD_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:fd_toolchain_type"

fd_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(FD_TOOLCHAIN_TYPE),
    toolchains = [FD_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

GOAWK_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:goawk_toolchain_type"

goawk_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(GOAWK_TOOLCHAIN_TYPE),
    toolchains = [GOAWK_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

JQL_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:jql_toolchain_type"

jql_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(JQL_TOOLCHAIN_TYPE),
    toolchains = [JQL_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

JSON_BASH_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:json_bash_toolchain_type"

json_bash_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(JSON_BASH_TOOLCHAIN_TYPE),
    toolchains = [JSON_BASH_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

RIPGREP_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:ripgrep_toolchain_type"

ripgrep_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(RIPGREP_TOOLCHAIN_TYPE),
    toolchains = [RIPGREP_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

SHA_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:sha_toolchain_type"

sha_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(SHA_TOOLCHAIN_TYPE),
    toolchains = [SHA_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

SHELLCHECK_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:shellcheck_toolchain_type"

shellcheck_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(SHELLCHECK_TOOLCHAIN_TYPE),
    toolchains = [SHELLCHECK_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

SHELLSPEC_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:shellspec_toolchain_type"

shellspec_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(SHELLSPEC_TOOLCHAIN_TYPE),
    toolchains = [SHELLSPEC_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

TEMPL_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:templ_toolchain_type"

templ_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(TEMPL_TOOLCHAIN_TYPE),
    toolchains = [TEMPL_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)

TOPIARY_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:topiary_toolchain_type"

topiary_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl(TOPIARY_TOOLCHAIN_TYPE),
    toolchains = [TOPIARY_TOOLCHAIN_TYPE],
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
def bzlparty_toolchains(name = "bzlparty_toolchains"):
    native.toolchain_type(
        name = "biome_toolchain_type",
        visibility = ["//visibility:public"],
    )
    biome_resolved_toolchain(
        name = "biome",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "fd_toolchain_type",
        visibility = ["//visibility:public"],
    )
    fd_resolved_toolchain(
        name = "fd",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "goawk_toolchain_type",
        visibility = ["//visibility:public"],
    )
    goawk_resolved_toolchain(
        name = "goawk",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "jql_toolchain_type",
        visibility = ["//visibility:public"],
    )
    jql_resolved_toolchain(
        name = "jql",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "json_bash_toolchain_type",
        visibility = ["//visibility:public"],
    )
    json_bash_resolved_toolchain(
        name = "json_bash",
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
        name = "sha_toolchain_type",
        visibility = ["//visibility:public"],
    )
    sha_resolved_toolchain(
        name = "sha",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "shellcheck_toolchain_type",
        visibility = ["//visibility:public"],
    )
    shellcheck_resolved_toolchain(
        name = "shellcheck",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "shellspec_toolchain_type",
        visibility = ["//visibility:public"],
    )
    shellspec_resolved_toolchain(
        name = "shellspec",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "templ_toolchain_type",
        visibility = ["//visibility:public"],
    )
    templ_resolved_toolchain(
        name = "templ",
        visibility = ["//visibility:public"],
    )

    native.toolchain_type(
        name = "topiary_toolchain_type",
        visibility = ["//visibility:public"],
    )
    topiary_resolved_toolchain(
        name = "topiary",
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
