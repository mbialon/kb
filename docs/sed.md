# sed

## Update value in multiple files

```
find . -name pom.xml -exec sed -i.bak 's/>1\.7</>1\.8</g' pom.xml '{}' \;
```

## Delete line in multiple files

```
find . -name *.go -exec sed -i '/+build osx/d' '{}' \;
```
