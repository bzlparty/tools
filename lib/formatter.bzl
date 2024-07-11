"Formatter"

def _get_target_file_path(target):
    if DefaultInfo in target:
        f = target[DefaultInfo].files.to_list().pop()
        return f.short_path
    fail("Cannot get file path")

def _parallel_run_impl(ctx):
    goawk = ctx.toolchains["@bzlparty_tools//toolchains:goawk_toolchain_type"].binary_info.binary
    fd = ctx.toolchains["@bzlparty_tools//toolchains:fd_toolchain_type"].binary_info.binary
    jq = ctx.toolchains["@aspect_bazel_lib//lib:jq_toolchain_type"].jqinfo.bin
    launcher = ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))
    args_file = ctx.actions.declare_file("{}_/{}_args".format(ctx.label.name, ctx.label.name))

    ctx.actions.write(
        output = args_file,
        content = "\n".join(["%s:%s" % (v, _get_target_file_path(k)) for k, v in ctx.attr.tools.items()]),
        is_executable = False,
    )

    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        substitutions = {
            "_goawk_": goawk.path,
            "_fd_": fd.path,
            "_exclude_": " ".join(["--exclude \\\"%s\\\"" % i for i in ctx.attr.exclude]),
            "_jq_": jq.path,
            "_config_": ctx.file.config.path,
            "_args_file_": args_file.short_path,
            "_jobs_": "4",
            "_mode_": ctx.attr.mode,
            "_workspace_": ctx.file.workspace.path,
        },
        is_executable = True,
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles([goawk, fd, jq, args_file, ctx.file.config, ctx.file.workspace] + ctx.files.tools),
            executable = launcher,
        ),
    ]

_ATTRS = {
    "config": attr.label(allow_single_file = True, mandatory = True),
    "tools": attr.label_keyed_string_dict(allow_empty = False, allow_files = True, mandatory = True),
    "mode": attr.string(default = "check", values = ["check", "fix"]),
    "workspace": attr.label(default = "@@//:MODULE.bazel", allow_single_file = True),
    "exclude": attr.string_list(default = []),
    "_launcher_template": attr.label(default = Label("@bzlparty_tools//lib:formatter.sh"), allow_single_file = True),
}

_TOOLCHAINS = [
    "@bzlparty_tools//toolchains:goawk_toolchain_type",
    "@bzlparty_tools//toolchains:fd_toolchain_type",
    "@aspect_bazel_lib//lib:jq_toolchain_type",
]

formatter = rule(
    _parallel_run_impl,
    attrs = _ATTRS,
    toolchains = _TOOLCHAINS,
    executable = True,
)

formatter_test = rule(
    _parallel_run_impl,
    attrs = _ATTRS,
    toolchains = _TOOLCHAINS,
    test = True,
)
