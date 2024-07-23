# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load("//lib:defs.bzl", "get_binary_from_toolchain", "write_executable_launcher_file")
load("//toolchains:toolchains.bzl", "TEMPL_TOOLCHAIN_TYPE")

def _create_bzl_file_impl(ctx):
    output = ctx.actions.declare_file("{}_/{}.bzl".format(ctx.label.name, ctx.attr.template))
    templ = get_binary_from_toolchain(ctx, TEMPL_TOOLCHAIN_TYPE)
    buildifier = ctx.toolchains["@buildifier_prebuilt//buildifier:toolchain"]._tool
    launcher = write_executable_launcher_file(
        ctx,
        content = """\
#!/usr/bin/env bash
echo '{tools}' |
{templ} -template {template} |
{buildifier} -mode fix -lint fix > {out}
""".format(
            templ = templ.path,
            buildifier = buildifier.path,
            out = output.path,
            template = ctx.attr.template,
            tools = json.encode(ctx.attr.tools),
        ),
    )

    ctx.actions.run(
        outputs = [output],
        tools = [templ, buildifier],
        executable = launcher,
    )

    return [
        DefaultInfo(
            files = depset([output]),
        ),
    ]

_create_bzl_file = rule(
    _create_bzl_file_impl,
    attrs = {
        "tools": attr.string_list(mandatory = True),
        "template": attr.string(mandatory = True, values = ["tools", "toolchains"]),
    },
    toolchains = [
        TEMPL_TOOLCHAIN_TYPE,
        "@buildifier_prebuilt//buildifier:toolchain",
    ],
)

def create_bzl_file(name, out, **kwargs):
    _create_bzl_file(
        name = name,
        **kwargs
    )
    write_source_file(
        name = "update_%s" % name,
        in_file = name,
        out_file = out,
    )
