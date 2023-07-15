local opts = {
  shiftwidth = 4,
  tabstop = 4,
  smartindent = true,
  expandtab = true,
  wrap = false,
  termguicolors = true,
  number = true,
  relativenumber = true,
  swapfile = false,
  backup = false,
  undofile = true,
  updatetime = 100,
  foldmethod = 'expr',
  ignorecase = true,
  joinspaces = false,
  smartcase = true,
  showmatch = true,
  wildmenu = true,
  wildmode = "longest:full,full",
  -- foldexpr = 'nvim_treesitter#foldexpr()'
}
--
-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end


-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
