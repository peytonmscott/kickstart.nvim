-- Rust-specific plugins and configuration
return {
  -- Enhanced Rust development experience
  -- Temporarily disabled to troubleshoot rust-analyzer crashes
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^5', -- Recommended
  --   lazy = false, -- This plugin is already lazy
  --   -- We don't need to call setup for rustaceanvim
  --   config = function()
  --     -- Check if rust-analyzer is available in Mason's bin directory
  --     local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  --     local rust_analyzer_cmd = { "rust-analyzer" }
  --     
  --     -- If rust-analyzer exists in Mason's bin, use that path
  --     if vim.fn.executable(mason_bin .. "/rust-analyzer") == 1 then
  --       rust_analyzer_cmd = { mason_bin .. "/rust-analyzer" }
  --     end
  --     
  --     vim.g.rustaceanvim = {
  --       -- Plugin configuration
  --       tools = {
  --         hover_actions = {
  --           auto_focus = true,
  --         },
  --       },
  --       -- LSP configuration
  --       server = {
  --         cmd = rust_analyzer_cmd,
  --         on_attach = function(_, _)
  --           -- You can add custom on_attach logic here if needed
  --           -- The default LSP keybindings from init.lua will still apply
  --         end,
  --         default_settings = {
  --           -- rust-analyzer language server configuration
  --           ['rust-analyzer'] = {
  --             cargo = {
  --               allFeatures = true,
  --               loadOutDirsFromCheck = true,
  --               runBuildScripts = true,
  --             },
  --             -- Add clippy lints for more helpful diagnostics
  --             checkOnSave = {
  --               command = "clippy",
  --               allFeatures = true,
  --               extraArgs = { "--", "-W", "clippy::pedantic" },
  --             },
  --             procMacro = {
  --               enable = true,
  --               ignored = {
  --                 ["async-trait"] = { "async_trait" },
  --                 ["napi-derive"] = { "napi" },
  --                 ["async-recursion"] = { "async_recursion" },
  --               },
  --             },
  --             diagnostics = {
  --               enable = true,
  --               experimental = {
  --                 enable = true,
  --               },
  --             },
  --           },
  --         },
  --       },
  --       -- DAP configuration
  --       dap = {
  --         -- adapter = {
  --         --   type = "executable",
  --         --   command = "lldb-vscode",
  --         --   name = "rt_lldb",
  --         -- },
  --       },
  --     }
  --   end,
  -- },

  -- Crate management for Cargo.toml
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup({
        src = {
          cmp = {
            enabled = true,
          },
        },
        popup = {
          autofocus = true,
          border = "rounded",
        },
      })
    end,
  },

  -- Better TOML support (for Cargo.toml files)
  {
    'tamasfe/taplo',
    ft = 'toml',
  },

  -- Rust syntax highlighting and utilities
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
    end
  },
}