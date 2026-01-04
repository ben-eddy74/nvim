# Configuration

Default configuration taken from https://tduyng.com/blog/

## Fonts

https://www.nerdfonts.com/font-downloads
JetBrainsMono
JetBrainsMonoNerdFont

## Dependencies



## Windows Terminal

Ctrl-Space is used by blink cmp but is also used by Windows Terminal. To disable the binding for Windows Terminal, go to Settings -> JSON and add the following:

```json
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
    ...
```


