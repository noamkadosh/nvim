return {
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
            "folke/snacks.nvim",
        },
        config = function()
            local zellij_provider =
                require("opencode.provider.zellij").new({
                    direction = "right",
                    cmd = "opencode",
                })

            require("opencode.config").provider = zellij_provider

            vim.o.autoread = true

            vim.keymap.set({ "n", "x" }, "<C-a>", function()
                require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode" })
            vim.keymap.set({ "n", "x" }, "<C-x>", function()
                require("opencode").select()
            end, { desc = "Execute opencode action…" })
            vim.keymap.set({ "n", "x" }, "ga", function()
                require("opencode").prompt("@this")
            end, { desc = "Add to opencode" })
            vim.keymap.set({ "n", "t" }, "<C-.>", function()
                require("opencode").toggle()
            end, { desc = "Toggle opencode" })
            vim.keymap.set("n", "<S-C-u>", function()
                require("opencode").command("session.half.page.up")
            end, { desc = "opencode half page up" })
            vim.keymap.set("n", "<S-C-d>", function()
                require("opencode").command("session.half.page.down")
            end, { desc = "opencode half page down" })
            vim.keymap.set(
                "n",
                "+",
                "<C-a>",
                { desc = "Increment", noremap = true }
            )
            vim.keymap.set(
                "n",
                "-",
                "<C-x>",
                { desc = "Decrement", noremap = true }
            )
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
