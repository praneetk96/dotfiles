-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

----------------------- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
-- keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<C-+>", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<C-->", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Buffer
keymap.set("n", "<C-n>", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<C-w>", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<C-Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<C-S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<C-S-n>", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Custom shortcut
keymap.set("n", "<C-s>", "<cmd>:w!<CR>", { desc = "Save currently opened file" }) --  save currently opened file
keymap.set("n", "<C-q>", "<cmd>:q!<CR>", { desc = "Close currently opened file" }) --  close currently opened file
keymap.set("n", "<C-c>", "<cmd>:nohlsearch<CR>", { desc = "Clear search highlights" }) --  clear search highlights
keymap.set("n", "<C-S-.>", "<cmd>:g/^$/d<CR>", { desc = "Remove empty line fast" }) --  removes empty/blank lines from a file
keymap.set("n", "<C-b>", "<cmd>:NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" }) --  toggle nvim-tree
keymap.set("n", "<C-f>", "<cmd>:Telescope find_files<CR>", { desc = "Open telescope find files" }) --  open telescope
keymap.set("n", "<C-F>", "<cmd>:Telescope<CR>", { desc = "Open telescope find text" }) --  open telescope

-- Indentation
keymap.set("v", "<C-Tab>", ">gv", { noremap = true, silent = true, desc = "Indent lines or a block to right" }) --  indent to right
keymap.set("v", "<C-S-Tab>", "<gv", { noremap = true, silent = true, desc = "Indent lines or a block to left" }) --  indent to left

-- IDE style comment toggle with 'control + /' key
keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Comment Toggle" }) -- Single line Comment Toggle
keymap.set("v", "<C-/>", "gcc", { remap = true, desc = "Comment Toggle" }) -- Multiple line Comment Toggle

-- Function to yank the entire file in Neovim and notify
function yank_all()
  -- Move to the first line
  vim.api.nvim_command('normal! gg')
  
  -- Start visual line selection
  vim.api.nvim_command('normal! V')
  
  ---- Move to the last line
  --vim.api.nvim_command('normal! GG')

  -- Move to the second-to-last line to avoid yanking the extra blank line
  vim.api.nvim_command('normal! G$')
  
  -- Yank the selected lines
  vim.api.nvim_command('normal! y')

  -- Notify that the file has been yanked
  vim.notify('Entire file yanked!', vim.log.levels.INFO)
end

function yank_all_new()
  -- Move to the first line
  vim.api.nvim_feedkeys("gg", "n", false)
  
  -- Start visual line selection
  vim.api.nvim_feedkeys("V", "n", false)
  
  -- Move to the last line (without yanking extra blank line)
  vim.api.nvim_feedkeys("G$", "n", false)
  
  -- Yank the selected lines
  vim.api.nvim_feedkeys("y", "n", false)

  -- Notify that the file has been yanked
  vim.notify('Entire file yanked!', vim.log.levels.INFO)
end


-- Keymap to call the yank_all function with just <leader>
-- keymap.set('n', '<leader>', ':lua yank_all_new()<CR>', { noremap = true, silent = true })
-- keymap.set('n', '<leader>', ':%y+<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>', function()
    vim.cmd('%y+')
    vim.notify(' File yanked to clipboard', vim.log.levels.INFO)
end, { noremap = true, silent = true })


-- Keymap to reverse the order of lines in a file
-- keymap.set('n', '<C-r>', ':g/^/m0<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-r>', function()
  -- Capture current buffer lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Reverse the lines
  for i = 1, math.floor(#lines / 2) do
    lines[i], lines[#lines - i + 1] = lines[#lines - i + 1], lines[i]
  end

  -- Set reversed lines back to the buffer in one go
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Notify
  vim.notify('🔄 Reversed all lines — press u to undo', vim.log.levels.INFO)
end, { noremap = true, silent = true })
