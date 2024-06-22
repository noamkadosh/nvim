local api = vim.api

---@class Preset
---@field left string Left symbol
---@field right string Right symbol
---@field adjust integer Adjustment for left/right mark position

---@type table<string, Preset>
local pairs = {
    rounded = { left = "", right = "", adjust = 0 },
    square = { left = " ", right = " ", adjust = 0 },
    angle = { left = "🭅", right = "🭡", adjust = 0 },
    uneven = { left = "🭂", right = "🭞", adjust = 0 },
    arrow = { left = "🭮", right = "🭬", adjust = 1 },
    inset = { left = "🭨", right = "🭪", adjust = 0 },
    none = { left = "", right = "", adjust = 0 },
    custom = { left = "😻", right = "", adjust = 0 },
}

---@class Fancy
---@field ns integer Namespace
---@field buf integer BufferID
---@field win integer WindowID
---@field preset string Active preset
---@field hl_mark string Current item mark highlight group name
---@field last_selected integer Last selected row index

---@class Fancy
local M = {
    ns = 0,
    buf = 0,
    win = 0,
    preset = "square",
    hl_mark = "FancyMarks",
    last_selected = 0,
}

function M:update_hl()
    local visual = api.nvim_get_hl(0, { name = "Visual", link = true })

    local bg

    if M.preset == "square" then
        ---@diagnostic disable-next-line: undefined-field
        bg = visual.guibg or visual.bg
    end

    local hl_mark = {
        ---@diagnostic disable-next-line: undefined-field
        fg = visual.reverse and (visual.guifg or visual.fg)
            ---@diagnostic disable-next-line: undefined-field
            or (visual.guibg or visual.bg),
        bg = bg,
    }
    api.nvim_set_hl(0, self.hl_mark, hl_mark)
end

function M:select()
    local line = api.nvim_get_current_line()

    if #vim.trim(line) == 0 then
        return
    end

    local row, _ = unpack(api.nvim_win_get_cursor(self.win))

    row = row - 1

    api.nvim_buf_clear_namespace(
        self.buf,
        self.ns,
        self.last_selected,
        self.last_selected + 1
    )

    local left = line:find("[^ ]")
        - (1 + vim.fn.strdisplaywidth(pairs[self.preset].left)) --[[@as integer]]
    local right = line:match(".*()[^ ]") --[[@as integer]]

    -- adjustments
    left = vim.fn.max({ 0, left - pairs[self.preset].adjust })
    right = vim.fn.max({ 0, right + pairs[self.preset].adjust })

    pcall(api.nvim_buf_set_extmark, self.buf, self.ns, row, left, {
        id = 1,
        virt_text = { { pairs[self.preset].left, self.hl_mark } },
        virt_text_pos = "overlay",
    })
    pcall(api.nvim_buf_set_extmark, self.buf, self.ns, row, right, {
        id = 2,
        virt_text = { { pairs[self.preset].right, self.hl_mark } },
        virt_text_pos = "overlay",
    })

    api.nvim_buf_add_highlight(self.buf, self.ns, "Visual", row, left, right)
    self.last_selected = row
end

---@param buf number
function M:init(buf)
    vim.cmd("hi! Cursor blend=100")

    local augroup =
        api.nvim_create_augroup("M_autocmd_" .. buf, { clear = true })

    self.hl_mark = self.hl_mark .. "_" .. buf
    self.win = vim.fn.bufwinid(buf) or vim.api.nvim_get_current_win()
    self.ns = api.nvim_create_namespace("M_select_" .. buf)
    self.buf = buf

    self:update_hl()
    api.nvim_win_set_hl_ns(self.win, self.ns)

    api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        command = "hi! Cursor blend=100",
        buffer = self.buf,
    })
    api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
        group = augroup,
        command = "hi! Cursor blend=0",
        buffer = self.buf,
    })
    api.nvim_create_autocmd("ColorScheme", {
        group = augroup,
        callback = function()
            M:update_hl()
            vim.cmd("hi! Cursor blend=100")
        end,
        buffer = self.buf,
    })
    api.nvim_create_autocmd("CursorMoved", {
        group = augroup,
        callback = function()
            M:select()
        end,
        buffer = self.buf,
    })
end

---@alias preset_names "angle" | "arrow" | "custom" | "inset" | "none" | "rounded" | "square" | "uneven"
---@param buf number
---@param preset preset_names optional
function M.setup(buf, preset)
    M.preset = vim.tbl_contains(vim.tbl_keys(pairs), preset) and preset
        or "square"
    M:init(buf)
end

return M
