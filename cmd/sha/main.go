package main

import (
	"crypto"
	_ "crypto/sha1"
	_ "crypto/sha256"
	_ "crypto/sha512"
	"encoding/base64"
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
	algo    int
	write   string
	content []byte
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
	flag.StringVar(&write, "w", "", "Output file path (optional)")
	flag.StringVar(&write, "write", "", "Output file path (shorthand)")
	flag.Usage = func() {
		fmt.Fprintf(os.Stdout, `
Usage:

      %s [options] <file>

Description:

      This program prints the integrity shasum for a given file.

Options:

      -a, --algo        algorithm for integrity, supported: %s (optional, default: 384)
      -w, --write       file to write (optional, default: stdout)
      -h, --help
`, os.Args[0], algos.String())
	}
	flag.Parse()
	var input = flag.Arg(0)
	var err error

	if input == "" {
		content, err = io.ReadAll(os.Stdin)
		handleInitError(err)
	} else {
		// Try to read input as file
		content, err = os.ReadFile(input)
		if err != nil {
			// Try to get input as request
			response, err := http.Get(input)
			handleInitError(err)
			defer response.Body.Close()
			if response.StatusCode == http.StatusOK {
				content, err = io.ReadAll(response.Body)
				handleInitError(err)
			}
		}

	}
}

func handleInitError(err error) {
	if err != nil {
		fmt.Println("Init Error:", err.Error())
		os.Exit(1)
	}
}
