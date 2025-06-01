<div align = "center">
    <img src="src/images/header.gif" style="border-radius: 10px;">
</div>

# My dotfiles
This directory contains the dotfiles for my system which runs on Fedora linux. First things first let's keep your system updated

On Fedora run

```
sudo dnf upgrade --refresh; flatpak update
```

## Hyprland screenshot
<div align = "center">
    <img src = "src/images/hypr-rice.png" style = "border-radius: 10px;">
</div>

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
git clone https://github.com/praneetk96/dotfiles.git

cd dotfiles
```

then use GNU stow to create symlinks

```
stow .
```

or for a individual package

```
stow -v -R -t ~ PACKAGE_NAME
```


<div align = "center">
    <img src="src/images/footer.gif" style="border-radius: 10px;">
</div>
