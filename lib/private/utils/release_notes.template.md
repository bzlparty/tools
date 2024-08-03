## Installation

> [!IMPORTANT]  
> Installation is only supported via Bzlmod!

Choose from the options below and put as dependency in your `MODULE.bazel`.

### Install from BCR

```starlark
bazel_dep(name = "bzlparty_%NAME%", version = "%VERSION%")
```

### Install from Archive

```starlark
bazel_dep(name = "bzlparty_%NAME%")

archive_override(
    module_name = "bzlparty_%NAME%",
    urls = "https://github.com/bzlparty/%PROJECT%/releases/download/%TAG%/%NAME%-%TAG%.tar.gz",
    strip_prefix = "%NAME%-%VERSION%",
    integrity = "sha384-%INTEGRITY%",
)
```
