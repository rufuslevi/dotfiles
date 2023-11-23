-- This contains all the specs to load the extensions modifying the UI

return {
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
    config = function()
      require("neoscroll").setup()
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
      require("pretty_hover").setup(opts)
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