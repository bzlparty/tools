"Shellspec test rule"

load("//toolchains:toolchains.bzl", "SHELLSPEC_TOOLCHAIN_TYPE")
load(
    ":utils.bzl",
    "get_binary_from_toolchain",
    "get_files_from_toolchain",
    "write_executable_launcher_file",
)

# buildifier: disable=module-docstring
def _shellspec_impl(ctx):
    shellspec = get_binary_from_toolchain(ctx, SHELLSPEC_TOOLCHAIN_TYPE)
    shellspec_files = get_files_from_toolchain(ctx, SHELLSPEC_TOOLCHAIN_TYPE)
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
            runfiles = ctx.runfiles(
                files = [shellspec, ctx.file.spec, ctx.file.config] +
                        ctx.files.srcs +
                        shellspec_files,
            ),
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
    toolchains = [SHELLSPEC_TOOLCHAIN_TYPE],
    test = True,
)
