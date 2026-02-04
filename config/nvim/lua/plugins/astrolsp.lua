return {
  "AstroNvim/astrolsp",
  opts = {
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    formatting = {
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
    },
    servers = {
      "nil_ls",
      "rust_analyzer"    
    },
    config = {
      nil_ls = {
        cmd = { "nil" },
        filetypes = { "nix" },
      },
      rust_analyzer = {
        cmd = { "rust-analyzer" },
      },
    },
    on_attach = function(client, bufnr)
    end,
  },
}
