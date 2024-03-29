# SSH

```
Host *
UseKeychain yes
AddKeysToAgent yes
IdentityFile ~/.ssh/id_rsa
```

## scp to a non-default port

```
scp -P 40404 test root@example.com:/tmp
```

## enable ssh connection from the server

```
ssh -nN -o ExitOnForwardFailure=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -R 3001:localhost:22 user@example.com
```

## sshfs

- [How To Use SSHFS to Mount Remote File Systems Over SSH | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh)

### Installation

```
sudo apt-get install sshfs
```

### Mouting

```
sudo mkdir /mnt/droplet
sudo sshfs -o allow_other,IdentityFile=~/.ssh/id_rsa root@xxx.xxx.xxx.xxx:/ /mnt/droplet
```
