"Biome"

def _biome_impl(ctx):
    launcher = ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))
    bin = ctx.toolchains["@bzlparty_tools//toolchains:biome_toolchain_type"].binary_info.binary

    args = []
    if not ctx.attr.testonly:
        args.append("--write")

    ctx.actions.write(
        output = launcher,
        content = """\
#!/usr/bin/env bash

set -o pipefail -o errexit

bin_path=$(realpath "{bin}");
workspace_path=$(dirname "$(realpath "{workspace}")")
cd "$workspace_path"
exec "$bin_path" {mode} {args} --config-path "{config}" .
""".format(
            args = " ".join(args),
            bin = bin.path,
            config = ctx.file.config.path,
            mode = ctx.attr.mode,
            workspace = ctx.file.workspace.path,
        ),
        is_executable = True,
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(files = [bin, ctx.file.workspace, ctx.file.config]),
            executable = launcher,
        ),
    ]

biome = rule(
    _biome_impl,
    attrs = {
        "config": attr.label(allow_single_file = True),
        "workspace": attr.label(default = "//:MODULE.bazel", allow_single_file = True),
        "mode": attr.string(default = "check", values = ["check", "lint"]),
    },
    toolchains = ["@bzlparty_tools//toolchains:biome_toolchain_type"],
    executable = True,
)

_biome_test = rule(
    _biome_impl,
    attrs = {
        "config": attr.label(allow_single_file = True),
        "workspace": attr.label(default = "//:MODULE.bazel", allow_single_file = True),
        "mode": attr.string(default = "check", values = ["check", "lint"]),
    },
    toolchains = ["@bzlparty_tools//toolchains:biome_toolchain_type"],
    test = True,
)

# buildifier: disable=function-docstring
def biome_test(**kwargs):
    if kwargs.get("no_sandbox", True):
        tags = kwargs.get("tags", [])

        for t in ["no-sandbox", "no-cache", "external"]:
            if t not in tags:
                tags.append(t)

        kwargs["tags"] = tags
    _biome_test(**kwargs)
