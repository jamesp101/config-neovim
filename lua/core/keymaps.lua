local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")


-- Termina Escape
map('t', '<ESC>', '<C-\\><C-n>', 'Escape Terminal' )


-- Quick access to some common actions
map("n", "<leader>fw", "<cmd>w<cr>", "Write")
map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
map("n", "<C-S-h>", "<C-w><S-h>", "Move window to the left")
map("n", "<C-S-j>", "<C-w><S-j>", "Move window down")
map("n", "<C-S-k>", "<C-w><S-k>", "Move window up")
map("n", "<C-S-l>", "<C-w><S-l>", "Move window to the right")

-- Window Management 
map("n", "<C-M-j>", ":resize +2<CR>")
map("n", "<C-M-k>", ":resize -2<CR>")
map("n", "<C-M-l>", ":vertical resize +2<CR>")
map("n", "<C-M-h>", ":vertical resize -2<CR>")

-- Window Management
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-k>', '<C-w>k')



-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")


-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>db", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
map("n", "<C-.>", ":bnext<CR>")
map("n", "<C-,>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")


map('v', 'p', '"_dP', 'No yank')

-- Cancel Search highlight 
map('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>')


-- Center search results 
map('n', 'n', 'nzz', '')
map('n', 'N', 'Nzz', '')

-- Switch between light and dark modes
map("n", "<leader>ut", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end, "Toggle between light and dark themes")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")
