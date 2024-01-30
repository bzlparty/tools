"Patched File"

load("@bazel_skylib//rules:diff_test.bzl", "diff_test")

def patched_file(name, src, patch, out):
    """Apply a patch to a given source file

    > [!NOTE]
    > This is a simple rule that uses the `patch` command from the host system.
    > There is no toolchain that uses a platform specific patching tool.

    Args:
      name: A unique name for the target
      src: Source file
      patch: Patch file
      out: Name for the patched file
    """

    native.genrule(
        name = name,
        outs = [out],
        cmd = "patch --silent --follow-symlinks --output $(OUTS) --input $(location {patch}) $(rootpath {src})".format(src = src, patch = patch),
        srcs = [src, patch],
    )

def patched_file_with_diff_test(name, src, patch, file):
    patched_file(
        name = "%s_patched" % name,
        src = src,
        patch = patch,
        out = "%s.patched" % name,
    )

    diff_test(
        name = "%s_test" % name,
        file1 = file,
        file2 = ":%s_patched" % name,
    )
