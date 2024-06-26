"""
# Platforms 

Default platform mappings and helpers
"""

PLATFORMS = {
    "darwin_amd64": ["@platforms//os:macos", "@platforms//cpu:x86_64"],
    "darwin_arm64": ["@platforms//os:macos", "@platforms//cpu:arm64"],
    "freebsd_amd64": ["@platforms//os:freebsd", "@platforms//cpu:x86_64"],
    "freebsd_arm64": ["@platforms//os:freebsd", "@platforms//cpu:arm64"],
    "linux_amd64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
    "linux_arm64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
    "netbsd_amd64": ["@platforms//os:netbsd", "@platforms//cpu:x86_64"],
    "netbsd_arm64": ["@platforms//os:netbsd", "@platforms//cpu:arm64"],
    "windows_amd64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
    "windows_arm64": ["@platforms//os:windows", "@platforms//cpu:arm64"],
}

GO_PLATFORMS = [
    p.split("_")
    for p in PLATFORMS.keys()
]

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
