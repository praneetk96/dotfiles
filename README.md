<p align = "center">
    <img src="src/images/header.gif">
</p>

# My dotfiles
This directory contains the dotfiles for my system, But first keep your system updated

```
$ sudo dnf upgrade --refresh; flatpak update
```

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

or

```
$ stow -v -R -t ~ PACKAGE_NAME
```


<p align = "center">
    <img src="src/images/footer.gif">
</p>
