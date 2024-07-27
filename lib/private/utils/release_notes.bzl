"Rule to generate release notes"

load(
    "//lib/private:helpers.bzl",
    "TagInfo",
    "write_executable_launcher_file",
)

def _release_notes(ctx):
    tag = ctx.attr.tag[TagInfo].value
    dir = ctx.attr.dir[TagInfo].value
    temp = ctx.actions.declare_file("{}_/{}_temp".format(ctx.label.name, ctx.label.name))
    version = tag
    if version.startswith("v"):
        version = version[1:]
    ctx.actions.expand_template(
        output = temp,
        template = ctx.file._template,
        substitutions = {
            "%NAME%": ctx.attr.package,
            "%PROJECT%": ctx.attr.project or ctx.attr.package,
            "%VERSION%": version,
            "%TAG%": tag,
        },
        is_executable = False,
    )

    launcher = write_executable_launcher_file(
        ctx,
        content = """\
sed "s|%INTEGRITY%|$(< {dir}/{name}-{tag}.tar.gz.sha384)|" {temp} > "{dir}/release_notes.md"
cat >> "{dir}/release_notes.md" <<EOF

## Checksums

$(for path in {dir}/*.sha384; do
    sha_file=$(basename $path);
    target_file=${{sha_file%.*}};
    echo "- **$target_file** sha384-$(< $path)"
done)
EOF
""".format(
            name = ctx.attr.package,
            dir = dir,
            tag = tag,
            temp = temp.short_path,
        ),
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles([temp]),
            executable = launcher,
        ),
    ]

_ATTRS = {
    "project": attr.string(mandatory = False),
    "package": attr.string(mandatory = True),
    "tag": attr.label(default = "@bzlparty_tools//lib:release_tag"),
    "dir": attr.label(default = "@bzlparty_tools//lib:release_dir"),
    "_template": attr.label(
        default = "@bzlparty_tools//lib/private/utils:release_notes.template.md",
        allow_single_file = True,
    ),
}

release_notes = rule(
    _release_notes,
    attrs = _ATTRS,
    executable = True,
)
