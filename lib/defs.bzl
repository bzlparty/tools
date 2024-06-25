"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load(":jql.bzl", _jql_test = "jql_test")
load(
    ":platform_binary.bzl",
    _platform_binaries = "platform_binaries",
    _platform_binary = "platform_binary",
)
load(
    ":platforms.bzl",
    _host_platform = "host_platform",
    _is_amd64 = "is_amd64",
    _is_darwin = "is_darwin",
    _is_freebsd = "is_freebsd",
    _is_netbsd = "is_netbsd",
    _is_windows = "is_windows",
)

jql_test = _jql_test
platform_binary = _platform_binary
platform_binaries = _platform_binaries
host_platform = _host_platform
is_amd64 = _is_amd64
is_darwin = _is_darwin
is_freebsd = _is_freebsd
is_netbsd = _is_netbsd
is_windows = _is_windows
