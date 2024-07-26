"Assets Bundle"

load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_file")
load(
    "//lib/private:helpers.bzl",
    "get_binary_from_toolchain",
    "write_executable_launcher_file",
)
load("//toolchains:external.bzl", "BUILDIFIER_TOOLCHAIN_TYPE", "JQ_TOOLCHAIN_TYPE")
load("//toolchains:toolchains.bzl", "TEMPL_TOOLCHAIN_TYPE")

def _assets_bundle_impl(ctx):
    out = ctx.outputs.out
    jq = ctx.toolchains[JQ_TOOLCHAIN_TYPE].jqinfo.bin
    buildifier = ctx.toolchains[BUILDIFIER_TOOLCHAIN_TYPE]._tool
    templ = get_binary_from_toolchain(ctx, TEMPL_TOOLCHAIN_TYPE)
    script = write_executable_launcher_file(
        ctx,
        content = """\
#!/usr/bin/env bash
{jq} -s '.' $@ |
{templ} -template assets |
{buildifier} -mode fix -lint fix > {out}
""".format(
            templ = templ.path,
            jq = jq.path,
            out = out.path,
            buildifier = buildifier.path,
        ),
    )

    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [out],
        arguments = [args],
        tools = [jq, templ, buildifier],
        executable = script,
    )

    return [
        DefaultInfo(
            files = depset([out]),
        ),
    ]

_assets_bundle = rule(
    _assets_bundle_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_empty = False,
            allow_files = True,
            mandatory = True,
        ),
        "out": attr.output(mandatory = True),
    },
    toolchains = [
        BUILDIFIER_TOOLCHAIN_TYPE,
        JQ_TOOLCHAIN_TYPE,
        TEMPL_TOOLCHAIN_TYPE,
    ],
)

def assets_bundle(name = "assets", out_file = None, write_file = True, **kwargs):
    _assets_bundle(
        name = name,
        out = "%s_bzl" % name,
        **kwargs
    )

    if write_file:
        write_source_file(
            name = "update_%s" % name,
            in_file = "%s_bzl" % name,
            out_file = out_file or ":%s.bzl" % name,
        )
