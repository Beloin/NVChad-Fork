# Beloin Configuration

Starter config for NvChad

## Dependencies

1. ripgrep
2. `JetBrainsMono Nerd Font`, or any Nerd Font
<!-- 3. code-minimap 
    > sudo pamac build code-minimap -->
3. Icons on `@vscode/codicons`

## To add

1. Launch.json DAP configurations
1. https://github.com/alepez/vim-gtest
2. https://github.com/tenfyzhong/vim-gencode-cpp
3. https://github.com/puremourning/vimspector?tab=readme-ov-file


# Add Generic language Support:

Search on `https://www.lazyvim.org/extras/lang/{language}` for the language, or:

1. Configure TreeSitter
2. Install with Mason:
    - DAP
    - LSP
    - Linter
    - Formatter
3. If necessary configure LSP in `configs.lspconfig.lua`

# Language Specific

## C/C++ with CMake

1. Install obviously cmake and build-essentials
1. codelldb, or lldb-vscode
1. Install `unzip`
1. Install with mason the required language setup
    > cmake-language-server
    > clang-format
    > clangd
    > cmakelang
    > codelldb
    > cpplint
    > cpptools
1. Configure file `lspconfig.lua` if necessary


### CMake

> pip install cmake-language-server

Use the package Task to configure the CMake Tasks, including debug

## C#

1. Omnisharp
    - Install with Mason
    - Configure on `configs.lspconfig` the `lspconfig.omnisharp.setup` setup where omnisharp was installed
    - More helo see [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp)
    - omnisharp-mono?
    - Omnisharp install
1. Mono:
    > sudo apt install mono-devel
    > sudo pacman -S mono
1. TreeSitter
    - Installl csharp using `:TSInstall c_sharp`
1. Mason:
    > netcoredbg
    > csharpier


## Python

1. Jedi language-server
    - `pip install -U jedi-language-server`
    - Or with Mason
2. Venv selector
    - Install [fd](https://github.com/sharkdp/fd)
    - `sudo pacman -S fd` or `sudo apt install fd-find`
2. Or: Already open the neovim from a venv! -- Better and more reliable
3. Python provider
    - `python3 -m pip install --user --upgrade pynvim`
    - Or, in local: - `pip install --upgrade pynvim`
4. [Optional] Jupyter Notebook
    - Install ipython: `pip install --user --upgrade --break-system-packages ipython`
    - Run with `:JukitStart`
    - More info on [Jukit](https://github.com/luk400/vim-jukit)