"Default platform mapping and helpers"

load("@local_config_platform//:constraints.bzl", "HOST_CONSTRAINTS")

PLATFORMS = {
    "linux_amd64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
    "linux_arm64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
    "freebsd_amd64": ["@platforms//os:freebsd", "@platforms//cpu:x86_64"],
    "freebsd_arm64": ["@platforms//os:freebsd", "@platforms//cpu:arm64"],
    "windows_amd64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
    "windows_arm64": ["@platforms//os:windows", "@platforms//cpu:arm64"],
    "darwin_amd64": ["@platforms//os:macos", "@platforms//cpu:x86_64"],
    "darwin_arm64": ["@platforms//os:macos", "@platforms//cpu:arm64"],
}

def is_darwin(platform):
    return platform.startswith("darwin")

def is_freebsd(platform):
    return platform.startswith("freebsd")

def is_linux(platform):
    return platform.startswith("linux")

def is_windows(platform):
    return platform.startswith("windows")

def is_amd64(platform):
    return platform.endswith("amd64") or platform.endswith("x86_64")

def _switch(m, default = None):
    for (k, r) in m.items():
        if r:
            return k
    return default

def _platform_from_host_constraints():
    os = ""
    arch = ""
    for hc in HOST_CONSTRAINTS:
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

host_platform = _platform_from_host_constraints()
