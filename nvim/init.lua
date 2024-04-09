local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'sainnhe/everforest',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  {
    'stevearc/conform.nvim',
    opts = {},
  },
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'ThePrimeagen/vim-be-good',
    event = 'VeryLazy',
    cmd = 'VimBeGood',
  },
  {
    'xiyaowong/transparent.nvim',
    cmd = {
      'TransparentEnable',
      'TransparentDisable',
      'TransparentToggle',
    },
  },
})

vim.cmd('colorscheme everforest')

require('base')
require('keymap')
require('p-mason')
require('p-lsp')
require('lsp-lua')
require('p-conform')
require('p-tree')
