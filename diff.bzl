"Create and Update Patches"

load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_files")

def diff(name, source, target, input = None):
    """Create a patch file from `source` and `target` files.

    > [!NOTE]
    > This is a simple rule that uses the `diff` command from the host system.
    > There is no toolchain that uses a platform specific tool.

    Args:
      name: A unique name for the target.
      source: Source file to create the patch for.
      target: Target file to compare the `source` to.
      input: Input patch file, optional. Defaults to a file named like the rule with the `patch` extension, e.g. `module_bazel.patch`.
    """
    diff_name = name + "_diff"
    output = diff_name + ".patch"
    native.genrule(
        name = diff_name,
        outs = [output],
        srcs = [source, target],
        cmd = "diff --text --unified --label=$(location {}) --label=$(location {}) $(SRCS) > $(OUTS) || true".format(source, target),
    )

    # This file group is used to know the right files in `update_patches`.
    native.filegroup(
        name = name,
        srcs = [input or name + ".patch", output],
    )

def update_patches(name = "update_patches", **kwargs):
    """Macro to update all patch files in a package.

    Args:
      name: A unique name for the target.
      **kwargs: All other arguments from [`write_source_files`](https://github.com/aspect-build/bazel-lib/blob/main/docs/write_source_files.md#write_source_files)
    """

    files = {}
    for r in native.existing_rules().values():
        if r.get("generator_function") == "diff" and r.get("name") == r.get("generator_name"):
            (input, output) = r.get("srcs")
            files[input] = output

    write_source_files(
        name = name,
        files = files,
        **kwargs
    )
