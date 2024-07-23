"Platforms / private"

load("@platforms//host:constraints.bzl", _HOST_CONSTRAINTS = "HOST_CONSTRAINTS")
load(":helpers.bzl", "platform_from_constraints")

HOST_PLATFORM = platform_from_constraints(_HOST_CONSTRAINTS)
HOST_CONSTRAINTS = _HOST_CONSTRAINTS

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
