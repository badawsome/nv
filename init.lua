require "user/options"
require "user/keymaps"
require "user/plugins"
require "user/coc"
require "user/colorscheme"
require "user/cmp"
require "user/treesitter"
require "user/comment"
require "user/gitsigns"
require "user/nvim-tree"
require "user/bufferline"
require "user/lualine"
require "user/project"
require "user/impatient"
require "user/indentline"
require "user/alpha"
require "user/whichkey"
require "user/autocommands"
require "user/asynctask"
require "user/ag"

vim.api.nvim_exec(
[[source ~/.config/nvim/lua/user/coc.vim]],
false)

vim.api.nvim_exec(
[[source ~/.config/nvim/lua/user/asynctask.vim]],
false)
