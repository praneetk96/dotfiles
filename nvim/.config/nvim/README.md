# Windows 10/11 Instructions

I came across a problem with this plugin `telescope-fzf-native.nvim` for some reason it throws error of `fzf` being not found in the `PATH`, then follow these steps to solution:

1. open file explorer and goto this location `%LOCALAPPDATA%\nvim-data\lazy\telescope-fzf-native.nvim`, or where the lazy has downloaded plugins.
2. delete `build` folder if it exists.
3. open powershell here, click on addressbar and type `pwsh` and hit enter.
4. Before running below commands make sure you have **Build Tools for Visual Studio 20XX** installed from **Tools for Visual Studio** in **All Downloads** from [here](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2026), and also install tools like `gcc/g++`, `cmake`, `make` & run these commands

```
make clean
cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release
cmake --install build --prefix build
```

Now launch Neovim without a problem!
