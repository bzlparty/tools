# buildifier: disable=module-docstring
def _typos_impl(ctx):
    output = ctx.actions.declare_file("%s.bash" % ctx.attr.name)
    typos = ctx.toolchains["@bzlparty_tools//toolchains:typos_toolchain_type"].binary_info.binary
    ctx.actions.write(
        output = output,
        content = """\
#!/usr/bin/env bash

set -o pipefail -o errexit

typos_bin=$(realpath "{path}");
workspace=$(dirname "$(realpath "{workspace}")")

eval "$typos_bin $workspace"
""".format(
            path = typos.path,
            workspace = ctx.file.workspace.path,
        ),
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([output]),
            runfiles = ctx.runfiles(files = [typos, ctx.file.workspace]),
            executable = output,
        ),
    ]

_typos_test = rule(
    _typos_impl,
    attrs = {
        "workspace": attr.label(allow_single_file = True, default = Label("//:MODULE.bazel")),
    },
    toolchains = ["@bzlparty_tools//toolchains:typos_toolchain_type"],
    test = True,
)

# buildifier: disable=function-docstring
def typos_test(**kwargs):
    if kwargs.get("no_sandbox", True):
        tags = kwargs.get("tags", [])

        for t in ["no-sandbox", "no-cache", "external"]:
            if t not in tags:
                tags.append(t)

        kwargs["tags"] = tags
    _typos_test(**kwargs)
