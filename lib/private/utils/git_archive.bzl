"Create a tarball with `git archive`"

load(
    "//lib/private:helpers.bzl",
    "TagInfo",
    "declare_launcher_file",
    "get_binary_from_toolchain",
    "get_target_file",
)
load("//toolchains:toolchains.bzl", "SHA_TOOLCHAIN_TYPE")

def _format_virtual_file_arg(target, path, prefix):
    return """--add-virtual-file="{prefix}/{path}":"$(< "{source}")" """.format(
        path = path,
        prefix = prefix,
        source = get_target_file(target).path,
    )

def _git_archive_impl(ctx):
    launcher = declare_launcher_file(ctx)
    sha = get_binary_from_toolchain(ctx, SHA_TOOLCHAIN_TYPE)
    commit = ctx.attr.commit[TagInfo].value
    version = commit if not commit.startswith("v") else commit[1:]
    prefix = "%s-%s" % (ctx.attr.package_name, version)
    ctx.actions.expand_template(
        template = ctx.file._launcher_template,
        output = launcher,
        is_executable = True,
        substitutions = {
            "%NAME%": ctx.attr.package_name,
            "%SHA%": sha.short_path,
            "%COMMIT%": commit,
            "%VERSION%": version,
            "%VIRTUAL_FILES%": " ".join([
                _format_virtual_file_arg(file, path, prefix)
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

_ATTRS = {
    "package_name": attr.string(mandatory = True),
    "virtual_files": attr.label_keyed_string_dict(
        default = {},
        allow_files = True,
    ),
    "commit": attr.label(mandatory = True),
    "_launcher_template": attr.label(
        default = Label("@bzlparty_tools//lib/private/utils:git_archive.sh"),
        allow_single_file = True,
    ),
}

git_archive = rule(
    _git_archive_impl,
    attrs = _ATTRS,
    toolchains = [SHA_TOOLCHAIN_TYPE],
    executable = True,
)
