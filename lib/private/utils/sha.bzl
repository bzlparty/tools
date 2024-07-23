"Sha"

load(
    "//lib/private:helpers.bzl",
    "get_binary_from_toolchain",
    "write_executable_launcher_file",
)
load("//toolchains:toolchains.bzl", "SHA_TOOLCHAIN_TYPE")

def _sha_impl(ctx):
    sha = get_binary_from_toolchain(ctx, SHA_TOOLCHAIN_TYPE)
    launcher = write_executable_launcher_file(
        ctx,
        content = """
./{sha} $@ {src}
""".format(
            sha = sha.path,
            src = ctx.attr.url if hasattr(ctx.attr, "url") else ctx.file.src.path,
        ),
    )

    if ctx.outputs.out:
        out = ctx.outputs.out
    else:
        out = ctx.actions.declare_file("%s.sha%s" % (ctx.file.src.basename if ctx.file.src else ctx.label.name, ctx.attr.algo))

    args = ctx.actions.args()
    args.add("-algo", ctx.attr.algo)
    args.add("-write", out)

    ctx.actions.run(
        outputs = [out],
        inputs = [ctx.file.src] if ctx.file.src else [],
        executable = launcher,
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
        "url": attr.string(mandatory = False),
    },
    toolchains = [SHA_TOOLCHAIN_TYPE],
)
