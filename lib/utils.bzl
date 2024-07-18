"# Utils"

load(
    "//lib/private:utils.bzl",
    _declare_launcher_file = "declare_launcher_file",
    _get_binary_from_toolchain = "get_binary_from_toolchain",
    _platform_from_constraints = "platform_from_constraints",
)

declare_launcher_file = _declare_launcher_file
get_binary_from_toolchain = _get_binary_from_toolchain
platform_from_constraints = _platform_from_constraints
