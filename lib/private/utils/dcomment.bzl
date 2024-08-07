"Dcomment"

load("//toolchains:external.bzl", "BUILDIFIER_TOOLCHAIN_TYPE")

def _dcomment_impl(ctx):
    temp = ctx.actions.declare_file("{}_/{}.temp".format(ctx.label.name, ctx.label.name))
    dcomment_launcher = ctx.actions.declare_file("{}_/{}_dcomment_launcher.sh".format(ctx.label.name, ctx.label.name))
    ctx.actions.expand_template(
        template = ctx.file._dcomment_launcher_template,
        output = dcomment_launcher,
        substitutions = {
            "%DCOMMENT%": ctx.file._dcomment.path,
        },
        is_executable = True,
    )
    dcomment_args = ctx.actions.args()
    dcomment_args.add_all(ctx.attr.defines, format_each = "-d %s")
    dcomment_args.add(ctx.file.src)
    dcomment_args.add(temp)

    ctx.actions.run(
        inputs = [ctx.file.src],
        arguments = [dcomment_args],
        outputs = [temp],
        executable = dcomment_launcher,
        tools = [ctx.file._dcomment],
        toolchain = None,
    )

    buildifier = ctx.toolchains[BUILDIFIER_TOOLCHAIN_TYPE]._tool
    buildifier_args = ctx.actions.args()
    buildifier_args.add("-mode", "fix")
    buildifier_args.add("-lint", "fix")

    ctx.actions.run_shell(
        inputs = [temp],
        command = "{} $@ > {} < {}".format(buildifier.path, ctx.outputs.out.path, temp.path),
        arguments = [buildifier_args],
        outputs = [ctx.outputs.out],
        tools = [buildifier],
        toolchain = BUILDIFIER_TOOLCHAIN_TYPE,
    )

_ATTRS = {
    "out": attr.output(mandatory = True),
    "src": attr.label(
        mandatory = True,
        allow_single_file = True,
    ),
    "defines": attr.string_list(default = []),
    "_dcomment_launcher_template": attr.label(
        default = "@bzlparty_tools//lib/private/utils:dcomment.sh",
        allow_single_file = True,
    ),
    "_dcomment": attr.label(
        default = "@bzlparty_tools//vendor/dcomment",
        allow_single_file = True,
    ),
}

_TOOLCHAINS = [
    BUILDIFIER_TOOLCHAIN_TYPE,
]

dcomment = rule(
    _dcomment_impl,
    attrs = _ATTRS,
    toolchains = _TOOLCHAINS,
)
