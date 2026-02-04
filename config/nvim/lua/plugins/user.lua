---@type LazySpec
return {
  {
  "rebelot/heirline.nvim",
    opts = function(_, opts)
      opts.tabline = nil -- desabilita a tabline do heirline
      return opts
    end,
  },
  { 
    "neanias/everforest-nvim"
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin", -- "slant" | "thick" | "thin" | "slope" | "padded_slant"
        color_icons = true,
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.background_colour = "#000000"
      return opts
    end,
  },
  {
    "vyfor/cord.nvim", 
  },
  {
    "xiyaowong/transparent.nvim", 
    lazy = false,
    opts = {
      enable = true,
      extra_groups = {
        "BufferLineTabClose",
        "BufferLineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        -- "BufferLineSeparator",
        "BufferLineSeparatorInactive",
        "BufferLineIndicatorSelected",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeEndOfBuffer",
        "NvimTreeVertSplit",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeVertSplit",
        "NeoTreeWinSeparator",
        "StatusLine",
        "StatusLineNC",
        "WinSeparator",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "NormalFloat",
        "FloatBorder",
      },
      exclude = {},
    },
  },
  {
    "RRethy/base16-nvim", lazy = false
  },
  {
    'morhetz/gruvbox', lazy = false
  },
  {
    'mellow-theme/mellow.nvim', lazy = false
  },
  {
   'wakatime/vim-wakatime', lazy = false 
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function() require("catppuccin").setup({
      flavour = "macchiato",
      transparent_background = false,
      styles = {
        comments = { "italic" },
        strings = { "italic " },
      },
    }) end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "github/copilot.vim",
    config = function()
    vim.g.copilot_no_tab_map = true  -- Disable default <Tab> mapping
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
      }
      return opts
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" }, {"typescriptreact"},"typescript")
    end,
  },
  {
    "kdheepak/monochrome.nvim", lazy = false
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
  },
}
