"Sha"

def _sha_impl(ctx):
    sha = ctx.toolchains["@bzlparty_tools//toolchains:sha_toolchain_type"].binary_info.binary
    if ctx.outputs.out:
        out = ctx.outputs.out
    else:
        out = ctx.actions.declare_file("%s.sha%s" % (ctx.file.src.basename, ctx.attr.algo))

    ctx.actions.run_shell(
        outputs = [out],
        inputs = [ctx.file.src],
        command = """
{sha} -a {algo} {src} > {target}
""".format(
            sha = sha.path,
            algo = ctx.attr.algo,
            src = ctx.file.src.path,
            target = out.path,
        ),
        tools = [sha],
    )

    return [
        DefaultInfo(
            files = depset([out]),
            # runfiles = ctx.runfiles([ctx.file.src, ctx.file._sha]),
        ),
    ]

sha = rule(
    _sha_impl,
    attrs = {
        "algo": attr.string(default = "384", values = ["1", "224", "256", "384", "512", "512224", "512256"]),
        "out": attr.output(mandatory = False),
        "src": attr.label(mandatory = False, allow_single_file = True),
    },
    toolchains = ["@bzlparty_tools//toolchains:sha_toolchain_type"],
)
