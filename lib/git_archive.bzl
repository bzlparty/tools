"Create a tarball with `git archive`"

def _get_target_file_path(target):
    if DefaultInfo in target:
        return target[DefaultInfo].files.to_list().pop().path
    fail("Cannot get file path")

def _format_virtual_file_arg(file, path):
    return """--add-virtual-file="$PREFIX/%s":"$(< "%s")" """ % (path, _get_target_file_path(file))

def _git_archive_impl(ctx):
    launcher = ctx.actions.declare_file("{name}_/{name}.sh".format(name = ctx.attr.name))
    sha = ctx.toolchains["@bzlparty_tools//toolchains:sha_toolchain_type"].binary_info.binary
    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        is_executable = True,
        substitutions = {
            "%NAME%": ctx.attr.package_name,
            "%SHA%": sha.path,
            "%VIRTUAL_FILES%": " ".join([
                _format_virtual_file_arg(file, path)
                for (file, path) in ctx.attr.virtual_files.items()
            ]),
        },
    )

    runfiles = ctx.runfiles(files = ctx.files.virtual_files + [sha])

    return [
        DefaultInfo(
            runfiles = runfiles,
            executable = launcher,
        ),
    ]

git_archive = rule(
    _git_archive_impl,
    attrs = {
        "package_name": attr.string(mandatory = True),
        "virtual_files": attr.label_keyed_string_dict(default = {}, allow_files = True),
        "_launcher_template": attr.label(default = Label("@bzlparty_tools//lib:git_archive.sh"), allow_single_file = True),
    },
    toolchains = ["@bzlparty_tools//toolchains:sha_toolchain_type"],
    executable = True,
)
