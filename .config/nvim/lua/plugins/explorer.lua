return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- Show hidden files (dotfiles) and gitignored files in the explorer
          -- by default.
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    -- Open the explorer automatically only when starting neovim with no
    -- arguments (i.e. plain `nvim`, not `nvim path/to/file`).
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("start_explorer", { clear = true }),
        callback = function()
          if vim.fn.argc() == 0 then
            require("snacks").explorer.open()
          end
        end,
      })
    end,
  },
}
