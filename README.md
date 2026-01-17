# My nvim config

## Prerequisites

- Git for package installations
- LazyGit to use git actions inside neovim
- NodeJS / NPM for language servers
- Snacks requires ripgrep, and for extended capabilities fd-find.
- nvim-treesitter requires the treesitter cli and a C compiler (see below) to compile parsers

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

Then set the environment variable to cc:

```powershell
 $env:CC="cc"
```

### Windows Terminal

Mapping ctrl+space will not work when using neovim in a Windows Terminal. To disable the mapping, open the Windows Terminal JSON settings and add the following:

````json
    ...
    "actions":
    [
        {
            "command":
            {
                "action": "sendInput",
                "input": "\u001b[32;5u"
            },
            "id": "Terminal.CtrlSpaceWorkaround"
        }
    ],
    ...
    "keybindings":
    [
        {
            "id": "Terminal.CtrlSpaceWorkaround",
            "keys": "ctrl+space"
        },
    ...```


````
