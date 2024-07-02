BEGIN {
  FS = ","
  print "ASSETS = {"
}

{
  print "    \"" $2 "\": struct(url = \"" $3 "\", binary = \"" $4 "\", integrity = \"" $5"\"),"
}

END {
  print "}"
}
