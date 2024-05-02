BEGIN {
  print "# buildifier: disable=function-docstring"
  print "def all_toolchains(name = \"all_toolchains\"):"
}

{
  print "    native.toolchain_type("
  print "        name = \"" $0 "_toolchain_type\","
  print "        visibility = [\"//visibility:public\"],"
  print "    )"
  print "    " $0 "_resolved_toolchain("
  print "        name = \"" $0 "\","
  print "        visibility = [\"//visibility:public\"],"
  print "    )"
}