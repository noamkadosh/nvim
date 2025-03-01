vim.g.mapleader = " "

vim.keymap.set(
    "v",
    "J",
    ":m '>+1<CR>gv=gv",
    { desc = "Move highlighted line down" }
)
vim.keymap.set(
    "v",
    "K",
    ":m '<-2<CR>gv=gv",
    { desc = "Move highlighted line up" }
)

vim.keymap.set(
    "v",
    "<leader>k",
    "yP`[V`]",
    { desc = "Duplicate highlighted up" }
)
vim.keymap.set(
    "v",
    "<leader>j",
    "y'>p`[V`]",
    { desc = "Duplicate highlighted down" }
)

vim.keymap.set(
    "n",
    "J",
    "mzJ`z",
    { desc = "Paste at the end of line, cursor stays in place" }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search term" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search term" })

vim.keymap.set("n", "<leader>P", [["_dP]], { desc = "Paste, keep buffer" })

vim.keymap.set(
    { "n", "v" },
    "<leader>y",
    [["+y]],
    { desc = "Yank to system clipboard" }
)
vim.keymap.set(
    "n",
    "<leader>Y",
    [["+Y]],
    { desc = "Yank line to system clipboard" }
)

vim.keymap.set(
    { "n", "v" },
    "<leader>D",
    [["_d]],
    { desc = "Delete, keep previous buffer" }
)

vim.keymap.set("n", "Q", "<nop>", { desc = "" })

vim.keymap.set(
    "n",
    "<C-k>",
    "<cmd>cnext<CR>zz",
    { desc = "Next error in quickfix" }
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<cmd>cprev<CR>zz",
    { desc = "Previous error in quickfix" }
)
vim.keymap.set(
    "n",
    "<leader>k",
    "<cmd>lnext<CR>zz",
    { desc = "Next error in the current file" }
)
vim.keymap.set(
    "n",
    "<leader>j",
    "<cmd>lprev<CR>zz",
    { desc = "Previous error in the current file" }
)
