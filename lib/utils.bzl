"Utils"

load(":constants.bzl", "BAZEL_ARCHIVE_EXTENSIONS")

def is_extractable_archive(name):
    for f in BAZEL_ARCHIVE_EXTENSIONS:
        if name.endswith(f):
            return True
    return False
