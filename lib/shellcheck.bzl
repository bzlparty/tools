# buildifier: disable=module-docstring
load("@aspect_bazel_lib//lib:lists.bzl", "map")

def _shellcheck_impl(ctx):
    launcher = ctx.actions.declare_file("%s_shellcheck_launcher.sh" % ctx.attr.name)
    shellcheck = ctx.toolchains["@bzlparty_tools//toolchains:shellcheck_toolchain_type"].binary_info.binary
    ctx.actions.write(
        output = launcher,
        content = "{shellcheck_bin} --format {format} {files}".format(
            shellcheck_bin = shellcheck.path,
            files = " ".join(map(lambda f: f.path, ctx.files.srcs)),
            format = ctx.attr.format or ("tty" if ctx.var.get("COMPILATION_MODE") == "dbg" else "gcc"),
        ),
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([launcher]),
            runfiles = ctx.runfiles(files = [shellcheck] + ctx.files.srcs),
            executable = launcher,
        ),
    ]

shellcheck_test = rule(
    _shellcheck_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".sh", ".bash"]),
        "format": attr.string(mandatory = False),
    },
    toolchains = ["@bzlparty_tools//toolchains:shellcheck_toolchain_type"],
    test = True,
)
