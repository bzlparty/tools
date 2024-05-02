# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")

def _generate_toolchains_impl(ctx):
    output = ctx.actions.declare_file("generated_toolchains.bzl")
    tools_list = ctx.actions.declare_file("_tools_list")
    goawk = ctx.toolchains["@bzlparty_tools//toolchains:goawk_toolchain_type"].binary_info.binary
    ctx.actions.write(
        output = tools_list,
        content = "\n".join(ctx.attr.tools),
    )
    ctx.actions.run_shell(
        outputs = [output],
        inputs = ctx.files.partials + [tools_list],
        command = "(" + "; ".join(
            [
                """\
{goawk} -f {file} {input}\
""".format(goawk = goawk.path, file = p.path, input = tools_list.path)
                for p in ctx.files.partials
            ],
        ) + ") > {out}".format(out = output.path),
        tools = [goawk],
        toolchain = "@bzlparty_tools//toolchains:goawk_toolchain_type",
    )

    return [
        DefaultInfo(
            files = depset([output]),
            runfiles = ctx.runfiles(files = [goawk, tools_list] + ctx.files.partials),
        ),
    ]

_generate_toolchains = rule(
    _generate_toolchains_impl,
    attrs = {
        "partials": attr.label_list(
            allow_files = True,
            default = [
                Label("//toolchains/private:header.awk"),
                Label("//toolchains/private:tools.awk"),
                Label("//toolchains/private:resolved_toolchains.awk"),
                Label("//toolchains/private:all_toolchains.awk"),
            ],
        ),
        "tools": attr.string_list(),
    },
    toolchains = ["@bzlparty_tools//toolchains:goawk_toolchain_type"],
)

def generate_toolchains(name, **kwargs):
    _generate_toolchains(name = name, **kwargs)
    write_source_file(
        name = "update_%s" % name,
        in_file = name,
        out_file = ":toolchains.bzl",
    )
