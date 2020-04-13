# Bash

## Fill a file with random data

```
dd if=/dev/urandom of=target-file bs=1M count=1000000
```

## Suggested header

```
set -euxo pipefail
```

- `-e` Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list
constructs)
- `-u` Attempt to use undefined variable outputs error message, and forces an exit
- `-v` Print each command to stdout before executing it
- `-x` Similar to -v, but expands commands
- `-o pipefail` Causes a pipeline to return the exit status of the last command in the pipe that returned a non-zero return value

[http://www.tldp.org/LDP/abs/html/options.html](http://www.tldp.org/LDP/abs/html/options.html)

## Iterate over directories

```
find . -maxdepth 1 -mindepth 1 -type d -exec basename '{}' \;
```

## Parsing options

```
REMOTE=
PUSH=0

while getopts "r:p" OPTION; do
case $OPTION in
  r)
    REMOTE=$OPTARG
    ;;
  p)
    PUSH=1
    ;;
  ?)
    usage
    exit
    ;;
  esac
done
```

## Exec wrapper

```
#!/bin/bash

on_die ()
{
  # kill all children
  pkill -KILL -P $$
}

trap 'on_die' TERM
ffmpeg -i rtmp://localhost/myapp/$1 -c copy -f flv rtmp://localhost/myapp2/$1 &
wait
```

## Filename

```
function filename {
  return ${1%%.*}
}
```

## Extension

```
function extname {
  return ${1#*.}
}
```
