-- This contains all the specs to load the extensions modifying the UI

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup()
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "InsertEnter",
    config = function()
      require("dressing").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    enable = true,
    config = function()
      require("neoscroll").setup()
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {
      header = {
        detect = { "[\\@]class" },
        styler = "###",
      },
      line = {
        detect = { "[\\@]brief" },
        styler = "**",
      },
      listing = {
        detect = { "[\\@]li" },
        styler = " - ",
      },
      references = {
        detect = { "[\\@]ref", "[\\@]c", "[\\@]name" },
        styler = { "**", "`" },
      },
      word = {
        detect = { "[\\@]param", "[\\@]tparam", "[\\@]see", "[\\@]*param*" },
        styler = "`",
      },

      -- Tables used for cleaner identification of hover segments.
      code = {
        start = { "[\\@]code" },
        ending = { "[\\@]endcode" },
      },
      return_statement = {
        "[\\@]return",
        "[\\@]*return*",
      },
      border = "rounded",
    },
    config = function()
      require("pretty_hover").setup({})
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        require("duck").hatch()
      end, {})
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, {})
    end,
  },
}
