{
  print toupper($0) "_TOOLCHAIN_TYPE = \"@bzlparty_tools//toolchains:" $0 "_toolchain_type\""
  print ""
  print $0 "_resolved_toolchain = rule("
  print "    implementation = resolved_toolchain_impl(" toupper($0) "_TOOLCHAIN_TYPE),"
  print "    toolchains = [" toupper($0) "_TOOLCHAIN_TYPE],"
  print "    incompatible_use_toolchain_transition = True,"
  print ")"
  print ""
}
