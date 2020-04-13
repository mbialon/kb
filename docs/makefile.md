# Makefile

## Print all variables which name starts with TARGET_

```
$(foreach v, \
    $(filter TARGET_%,$(.VARIABLES)), \
    $(info $(v) = $($(v))))
```
