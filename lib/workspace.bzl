"""
Workspace Rules

Some rules that are used for maintaining other bzlparty projects.

"""

load(
    "//lib/private:create_module_bazel.bzl",
    _create_module_bazel = "create_module_bazel",
)
load(
    "//lib/private:formatter.bzl",
    _formatter = "formatter",
    _formatter_test = "formatter_test",
)
load("//lib/private:git_archive.bzl", _git_archive = "git_archive")

formatter = _formatter
formatter_test = _formatter_test
git_archive = _git_archive
create_module_bazel = _create_module_bazel
