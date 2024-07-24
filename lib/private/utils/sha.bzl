"Sha"

load(
    "//lib/private:helpers.bzl",
    "get_binary_from_toolchain",
)
load("//toolchains:toolchains.bzl", "SHA_TOOLCHAIN_TYPE")

def _sha_impl(ctx):
    sha = get_binary_from_toolchain(ctx, SHA_TOOLCHAIN_TYPE)
    args = ctx.actions.args()
    args.add("-algo", ctx.attr.algo)
    if ctx.attr.url:
        args.add("-url", ctx.attr.url)
    else:
        args.add("-file", ctx.file.src)

    if ctx.outputs.out:
        out = ctx.outputs.out
    else:
        out = ctx.actions.declare_file("%s.sha%s" % (ctx.file.src.basename if ctx.file.src else ctx.label.name, ctx.attr.algo))

    args.add("-write", out)

    ctx.actions.run(
        outputs = [out],
        inputs = [ctx.file.src] if ctx.file.src else [],
        executable = sha,
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
