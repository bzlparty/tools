"Dcomment"

def _dcomment_impl(ctx):
    args = ctx.actions.args()
    args.add("-d", ctx.attr.defines)
    args.add(ctx.file.src)
    args.add(ctx.outputs.out)

    ctx.actions.run(
        inputs = [ctx.file.src],
        arguments = [args],
        outputs = [ctx.outputs.out],
        executable = ctx.file._dcomment,
    )

_ATTRS = {
    "out": attr.output(mandatory = True),
    "src": attr.label(
        mandatory = True,
        allow_single_file = True,
    ),
    "defines": attr.string(),
    "_dcomment": attr.label(
        default = "@bzlparty_tools//vendor/dcomment",
        allow_single_file = True,
    ),
}

dcomment = rule(
    _dcomment_impl,
    attrs = _ATTRS,
)
