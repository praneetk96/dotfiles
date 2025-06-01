# My dotfiles
This directory contains the dotfiles for my system

## Requirements
Ensure you have the following installed on your system

### Git

```
sudo dnf install git
```

### Stow


```
sudo dnf install stow
```

## Installation 
First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone https://github.com/praneetk96/dotfiles.git

$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

