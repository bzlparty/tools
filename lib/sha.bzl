"Sha"

def _sha_impl(ctx):
    sha = ctx.toolchains["@bzlparty_tools//toolchains:sha_toolchain_type"].binary_info.binary
    sha_launcher = ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))
    if ctx.outputs.out:
        out = ctx.outputs.out
    else:
        out = ctx.actions.declare_file("%s.sha%s" % (ctx.file.src.basename, ctx.attr.algo))

    ctx.actions.write(
        output = sha_launcher,
        content = """
./{sha} $@ < {src}
""".format(
            sha = sha.path,
            src = ctx.file.src.path,
        ),
        is_executable = True,
    )

    args = ctx.actions.args()
    args.add("-algo", ctx.attr.algo)
    args.add("-write", out)

    ctx.actions.run(
        outputs = [out],
        inputs = [ctx.file.src],
        executable = sha_launcher,
        arguments = [args],
        tools = [sha],
    )

    return [
        DefaultInfo(
            files = depset([out]),
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
