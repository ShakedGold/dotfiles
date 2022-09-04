vim.g.gruvbox_contrast_dark = 'hard'
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.gruvbox_invert_selection = '0'
vim.opt.background = "dark"

vim.cmd("colorscheme gruvbox")
vim.cmd("set mouse+=a")
vim.cmd("set pumheight=12")

require'cmp'.setup {
 sources = {
 	{ name = 'cmp_tabnine' },
 },
}

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Keymaps --

-- NvimTree --
map("n", "<C-t>", ":NvimTreeOpen<CR>", { silent = true })
map("n", "<C-S-t>", ":NvimTreeClose<CR>", { silent = true })
map("n", "<C-f>", ":NvimTreeFocus<CR>", { silent = true })

-- Barbar --
map("n", "<C-h>", ":BufferNext<CR>", { silent = true })
map("n", "<C-w>", ":BufferClose<CR>", {silent = true})

-- Telescope --
map("n", "<S-f>", ":Telescope find_files<CR>", {silent = true})
map("n", "<C-S-f>", ":Telescope live_grep<CR>", {silent = true})



