vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.swapfile = false
opt.backup = false
opt.guicursor = ""

vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})

vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#555555" })
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#ffffff",
  bold = true
})

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#111111" })

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

require("telescope").setup({})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)

vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.pack.add({
  { src = "https://github.com/ThePrimeagen/harpoon" },
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>h5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>h6", function() ui.nav_file(6) end)

vim.pack.add({
  { src = "https://github.com/tpope/vim-fugitive" },
})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
})

vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      severity = vim.diagnostic.severity.ERROR,
      border = "rounded",
      source = "always",
    })
  end,
})

vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go" },
})

vim.lsp.enable("gopls")
vim.lsp.enable("clangd")


