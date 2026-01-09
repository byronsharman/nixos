{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraLuaConfig = builtins.readFile ./init.lua;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; builtins.map(attrset: { type = "lua"; } // attrset) [
      { plugin = plenary-nvim; }
      { plugin = lush-nvim; }
      {
        plugin = bluloco-nvim;
        config = ''
          require('bluloco').setup {
            transparent = true,
          }
          vim.cmd("colorscheme bluloco")
        '';
      }
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./lspconfig.lua;
      }

      # TODO: use github:iofq/nvim-treesitter-main flake for treesitter

      {
        plugin = guess-indent-nvim;
        config = "require('guess-indent').setup{}";
      }
      {
        plugin = blink-cmp;
        config = ''
          require('blink-cmp').setup{}
        '';
      }
      {
        plugin = telescope-nvim;
        config = ''
          require('telescope').setup{
            extensions = {
              ['ui-select'] = {
                require('telescope.themes').get_dropdown{}
              }
            },
            pickers = {
              find_files = {
                find_command = {
                  'rg',
                  '--files',
                  '--sortr=modified',
                  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
                  '--hidden',
                  '--glob',
                  '!**/.git/*',
                },
              }
            }
          }
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>b', builtin.buffers, {})
          vim.keymap.set('n', '<leader>f', builtin.find_files, {})
          vim.keymap.set('n', '<leader>g', builtin.git_status, {})
          vim.keymap.set('n', '<leader>l', builtin.live_grep, {})

          require('telescope').load_extension('fzf')
          require('telescope').load_extension('ui-select')
        '';
      }
      { plugin = telescope-fzf-native-nvim; }
      { plugin = telescope-ui-select-nvim; }
      {
        plugin = nvim-autopairs;
        config = ''
          require('nvim-autopairs').setup{
            disable_in_visualblock = false,
            enable_check_bracket_line = false,
          }
        '';
      }
      { plugin = lazydev-nvim; }
      {
        plugin = typescript-tools-nvim;
        config = ''
          require('typescript-tools').setup{
            settings = {
              filetypes = {
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'vue',
              },
            },
          }
        '';
      }
    ];
  };
}
