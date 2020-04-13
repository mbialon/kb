# GitLab

## Using Git submodules with GitLab CI

Set relative submodule urls:

```
[submodule "project"]
  path = project
  url = ../../group/project.git
```

Update submodules before the build:

```
before_script:
  - git submodule sync --recursive
  - git submodule update --init --recursive
```

https://docs.gitlab.com/ce/ci/git_submodules.html
