"""

# lib

```starlark
load("@bzlparty_tools//lib:defs.bzl", "...")
```

"""

load("//lib/private:sha.bzl", _sha = "sha")
load("//lib/private:shellspec.bzl", _shellspec_test = "shellspec_test")

sha = _sha
shellspec_test = _shellspec_test
