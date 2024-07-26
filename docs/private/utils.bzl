"""

# Rules

"""

load(
    "//lib:defs.bzl",
    _formatter = "formatter",
    _formatter_test = "formatter_test",
    _git_archive = "git_archive",
    _sha = "sha",
    _shellspec_test = "shellspec_test",
    _versioned_module_bazel = "versioned_module_bazel",
)

formatter = _formatter
formatter_test = _formatter_test
git_archive = _git_archive
versioned_module_bazel = _versioned_module_bazel

sha = _sha
shellspec_test = _shellspec_test
