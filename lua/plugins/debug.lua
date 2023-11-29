local js_flavors = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
}

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "theHamsta/nvim-dap-virtual-text" },
            "mxsdev/nvim-dap-vscode-js",
            "microsoft/vscode-js-debug",
            { "leoluz/nvim-dap-go" },
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            require("telescope").load_extension("dap")
            require("nvim-dap-virtual-text").setup({})

            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb", "delve" },
            })

            for _, language in pairs(js_flavors) do
                dap.configurations[language] = {
                    -- Debug single nodejs files
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                    },
                    -- Debug nodejs processes (make sure to add --inspect when you run the process)
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                    },
                    -- Debug Jest Tests
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                    -- Debug web applications (client side)
                    {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Launch & Debug Chrome",
                        url = function()
                            local co = coroutine.running()
                            return coroutine.create(function()
                                vim.ui.input({
                                    prompt = "Enter URL: ",
                                    default = "http://localhost:3000",
                                }, function(url)
                                    if url == nil or url == "" then
                                        return
                                    else
                                        coroutine.resume(co, url)
                                    end
                                end)
                            end)
                        end,
                        webRoot = "${workspaceFolder}",
                        skipFiles = { "<node_internals>/**/*.js" },
                        protocol = "inspector",
                        sourceMaps = true,
                        userDataDir = false,
                    },
                }
            end

            local dap_go = require("dap-go")
            dap_go.setup({})

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            local colors = require("tokyonight.colors").setup()

            vim.api.nvim_set_hl(
                0,
                "DapBreakpoint",
                { ctermbg = 0, fg = colors.red1, bg = colors.bg }
            )
            vim.api.nvim_set_hl(
                0,
                "DapLogPoint",
                { ctermbg = 0, fg = colors.blue, bg = colors.bg }
            )
            vim.api.nvim_set_hl(
                0,
                "DapStopped",
                { ctermbg = 0, fg = colors.green, bg = colors.bg }
            )
            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "",
                texthl = "DapLogPoint",
                linehl = "DapLogPoint",
                numhl = "DapLogPoint",
            })
            vim.fn.sign_define("DapStopped", {
                text = "",
                texthl = "DapStopped",
                linehl = "DapStopped",
                numhl = "DapStopped",
            })

            vim.keymap.set("n", "<leader>da", function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    local dap_vscode = require("dap.ext.vscode")
                    dap_vscode.load_launchjs(nil, {
                        ["pwa-node"] = js_flavors,
                        ["node"] = js_flavors,
                        ["chrome"] = js_flavors,
                        ["pwa-chrome"] = js_flavors,
                    })
                end
                require("dap").continue()
            end, {
                desc = "Run with Args",
            })
            vim.keymap.set(
                "n",
                "<leader>db",
                dap.toggle_breakpoint,
                { desc = "Toggle Breakpoint" }
            )
            vim.keymap.set(
                "n",
                "<leader>dB",
                dap.clear_breakpoints,
                { desc = "Clear Breakpoints" }
            )
            vim.keymap.set(
                "n",
                "<leader>dc",
                dap.continue,
                { desc = "Start/Continue" }
            )
            vim.keymap.set(
                "n",
                "<leader>di",
                dap.step_into,
                { desc = "Step Into" }
            )
            vim.keymap.set(
                "n",
                "<leader>do",
                dap.step_over,
                { desc = "Step Over" }
            )
            vim.keymap.set(
                "n",
                "<leader>dO",
                dap.step_out,
                { desc = "Step Out" }
            )
            vim.keymap.set(
                "n",
                "<leader>dq",
                dap.close,
                { desc = "Close Session" }
            )
            vim.keymap.set(
                "n",
                "<leader>dQ",
                dap.terminate,
                { desc = "Terminate Session" }
            )
            vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
            vim.keymap.set(
                "n",
                "<leader>dr",
                dap.restart_frame,
                { desc = "Restart" }
            )
            vim.keymap.set(
                "n",
                "<leader>dR",
                dap.repl.toggle,
                { desc = "Toggle REPL" }
            )
            vim.keymap.set(
                "n",
                "<leader>du",
                dapui.toggle,
                { desc = "Toggle Debugger UI" }
            )
            vim.keymap.set(
                "n",
                "<leader>dh",
                require("dap.ui.widgets").hover,
                { desc = "Debugger Hover" }
            )
            vim.keymap.set(
                "n",
                "<leader>dt",
                dap_go.debug_test,
                { desc = "Go Debug Test" }
            )
        end,
    },

    {
        "mxsdev/nvim-dap-vscode-js",
        lazy = true,
        config = function()
            require("dap-vscode-js").setup({
                debugger_path = vim.fn.glob(
                    vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/"
                ),
                log_file_level = vim.log.levels.TRACE,
                adapters = {
                    "chrome",
                    "pwa-node",
                    "pwa-chrome",
                    "pwa-msedge",
                    "pwa-extensionHost",
                    "node-terminal",
                    "node",
                },
            })
        end,
    },

    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        lazy = true,
    },
}
