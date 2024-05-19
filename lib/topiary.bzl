# buildifier: disable=module-docstring
def _topiary_impl(ctx):
    launcher = ctx.actions.declare_file("topiary_format.bash")
    queries = ctx.files._queries
    topiary = ctx.toolchains["@bzlparty_tools//toolchains:topiary_toolchain_type"].binary_info.binary
    fd = ctx.toolchains["@bzlparty_tools//toolchains:fd_toolchain_type"].binary_info.binary
    args = []
    args.append("--hidden")
    if len(ctx.attr.extensions) > 0:
        args.extend(["--extension %s" % e for e in ctx.attr.extensions])
    if len(ctx.attr.exclude) > 0:
        args.extend(["--exclude %s" % e for e in ctx.attr.exclude])
    ctx.actions.write(
        output = launcher,
        content = """\
export TOPIARY_LANGUAGE_DIR="{queries_dir}";
files=$({fd} . "$BUILD_WORKING_DIRECTORY" {fd_args})
{bin} format --skip-idempotence $files
""".format(
            bin = topiary.path,
            fd = fd.path,
            fd_args = " ".join(args),
            queries_dir = ctx.files._queries[0].dirname,
        ),
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([launcher]),
            runfiles = ctx.runfiles([launcher, topiary, fd] + queries),
            executable = launcher,
        ),
    ]

topiary = rule(
    _topiary_impl,
    toolchains = ["@bzlparty_tools//toolchains:topiary_toolchain_type", "@bzlparty_tools//toolchains:fd_toolchain_type"],
    attrs = {
        "extensions": attr.string_list(mandatory = False, default = ["sh", "bash"]),
        "exclude": attr.string_list(mandatory = False, default = []),
        "_queries": attr.label(
            default = "@topiary_queries//:files",
            allow_files = True,
        ),
    },
    executable = True,
)
