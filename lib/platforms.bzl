"Default platform mapping and helpers"

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
