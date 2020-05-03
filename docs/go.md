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
