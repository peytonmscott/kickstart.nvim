-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Track pinned state
vim.g.neo_tree_pinned = false

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    window = {
      width = 30,
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['a'] = 'add',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['p'] = function()
            vim.g.neo_tree_pinned = not vim.g.neo_tree_pinned
            print(vim.g.neo_tree_pinned and 'Neo-tree: Pinned mode' or 'Neo-tree: Unpinned mode')
          end,
          ['<cr>'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'file' then
              -- Open the file
              require('neo-tree.sources.filesystem.commands').open(state)
              -- Close neo-tree after opening file (only if not pinned)
              if not vim.g.neo_tree_pinned then
                require('neo-tree.command').execute { action = 'close' }
              end
            else
              -- For directories, just toggle
              require('neo-tree.sources.filesystem.commands').toggle_node(state)
            end
          end,
        },
      },
    },
  },
}
