local completion = {}

completion["neoclide/coc.nvim"] = {
  opt = true,
  event = "BufRead",
  branch = "release",
  config = function()
    vim.api.nvim_exec(
      [[source ~/.config/nvim/lua/user/coc.vim]],
      false)
  end
}

return completion
