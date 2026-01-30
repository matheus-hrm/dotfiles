---@type LazySpec
return {
  -- {
  --   "andweeb/presence.nvim",
  --   config = function()
  --     require("presence"):setup({
  --       auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
  --       neovim_image_text = "Neovim text editor",
  --       main_image = "file",
  --       log_level = nil,
  --       debounce_timeout = 10,
  --     })
  --   end,
  -- },
  {
    "vyfor/cord.nvim", 
    lazy = false,
    opts = {
      config = function()
        require("cord").setup()
        display = {
          theme = "atom"
        }
        editor = {
          tooltip = "nvim"
        }
      end
    }
  },
  {
    "xiyaowong/transparent.nvim", lazy = false
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
    "mfussenegger/nvim-jdtls",
  },
  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
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
