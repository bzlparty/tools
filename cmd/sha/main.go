package main

import (
	"crypto"
	_ "crypto/sha1"
	_ "crypto/sha256"
	_ "crypto/sha512"
	"encoding/base64"
	"errors"
	"flag"
	"fmt"
	"hash"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
)

var (
	algo        int
	source_file string
	source_url  string
	write       string
	content     []byte
)

var algos = AlgoList{[]int{1, 256, 384, 512}}

type AlgoList struct {
	List []int
}

func (al *AlgoList) String() string {
	var result string

	for _, a := range al.List {
		result = result + ", " + strconv.Itoa(a)
	}

	return strings.TrimPrefix(result, ", ")
}

func (al *AlgoList) IsSupported(a int) bool {
	for _, b := range al.List {
		if b == a {
			return true
		}
	}
	return false
}

func main() {
	if err := RunApp(); err != nil {
		fmt.Println("App Error:", err.Error())
		os.Exit(2)
	}
}

func RunApp() (err error) {
	shasum, err := generateShaSum(content, algo)

	if err != nil {
		return
	}

	if write != "" {
		if err = os.WriteFile(write, []byte(shasum), 0644); err != nil {
			return
		}
	} else {
		fmt.Print(shasum)
	}

	return
}

func generateShaSum(content []byte, algo int) (string, error) {
	var sha hash.Hash

	switch algo {
	case 1:
		sha = crypto.SHA1.New()
	case 512:
		sha = crypto.SHA512.New()
	case 256:
		sha = crypto.SHA256.New()
	case 384:
		sha = crypto.SHA384.New()
	}

	sha.Write(content)

	return base64.StdEncoding.EncodeToString(sha.Sum(nil)), nil
}

func init() {
	flag.IntVar(&algo, "algo", 384, "shasum algorithm")
	flag.IntVar(&algo, "a", 384, "shasum algorithm (shorthand)")
	flag.StringVar(&source_file, "f", "", "Output file path (optional)")
	flag.StringVar(&source_file, "file", "", "Output file path (shorthand)")
	flag.StringVar(&source_url, "u", "", "Output file path (optional)")
	flag.StringVar(&source_url, "url", "", "Output file path (shorthand)")
	flag.StringVar(&write, "w", "", "Output file path (optional)")
	flag.StringVar(&write, "write", "", "Output file path (shorthand)")
	flag.Usage = func() {
		fmt.Fprintf(os.Stdout, `
Usage:

      %s [options] <file>

Description:

      This program prints the integrity shasum for a given file.

Options:

      -a/-algo        algorithm for integrity, supported: %s (optional, default: 384)
      -f/-file        file to read from (optional, default: stdin)
      -w/-write       file to write (optional, default: stdout)
      -u/-url         url to fetch file from (optional, default: stdin)
      -h/-help
`, os.Args[0], algos.String())
	}
	flag.Parse()
	var err error

	if source_file != "" {
		content, err = os.ReadFile(source_file)
		handleInitError(err)
	}

	if source_url != "" {
		response, err := http.Get(source_url)
		handleInitError(err)
		defer response.Body.Close()
		if response.StatusCode == http.StatusOK {
			content, err = io.ReadAll(response.Body)
			handleInitError(err)
		} else {
			handleInitError(errors.New("Bad Request"))
		}
	}
}

func handleInitError(err error) {
	if err != nil {
		fmt.Println("Init Error:", err.Error())
		os.Exit(1)
	}
}
