# buildifier: disable=module-docstring
def _shellspec_impl(ctx):
    launcher = ctx.actions.declare_file("%s_shellspec_launcher.sh" % ctx.attr.name)
    shellspec = ctx.toolchains["@bzlparty_tools//toolchains:shellspec_toolchain_type"].binary_info.binary
    ctx.actions.write(
        output = launcher,
        content = """\
export HOME=$(mktemp -d);
{shellspec_bin} {spec};
""".format(
            shellspec_bin = shellspec.path,
            spec = ctx.file.spec.path,
        ),
        is_executable = True,
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
