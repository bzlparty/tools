package main

var ToolchainsTemplate = `"Toolchains"

load("//lib:toolchains.bzl", "resolved_toolchain_impl")

{{range .}}
{{. | ToUpper}}_TOOLCHAIN_TYPE = "@bzlparty_tools//toolchains:{{.}}_toolchain_type"

{{.}}_resolved_toolchain = rule(
    implementation = resolved_toolchain_impl({{. | ToUpper}}_TOOLCHAIN_TYPE),
    toolchains = [{{. | ToUpper}}_TOOLCHAIN_TYPE],
    incompatible_use_toolchain_transition = True,
)
{{end}}

# buildifier: disable=function-docstring
def bzlparty_toolchains(name = "bzlparty_toolchains"):
{{range .}}
    native.toolchain_type(
        name = "{{.}}_toolchain_type",
        visibility = ["//visibility:public"],
    )
    {{.}}_resolved_toolchain(
        name = "{{.}}",
        visibility = ["//visibility:public"],
    )
{{end}}
`
