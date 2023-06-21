return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand ("~") .. "/.config/obsidian/**.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/.config/obsidian",

    -- daily_notes = {
    --   -- Optional, if you keep daily notes in a separate directory.
    --   folder = "notes/dailies",
    --   -- Optional, if you want to change the date format for daily notes.
    --   date_format = "%Y-%m-%d"
    -- },

    completion = {
      nvim_cmp = true,
    },

    -- Optional, customize how names/IDs for new notes are created.
    -- note_id_func = function(title)
    --   -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    --   -- In this case a note with the title 'My new note' will given an ID that looks
    --   -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    --   local suffix = ""
    --   if title ~= nil then
    --     -- If title is given, transform it into valid file name.
    --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    --   else
    --     -- If title is nil, just add 4 random uppercase letters to the suffix.
    --     for _ = 1, 4 do
    --       suffix = suffix .. string.char(math.random(65, 90))
    --     end
    --   end
    --   return tostring(os.time()) .. "-" .. suffix
    -- end,

    templates = {
      subdir = "templates",
      date_format = "%ddd, %LL",
      time_format = "%h:%m %A",
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    -- follow_url_func = function(url)
    --   -- Open the URL in the default web browser.
    --   vim.fn.jobstart({"open", url})  -- Mac OS
    --   -- vim.fn.jobstart({"xdg-open", url})  -- linux
    -- end,

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- https://github.com/Vinzent03/obsidian-advanced-uri
    -- use_advanced_uri = true,

    finder = "telescope.nvim",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = false, expr = true, desc = "Search obsidian notes" })
  end,
}
