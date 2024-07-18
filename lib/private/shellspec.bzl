"Shellspec test rule"

load(":utils.bzl", "get_binary_from_toolchain", "write_executable_launcher_file")

# buildifier: disable=module-docstring
def _shellspec_impl(ctx):
    shellspec = get_binary_from_toolchain(ctx, "@bzlparty_tools//toolchains:shellspec_toolchain_type")
    launcher = write_executable_launcher_file(
        ctx,
        content = """\
export HOME=$(mktemp -d);
{shellspec_bin} {spec};
""".format(
            shellspec_bin = shellspec.path,
            spec = ctx.file.spec.path,
        ),
    )

    return [
        DefaultInfo(
            files = depset([launcher]),
            runfiles = ctx.runfiles(files = [shellspec, ctx.file.spec, ctx.file.config] + ctx.files.srcs),
            executable = launcher,
        ),
    ]

shellspec_test = rule(
    _shellspec_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".sh", ".bash"]),
        "spec": attr.label(allow_single_file = True),
        "config": attr.label(allow_single_file = True),
    },
    toolchains = ["@bzlparty_tools//toolchains:shellspec_toolchain_type"],
    test = True,
)
