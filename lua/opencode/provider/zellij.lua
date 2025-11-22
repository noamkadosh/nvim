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
---@field pane_name? string The zellij pane name where `opencode` is running (internal use only).
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
	self.pane_name = nil
	return self
end

---Check if `zellij` is running in current terminal.
function Zellij.health()
	if not vim.fn.has("unix") then
		return "Not running inside a Unix system."
	end

	if vim.fn.executable("zellij") ~= 1 then
		return "`zellij` executable not found in `$PATH`.", {
			"Install `zellij` and ensure it's in your `$PATH`.",
		}
	end

	if not vim.env.ZELLIJ then
		return "Not running inside a `zellij` session.", {
			"Launch Neovim inside a `zellij` session.",
		}
	end

	return true
end

---Check if `opencode` process is running.
---@return boolean
function Zellij:is_running()
	local ok = self.health()
	if ok ~= true then
		return false
	end

	-- Use pgrep to check if opencode process exists (more reliable than ps+grep)
	local result = vim.fn.system("pgrep -f '" .. self.cmd .. "'")
	return result and result ~= ""
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
		-- Create a unique name for the pane to identify it later
		self.pane_name = "opencode_" .. vim.fn.getpid()
		-- Use zellij run with close-on-exit for automatic cleanup
		local zellij_cmd = string.format(
			"zellij run --close-on-exit --direction %s --name '%s' -- %s",
			direction,
			self.pane_name,
			self.cmd
		)
		vim.fn.system(zellij_cmd)
	end
end

---Kill the `opencode` pane.
---Kills the opencode process and its parent shell, causing the pane to close.
function Zellij:stop()
	if self:is_running() then
		-- Find the opencode process and its parent shell, then kill both
		local kill_script = string.format([[
			#!/bin/sh
			# Find all opencode processes
			pids=$(pgrep -f '%s')
			for pid in $pids; do
				# Get the parent process ID (the shell wrapper)
				ppid=$(ps -o ppid= -p $pid | tr -d ' ')
				# Kill the child first (opencode)
				kill -TERM $pid 2>/dev/null
				# Kill the parent shell to close the pane
				if [ -n "$ppid" ] && [ "$ppid" != "1" ]; then
					kill -TERM $ppid 2>/dev/null
				fi
			done
			# Wait a bit for graceful shutdown
			sleep 0.2
			# Force kill any remaining processes
			pkill -9 -f '%s' 2>/dev/null
		]], self.cmd, self.cmd)

		vim.fn.system(kill_script)

		-- Wait for pane to close
		vim.wait(300)

		self.pane_name = nil
	end
end

---Show the `opencode` pane by focusing it.
---Note: This is a no-op for now as zellij doesn't provide easy pane focusing by process.
function Zellij:show()
	-- Zellij doesn't have an easy way to focus a specific pane by process name
	-- Users can manually navigate to the pane using Zellij's navigation keys
end

return Zellij
