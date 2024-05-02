BEGIN {
  print "# buildifier: disable=module-docstring"
  print "load(\"//lib:toolchains.bzl\", \"resolved_toolchain_impl\")"
}

{
  print "load(\"//toolchains/" $0 ":assets.bzl\", " toupper($0) "_ASSETS = \"ASSETS\")"
}

END {
  print ""
}
