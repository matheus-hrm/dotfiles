-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/nvim-transparent'

-- Verificar se o plugin já está instalado
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- Clonar o plugin se não estiver instalado
  vim.fn.system({'git', 'clone', 'https://github.com/xiyaowong/nvim-transparent', install_path})
  -- Executar PackerCompile se acabamos de instalar
  vim.cmd [[packadd nvim-transparent]]
end

