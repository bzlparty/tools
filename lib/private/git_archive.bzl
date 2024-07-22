"Create a tarball with `git archive`"

load("//toolchains:toolchains.bzl", "SHA_TOOLCHAIN_TYPE")
load(":utils.bzl", "declare_launcher_file", "get_binary_from_toolchain", "get_target_file")

def _format_virtual_file_arg(target, path):
    return """--add-virtual-file="$PREFIX/{path}":"$(< "{source}")" """.format(
        path = path,
        source = get_target_file(target).path,
    )

def _git_archive_impl(ctx):
    launcher = declare_launcher_file(ctx)
    sha = get_binary_from_toolchain(ctx, SHA_TOOLCHAIN_TYPE)
    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        is_executable = True,
        substitutions = {
            "%NAME%": ctx.attr.package_name,
            "%SHA%": sha.short_path,
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
        "virtual_files": attr.label_keyed_string_dict(
            default = {},
            allow_files = True,
        ),
        "_launcher_template": attr.label(
            default = Label("@bzlparty_tools//lib/private:git_archive.sh"),
            allow_single_file = True,
        ),
    },
    toolchains = [SHA_TOOLCHAIN_TYPE],
    executable = True,
)
