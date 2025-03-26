return {
    {
        "williamboman/mason.nvim",
        opts = {
            PATH = "prepend",
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
}
