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
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "mxsdev/nvim-dap-vscode-js",
            "microsoft/vscode-js-debug",
            "williamboman/mason.nvim",
        },
        lazy = true,
        keys = function()
            local dap = require("dap")
            require("dapui")

            return {
                {
                    "<leader>da",
                    function()
                        if vim.fn.filereadable(".vscode/launch.json") then
                            local dap_vscode = require("dap.ext.vscode")
                            dap_vscode.load_launchjs(nil, {
                                ["pwa-node"] = js_flavors,
                                ["node"] = js_flavors,
                                ["chrome"] = js_flavors,
                                ["pwa-chrome"] = js_flavors,
                            })
                        end
                        dap.continue()
                    end,
                    desc = "Run with Args",
                },
                {
                    "<leader>db",
                    dap.toggle_breakpoint,
                    desc = "toggle breakpoint",
                },
                {
                    "<leader>db",
                    dap.clear_breakpoints,
                    desc = "clear breakpoints",
                },
                {
                    "<leader>dc",
                    dap.continue,
                    desc = "start/continue",
                },
                {
                    "<leader>di",
                    dap.step_into,
                    desc = "step into",
                },
                {
                    "<leader>do",
                    dap.step_over,
                    desc = "step over",
                },
                {
                    "<leader>do",
                    dap.step_out,
                    desc = "step out",
                },
                {
                    "<leader>dq",
                    dap.close,
                    desc = "close session",
                },
                {
                    "<leader>dq",
                    dap.terminate,
                    desc = "terminate session",
                },
                { "<leader>dp", dap.pause, desc = "pause" },
                {
                    "<leader>dr",
                    dap.restart_frame,
                    desc = "restart",
                },
                {
                    "<leader>dr",
                    dap.repl.toggle,
                    desc = "toggle repl",
                },
            }
        end,
        config = function()
            local dap = require("dap")

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
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        keys = function()
            require("dap")
            local dapui = require("dapui")

            return {
                {
                    "<leader>du",
                    dapui.toggle,
                    desc = "Toggle Debugger UI",
                },
                {
                    "<leader>dh",
                    require("dap.ui.widgets").hover,
                    desc = "Debugger Hover",
                },
            }
        end,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        config = true,
    },

    {
        "nvim-telescope/telescope-dap.nvim",
        lazy = true,
        config = function()
            require("telescope").load_extension("dap")
        end,
    },

    {
        "mxsdev/nvim-dap-vscode-js",
        lazy = true,
        opts = {
            debugger_path = vim.fn.glob(
                vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
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
        },
    },

    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        lazy = true,
    },

    {
        "leoluz/nvim-dap-go",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        ft = { "go", "gomod" },
        keys = function()
            require("dap")

            return {
                {
                    "<leader>dt",
                    require("dap-go").debug_test,
                    desc = "Go Debug Test",
                },
            }
        end,
        config = true,
    },

    {
        "jbyuki/one-small-step-for-vimkind",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        event = { "BufReadPre " .. vim.fn.expand("~") .. "/.config/nvim/**" },
        config = function()
            local dap = require("dap")

            dap.adapters.nlua = function(callback, conf)
                local adapter = {
                    type = "server",
                    host = conf.host or "127.0.0.1",
                    port = conf.port or 8086,
                }
                if conf.start_neovim then
                    local dap_run = dap.run
                    dap.run = function(c)
                        adapter.port = c.port
                        adapter.host = c.host
                    end
                    require("osv").run_this()
                    dap.run = dap_run
                end
                callback(adapter)
            end

            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Run this file",
                    start_neovim = {},
                },
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance (port = 8086)",
                    port = 8086,
                },
            }
        end,
    },
}
