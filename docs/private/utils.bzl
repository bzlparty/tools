"""

# Rules

"""

load(
    "//lib:defs.bzl",
    _create_module_bazel = "create_module_bazel",
    _formatter = "formatter",
    _formatter_test = "formatter_test",
    _git_archive = "git_archive",
    _sha = "sha",
    _shellspec_test = "shellspec_test",
)

formatter = _formatter
formatter_test = _formatter_test
git_archive = _git_archive
create_module_bazel = _create_module_bazel

sha = _sha
shellspec_test = _shellspec_test
