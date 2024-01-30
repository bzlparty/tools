"Patched File"

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
