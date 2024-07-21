package main

import (
	"encoding/json"
	"errors"
	"flag"
	"log"
	"os"
	"strings"
	"text/template"
)

var templateId string
var funcMap = template.FuncMap{
  "last": func(index int, length int) bool {
    if index == (length - 1) {
      return true
    }
    return false
  },
  "ToUpper": strings.ToUpper,
}

func main() {
  flag.StringVar(&templateId, "template", "", "Template id")
  flag.Parse()
  switch(templateId) {
  case "assets":
    execute[Assets](templateId, AssetsTemplate)
  case "tools":
    execute[[]string](templateId, ToolsTemplate)
  case "toolchains":
    execute[[]string](templateId, ToolchainsTemplate)
  default:
    log.Fatal(errors.New("Unknown template"))
  }
}

func execute[T []string | Assets](id string, templateString string) {
  var records T
	check(json.NewDecoder(os.Stdin).Decode(&records))

	tmpl, err := template.New(id).Funcs(funcMap).Parse(templateString)

	check(err)

	check(tmpl.Execute(os.Stdout, records))
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
