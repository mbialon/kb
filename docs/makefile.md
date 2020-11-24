# Makefile

## Print all variables which name starts with TARGET_

```
$(foreach v, \
    $(filter TARGET_%,$(.VARIABLES)), \
    $(info $(v) = $($(v))))
```

## Set shell options

```
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
```
