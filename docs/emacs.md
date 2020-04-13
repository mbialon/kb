# Emacs

## Install Emacs 26.3 on Ubuntu

```
git clone -b master git://git.sv.gnu.org/emacs.git
cd emacs
git checkout emacs-26.3
sudo apt install build-essential
sudo apt build-dep emacs
make bootstrap
sudo make install
```
