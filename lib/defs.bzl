"""

# lib


"""

load(":diff.bzl", _diff = "diff")
load(":http.bzl", _http_binary = "http_binary")
load(":jql.bzl", _jql_test = "jql_test")
load(":platform_binary.bzl", _platform_binaries = "platform_binaries", _platform_binary = "platform_binary")

diff = _diff
http_binary = _http_binary
jql_test = _jql_test
platform_binary = _platform_binary
platform_binaries = _platform_binaries
