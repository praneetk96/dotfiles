require("config.core")
require("config.lazy")

--require("lazy").setup({{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}})


vim.api.nvim_exec([[
  augroup filetemplates
    autocmd!
    autocmd bufnewfile *.cpp 0r ~/.config/nvim/templates/main.cpp | call v:lua.templatesubstitute()
    autocmd bufnewfile *.py  0r ~/.config/nvim/templates/main.py  | call v:lua.templatesubstitute()
    autocmd bufnewfile *.sh  0r ~/.config/nvim/templates/main.sh  | call v:lua.templatesubstitute()
  augroup end
]], false)

function templatesubstitute()
  local substitutions = {
    ["%upperfile%"] = string.upper(vim.fn.expand("%:t:r")), -- filename without extension, in all caps
    ["%author%"] = "Praneet Kumar",  -- replace with your name
    ["%date%"] = os.date("%d-%m-%Y")
  }

  for pattern, value in pairs(substitutions) do
    vim.cmd(string.format("%%s/%s/%s/ge", pattern, value))
  end
end
