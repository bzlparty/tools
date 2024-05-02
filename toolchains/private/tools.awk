BEGIN {
  print "TOOLS = {"
}

{
  print "    \"" $0 "\": " toupper($0) "_ASSETS,"
}

END {
  print "}"
  print ""
}
