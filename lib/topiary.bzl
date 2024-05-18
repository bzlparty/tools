# buildifier: disable=module-docstring
def _topiary_impl(ctx):
    launcher = ctx.actions.declare_file("topiary_format.bash")
    queries = ctx.files._queries
    topiary = ctx.toolchains["@bzlparty_tools//toolchains:topiary_toolchain_type"].binary_info.binary
    ctx.actions.write(
        output = launcher,
        content = """\
export TOPIARY_LANGUAGE_DIR="{queries_dir}";
files=$(find "$BUILD_WORKING_DIRECTORY" -name "*.sh" -type f -not -path "**/e2e/*spec.sh")
{bin} format --skip-idempotence $files
""".format(
            bin = topiary.path,
            queries_dir = ctx.files._queries[0].dirname,
        ),
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([launcher]),
            runfiles = ctx.runfiles([launcher, topiary] + queries),
            executable = launcher,
        ),
    ]

topiary = rule(
    _topiary_impl,
    toolchains = ["@bzlparty_tools//toolchains:topiary_toolchain_type"],
    attrs = {
        "_queries": attr.label(
            default = "@topiary_queries//:files",
            allow_files = True,
        ),
    },
    executable = True,
)
