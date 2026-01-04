# My nvim config

## Prerequisites

- Git for package installations
- NodeJS / NPM for language servers
- Snacks requires ripgrep, and for extended capabilities fd.

Run check healths for various plugins to check for missing components.

```shell
:checkhealth snacks
:checkhealth nvim-treesitter
:checkhealth vim.lsp
```

And others..

## Linux

### Ubuntu

To install a C compiler:

```bash
sudo apt install build-essential
```

## Windows

To install a C compiler, the easiest method is to install the MinGW package.
Start a PowerShell terminal as administrator and issue the following commands:

```powershell
choco install mingw
```

In case Chocolatey is not installed:

```powershell
winget install chocolatey
```
