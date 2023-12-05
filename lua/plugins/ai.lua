return {
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>cc",
                "<cmd>ChatGPT<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT",
            },
            {
                "<leader>ce",
                "<cmd>ChatGPTEditWithInstruction<CR>",
                mode = { "v" },
                desc = "ChatGPT - Edit with instruction",
            },
            {
                "<leader>cw",
                "<cmd>ChatGPTActAs<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Act as",
            },
            {
                "<leader>cg",
                "<cmd>ChatGPTRun grammar_correction<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Grammar correction",
            },
            {
                "<leader>ct",
                "<cmd>ChatGPTRun translate<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Translate",
            },
            {
                "<leader>ck",
                "<cmd>ChatGPTRun keywords<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Keywords",
            },
            {
                "<leader>ci",
                "<cmd>ChatGPTRun docstring<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Docstring",
            },
            {
                "<leader>cb",
                "<cmd>ChatGPTRun add_tests<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Add tests",
            },
            {
                "<leader>co",
                "<cmd>ChatGPTRun optimize_code<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Optimize code",
            },
            {
                "<leader>cs",
                "<cmd>ChatGPTRun summarize<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Summarize",
            },
            {
                "<leader>cf",
                "<cmd>ChatGPTRun fix_bugs<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Fix bugs",
            },
            {
                "<leader>cx",
                "<cmd>ChatGPTRun explain_code<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Explain code",
            },
            {
                "<leader>cr",
                "<cmd>ChatGPTRun roxygen_edit<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Roxygen edit",
            },
            {
                "<leader>cl",
                "<cmd>ChatGPTRun code_readability_analysis<CR>",
                mode = { "n", "v" },
                desc = "ChatGPT - Code readability analysis",
            },
        },
        opts = {
            api_key_cmd = "op read op://jr3x5psimf7mlj7mcrur4fymuu/5vj4colm4csyymp3soihvju4ii/password --no-newline",
        },
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        opts = {
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
        },
    },
}
