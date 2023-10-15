return {
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>cc", desc = "ChatGPT" },
            { "<leader>ce", desc = "ChatGPT - Edit with instruction" },
            { "<leader>cw", desc = "ChatGPT - Act as" },
            { "<leader>ct", desc = "ChatGPT - Translate" },
            { "<leader>ck", desc = "ChatGPT - Keywords" },
            { "<leader>ci", desc = "ChatGPT - Docstring" },
            { "<leader>cb", desc = "ChatGPT - Add tests" },
            { "<leader>co", desc = "ChatGPT - Optimize code" },
            { "<leader>cs", desc = "ChatGPT - Summarize" },
            { "<leader>cf", desc = "ChatGPT - Fix bugs" },
            { "<leader>cx", desc = "ChatGPT - Explain code" },
            { "<leader>cr", desc = "ChatGPT - Roxygen edit" },
            { "<leader>cl", desc = "ChatGPT - Code readability analysis" },
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "op read op://jr3x5psimf7mlj7mcrur4fymuu/5vj4colm4csyymp3soihvju4ii/password --no-newline",
            })

            vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>ChatGPT<CR>")
            vim.keymap.set(
                { "n", "v" },
                "<leader>cw",
                "<cmd>ChatGPTActAs<CR>"
            )
            vim.keymap.set(
                "v",
                "<leader>ce",
                "<cmd>ChatGPTEditWithInstruction<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cg",
                "<cmd>ChatGPTRun grammar_correction<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>ct",
                "<cmd>ChatGPTRun translate<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>ck",
                "<cmd>ChatGPTRun keywords<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>ci",
                "<cmd>ChatGPTRun docstring<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cb",
                "<cmd>ChatGPTRun add_tests<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>co",
                "<cmd>ChatGPTRun optimize_code<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cs",
                "<cmd>ChatGPTRun summarize<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cf",
                "<cmd>ChatGPTRun fix_bugs<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cx",
                "<cmd>ChatGPTRun explain_code<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cr",
                "<cmd>ChatGPTRun roxygen_edit<CR>"
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>cl",
                "<cmd>ChatGPTRun code_readability_analysis<CR>"
            )
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false,
                },
                panel = {
                    enabled = false,
                },
            })

            require("copilot_cmp").setup({})
        end,
    },
}
