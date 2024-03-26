# Beloin Configuration

Starter config for NvChad

## Dependencies

1. ripgrep
2. `JetBrainsMono Nerd Font`, or any Nerd Font
<!-- 3. code-minimap 
    > sudo pamac build code-minimap -->
3. 

## To add

1. https://github.com/alepez/vim-gtest
2. https://github.com/tenfyzhong/vim-gencode-cpp
3. https://github.com/puremourning/vimspector?tab=readme-ov-file


# Add language Support:

1. Configure TreeSitter
2. Install with Mason:
    - DAP
    - LSP
    - Linter
    - Formatter

# Language Specific

## C/C++ with CMake

1. Install obviously cmake and build-essentials
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
1. Mono:
    > sudo apt install mono-devel
    > sudo pacman -S mono
1. TreeSitter
    - Installl csharp using `:TSInstall csharp`
1. Mason:
    > netcoredbg
    > csharpier