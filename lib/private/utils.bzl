"Utils for rules"

def declare_launcher_file(ctx):
    return ctx.actions.declare_file("{}_/{}".format(ctx.label.name, ctx.label.name))

def get_binary_from_toolchain(ctx, toolchain):
    if toolchain not in ctx.toolchains:
        fail("%s is not included in toolchains")
    return ctx.toolchains[toolchain].binary_info.binary

def is_darwin(platform):
    return platform.startswith("darwin") or platform.startswith("macos")

def is_freebsd(platform):
    return platform.startswith("freebsd")

def is_netbsd(platform):
    return platform.startswith("netbsd")

def is_linux(platform):
    return platform.startswith("linux")

def is_windows(platform):
    return platform.startswith("windows")

def is_amd64(platform):
    return platform.endswith("amd64") or platform.endswith("x86_64")

def host_platform(ctx):
    return "%s_%s" % (ctx.os.name, ctx.os.arch)

platform_utils = struct()

def _switch(m, default = None):
    for (k, r) in m.items():
        if r:
            return k
    return default

def platform_from_constraints(constraints):
    """Get platform from constraints

    Args:
      constraints: list of platform constraints, e.g. `["@platforms//os:linux", "@platforms//cpu:x86_64"]`.

    Returns:
      platform string, e.g. `linux_amd64`.
    """

    os = ""
    arch = ""
    for hc in constraints:
        target = hc.split(":").pop()
        os = _switch({
            "darwin": is_darwin(target),
            "windows": is_windows(target),
            "linux": is_linux(target),
            "freebsd": is_freebsd(target),
        }, os)
        arch = _switch({
            "amd64": is_amd64(target),
        }, arch)

    return "%s_%s" % (os, arch)
