BEGIN {
  skip=1
  exclude = line = 1;
}

/# release:exclude/ {
  skip = 0;
  exclude = line = 1; next
}

/# release:include/ {
  skip = 0;
  exclude = line = 0; next
}

skip==1 {
  print $0; next
}

/# exclude \{/ {
  line = 0; next
}

/# include \{/ {
  line = 1; next
}

/# \}/ {
  line = exclude; next
}

line
