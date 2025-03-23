return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            close_if_last_window = true,
        },
        config = true,
        keys = {
            { "<leader>tr", "<cmd>Neotree<CR>", { desc = "Open Neotree" } },
        },
    },
}
