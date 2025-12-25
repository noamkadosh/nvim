---Provide `opencode` in a `zellij` pane in the current tab.
---Works only in Unix systems.
---@class opencode.Provider
---@field name? string The name of the provider.
---@field cmd? string The command to start `opencode`.
---@field toggle? fun(self: opencode.Provider) Toggle `opencode`.
---@field start? fun(self: opencode.Provider) Start `opencode`.
---@field stop? fun(self: opencode.Provider) Stop `opencode`.
---@field show? fun(self: opencode.Provider) Show `opencode`.
---@field health? fun(): boolean|string, ...string|string[] Health check for the provider.

---@class opencode.provider.Zellij : opencode.Provider
---@field opts opencode.provider.zellij.Opts
---@field cmd string The command to run opencode (e.g., "opencode").
local Zellij = {}
Zellij.__index = Zellij

Zellij.name = "zellij"

---@class opencode.provider.zellij.Opts
---@field direction? string Direction to open the new pane ("right", "down", "left", "up").
---@field cmd? string Command to run opencode (default: "opencode").

---@param opts? opencode.provider.zellij.Opts
---@return opencode.provider.Zellij
function Zellij.new(opts)
    local self = setmetatable({}, Zellij)
    self.opts = opts or {}
    self.cmd = self.opts.cmd or "opencode"
    return self
end

---Check if `zellij` is running in current terminal.
function Zellij.health()
    if not vim.fn.has("unix") then
        return "Not running inside a Unix system."
    end

    if vim.fn.executable("zellij") ~= 1 then
        return "`zellij` executable not found in `$PATH`.",
            {
                "Install `zellij` and ensure it's in your `$PATH`.",
            }
    end

    if not vim.env.ZELLIJ then
        return "Not running inside a `zellij` session.",
            {
                "Launch Neovim inside a `zellij` session.",
            }
    end

    return true
end

---Get unique pane name for current project (based on cwd).
---@return string
function Zellij:get_pane_name()
    local cwd = vim.fn.getcwd()
    -- Create a simple hash of the cwd
    local hash = 0
    for i = 1, #cwd do
        hash = (hash * 31 + string.byte(cwd, i)) % 0xFFFFFFFF
    end
    return string.format("opencode_%x", hash)
end

---Check if the project-specific `opencode` process is running.
---@return boolean
function Zellij:is_running()
    local ok = self.health()
    if ok ~= true then
        return false
    end

    local cwd = vim.fn.getcwd()

    -- Find all opencode processes and check their working directories
    local cmd = string.format(
        "ps aux | awk '$11 == \"%s\" || $11 ~ /\\/%s$/ {print $2}'",
        self.cmd,
        self.cmd
    )
    local pids = vim.fn.system(cmd)

    if pids == "" then
        return false
    end

    -- Check each PID's working directory
    for pid in pids:gmatch("%d+") do
        local lsof_cmd = string.format(
            "lsof -p %s 2>/dev/null | grep cwd | awk '{print $NF}'",
            pid
        )
        local proc_cwd = vim.fn.system(lsof_cmd):gsub("%s+$", "")

        if proc_cwd == cwd then
            return true
        end
    end

    return false
end

---Create or kill the `opencode` zellij pane.
function Zellij:toggle()
    if self:is_running() then
        self:stop()
    else
        self:start()
    end
end

---Start `opencode` in zellij pane.
function Zellij:start()
    if not self:is_running() then
        local direction = self.opts.direction or "right"
        local pane_name = self:get_pane_name()

        -- Get PATH from Neovim's environment (it has the correct PATH)
        local path = vim.env.PATH or ""

        -- Use zellij run with close-on-exit for automatic cleanup
        -- Pass Neovim's PATH to ensure node, bun, npm, etc. are available
        -- Zellij will automatically use the current pane's working directory
        local zellij_cmd = string.format(
            "zellij run --close-on-exit --direction %s --name '%s' -- env PATH='%s' %s",
            direction,
            pane_name,
            path,
            self.cmd
        )
        vim.fn.system(zellij_cmd)
    end
end

---Kill the project-specific `opencode` pane.
---Finds and kills only the opencode process running in the current project directory.
---The pane will close automatically due to --close-on-exit flag.
function Zellij:stop()
    if not self:is_running() then
        return
    end

    local cwd = vim.fn.getcwd()

    -- Find all opencode processes
    local cmd = string.format(
        "ps aux | awk '$11 == \"%s\" || $11 ~ /\\/%s$/ {print $2}'",
        self.cmd,
        self.cmd
    )
    local pids = vim.fn.system(cmd)

    -- Check each PID and kill if it matches current directory
    for pid in pids:gmatch("%d+") do
        local lsof_cmd = string.format(
            "lsof -p %s 2>/dev/null | grep cwd | awk '{print $NF}'",
            pid
        )
        local proc_cwd = vim.fn.system(lsof_cmd):gsub("%s+$", "")

        if proc_cwd == cwd then
            -- Kill the process gracefully
            vim.fn.system(string.format("kill -TERM %s 2>/dev/null", pid))

            -- Wait a bit for graceful exit
            vim.wait(500)

            -- Force kill if still running
            vim.fn.system(
                string.format(
                    "kill -0 %s 2>/dev/null && kill -9 %s 2>/dev/null",
                    pid,
                    pid
                )
            )
            break
        end
    end

    -- Wait for pane to close
    vim.wait(100)
end

---Show the `opencode` pane by focusing it.
---Note: This is a no-op for now as zellij doesn't provide easy pane focusing by process.
function Zellij:show()
    -- Zellij doesn't have an easy way to focus a specific pane by process name
    -- Users can manually navigate to the pane using Zellij's navigation keys
end

return Zellij
