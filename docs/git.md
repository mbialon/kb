# Git

## Remove first commit

A-B-C --> AB-C

```
git rebase -i A
```

It is possible to start like that if you continue with edit rather than squash:

```
edit e97a17b B
pick asd314f C
```

then run

```
git reset --soft HEAD^
git commit --amend 
git rebase --continue
```

## Find deleted file path

```
git log --diff-filter=D --summary | grep delete
```

## Find deleted file commit

```
git log --all -- <path-to-file>
```
