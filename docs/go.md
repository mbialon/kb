# Go

## Packages

### Testing

- [github.com/frankban/quicktest](https://github.com/frankban/quicktest)

### Embed static assets

- [github.com/gobuffalo/packr/](https://github.com/gobuffalo/packr/)

## Min/max integer values

```
const MaxUint = ^uint(0)
const MinUint = 0
const MaxInt = int(^uint(0) >> 1)
const MinInt = -MaxInt - 1
```

[https://groups.google.com/group/golang-nuts/msg/71c307e4d73024ce?pli=1](https://groups.google.com/group/golang-nuts/msg/71c307e4d73024ce?pli=1)

## Static build
```
-ldflags '-extldflags "-fno-PIC -static"' -buildmode pie -tags 'osusergo netgo static'
```

- [https://github.com/golang/go/issues/26492](https://github.com/golang/go/issues/26492)

## Reduce binary size by stripping debugging symbols

```
go build -ldflags '-w -s' main.go
```

- [Franz Bettag on Twitter](https://twitter.com/fbettag/status/920941111551647744)
- [Shrink your Go binaries with this one weird trick](https://blog.filippo.io/shrink-your-go-binaries-with-this-one-weird-trick/)

## Disable optimizations and inlining

```
go run -gcflags '-N -l' main.go
```

[https://golang.org/cmd/compile/](https://golang.org/cmd/compile/)

## Calculate sha256

```
h := sha256.New()
h.Write(b)
sum := h.Sum(nil)
```

## Running tests as root

```
go test -exec sudo -v ./...
```

If running from a script (e.g. in CI)

```
go test -exec "sudo -n" ...
```

### Links

- https://twitter.com/kolyshkin/status/1367697997979557897

## Compile to ARM with CGO

Install support programs

```
sudo apt-get install libc6-armel-cross libc6-dev-armel-cross
sudo apt-get install binutils-arm-linux-gnueabi
```

Install cross compilers for arm

```
sudo apt-get install gcc-arm-linux-gnueabi
sudo apt-get install g++-arm-linux-gnueabi
```

Install cross compilers for armhf

```
sudo apt-get install gcc-arm-linux-gnueabihf
sudo apt-get install g++-arm-linux-gnueabihf
```

Compile package

```
env GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CC=arm-linux-gnueabi-gcc go build .
```

## CGO

```
package main

// #include <stdio.h>
//
// int hello() {
//   printf("hello world!\n");
// }
import "C"

func main() {
	C.hello()
}
```

https://golang.org/cmd/cgo/

## Go for Crypto Developers

### Encryption

AES

### Hashes

SHA2

### Signatures

```
// generate key
key, _ := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)

// sign message
digest := sha256.Sum256(data)
r, s, _ := ecdsa.Sign(rand.Reader, priv, digest[:])

// encode the signature
params := priv.Curve.Params()
curveByteSize := params.P.BitLen() / 8
rBytes, sBytes := r.Bytes(), s.Bytes()
signature := make([]byte, curveByteSize*2)
copy(signature[curveByteSize-len(rBytes):], rBytes)
copy(signature[curveByteSize*2-len(sBytes):], sBytes)

// verify
digest := sha256.Sum256(data)
curveByteSize := pub.Curve.Params().P.BitLen() / 8
r, s := new(big.Int), new(big.Int)
r.SetBytes(signature[:curveByteSize])
s.SetBytes(signature[curveByteSize:])
ecdsa.Verify(pub, digest[:], r, s)
```

### Links

- https://www.youtube.com/watch?v=2r_KMzXB74
- https://github.com/gtank/cryptopasta

## Using Papertrail with logrus

```
import "github.com/polds/logrus-papertrail-hook"

// ...

hook, err := papertrail.NewPapertrailHook(&papertrail.Hook{
  Host:     "logs3.papertrailapp.com",
  Port:     13296,
  Hostname: "hostname",
  Appname:  "appname",
})
if err != nil {
  logrus.Printf("cannot create papertrail hook, err: %v", err)
  return
}
hook.SetLevels(logrus.AllLevels)
logrus.AddHook(hook)
```

## Cancel context.Context when a signal arrives

```
func WithSignal(parent context.Context, sig ...os.Signal) (context.Context, context.CancelFunc) {
	ctx, cancel := context.WithCancel(parent)
	c := make(chan os.Signal, 1)
	signal.Notify(c, sig...)
	go func() {
		select {
		case <-ctx.Done():
		case <-c:
			cancel()
		}
	}()
	return ctx, func() {
		signal.Stop(c)
		cancel()
	}
}
```

## GitHub Actions template

```
name: Test
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - name: Set up Go 1.x
        uses: actions/setup-go@v2
        with:
          go-version: ^1.14
        id: go
      - name: Check out code into the Go module directory
        uses: actions/checkout@v2
      - name: Get dependencies
        run: go get -v -t -d ./...
      - name: Run tests
        run: go test -v -race -cover -covermode=atomic -coverprofile=cover.txt .
      - name: Upload coverage report to codecov.io
        uses: codecov/codecov-action@v1
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          file: ./cover.txt
```
