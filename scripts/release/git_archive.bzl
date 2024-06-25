"Create a tarball with `git archive`"

def _get_target_path(f):
    b = f.basename
    if b.startswith("root_"):
        return b.split("_").pop()
    return b.replace("_", "/")

def _git_archive_impl(ctx):
    launcher = ctx.actions.declare_file("{name}_/{name}.sh".format(name = ctx.attr.name))
    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        is_executable = True,
        substitutions = {
            "%NAME%": "tools",
            "%VIRTUAL_FILES%": " ".join([
                """--add-virtual-file="$PREFIX/%s":"$(< "%s")" """ % (_get_target_path(f), f.path)
                for f in ctx.files.data
            ]),
        },
    )

    runfiles = ctx.runfiles(files = ctx.files.data)

    return [
        DefaultInfo(
            files = depset([launcher]),
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

git_archive = rule(
    _git_archive_impl,
    attrs = {
        "data": attr.label_list(default = [], allow_files = True),
        "_launcher_template": attr.label(default = Label("//scripts/release:git_archive.sh"), allow_single_file = True),
    },
    executable = True,
)
