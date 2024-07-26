"Formatter"

load(
    "//lib/private:helpers.bzl",
    "declare_launcher_file",
    "get_binary_from_toolchain",
    "get_target_file",
)
load("//toolchains:external.bzl", "JQ_TOOLCHAIN_TYPE")
load(
    "//toolchains:toolchains.bzl",
    "FD_TOOLCHAIN_TYPE",
    "GOAWK_TOOLCHAIN_TYPE",
)

def _join_exclude_args(items):
    return " ".join(["--exclude \\\"%s\\\"" % i for i in items])

def _parallel_run_impl(ctx):
    fd = get_binary_from_toolchain(ctx, FD_TOOLCHAIN_TYPE)
    goawk = get_binary_from_toolchain(ctx, GOAWK_TOOLCHAIN_TYPE)
    jq = ctx.toolchains[JQ_TOOLCHAIN_TYPE].jqinfo.bin
    launcher = declare_launcher_file(ctx)
    args_file = ctx.actions.declare_file("{}_/{}_args".format(ctx.label.name, ctx.label.name))

    args = ctx.actions.args()
    for k, v in ctx.attr.tools.items():
        args.add("%s:%s" % (v, get_target_file(k).short_path))

    ctx.actions.write(
        output = args_file,
        content = args,
        is_executable = False,
    )

    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        substitutions = {
            "_goawk_": goawk.path,
            "_fd_": fd.path,
            "_exclude_": _join_exclude_args(ctx.attr.exclude),
            "_jq_": jq.path,
            "_config_": ctx.file.config.path,
            "_args_file_": args_file.short_path,
            "_jobs_": "%s" % ctx.attr.jobs,
            "_mode_": ctx.attr.mode,
            "_workspace_": ctx.file.workspace.path,
        },
        is_executable = True,
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(
                [
                    goawk,
                    fd,
                    jq,
                    args_file,
                    ctx.file.config,
                    ctx.file.workspace,
                ] +
                ctx.files.tools,
            ),
            executable = launcher,
        ),
    ]

_ATTRS = {
    "config": attr.label(
        allow_single_file = True,
        mandatory = True,
    ),
    "jobs": attr.int(default = 0),
    "tools": attr.label_keyed_string_dict(
        allow_empty = False,
        allow_files = True,
        mandatory = True,
    ),
    "mode": attr.string(
        default = "check",
        values = ["check", "fix"],
    ),
    "workspace": attr.label(
        default = "@@//:MODULE.bazel",
        allow_single_file = True,
    ),
    "exclude": attr.string_list(default = []),
    "_launcher_template": attr.label(
        default = Label("@bzlparty_tools//lib/private/utils:formatter.sh"),
        allow_single_file = True,
    ),
}

_TOOLCHAINS = [
    FD_TOOLCHAIN_TYPE,
    GOAWK_TOOLCHAIN_TYPE,
    JQ_TOOLCHAIN_TYPE,
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
