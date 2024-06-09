"Sha"

def _sha_impl(ctx):
    if ctx.outputs.out:
        out = ctx.outputs.out
    else:
        out = ctx.actions.declare_file("%s.sha%s" % (ctx.file.src.basename, ctx.attr.algo))

    ctx.actions.run_shell(
        outputs = [out],
        inputs = [ctx.file.src],
        command = """
{sha} {src} > {target}
""".format(
            sha = ctx.file._sha.path,
            src = ctx.file.src.path,
            target = out.path,
        ),
        tools = [ctx.file._sha],
    )

    return [
        DefaultInfo(
            files = depset([out]),
            runfiles = ctx.runfiles([ctx.file.src, ctx.file._sha]),
        ),
    ]

sha = rule(
    _sha_impl,
    attrs = {
        "src": attr.label(mandatory = False, allow_single_file = True),
        "algo": attr.string(default = "384", values = ["1", "224", "256", "384", "512", "512224", "512256"]),
        "out": attr.output(mandatory = False),
        "_sha": attr.label(default = "@bzlparty_tools//sh:sha.bash", allow_single_file = True),
    },
)
