BEGIN {
  FS = " "
  print "ASSETS = {"
}

{
  print "    \"" $1 "\": struct(binary = \"" $3 "\", url = \"" $2 "\", integrity = \"sha" $4 "-" $5 "\"),"
}

END {
  print "}"
}
