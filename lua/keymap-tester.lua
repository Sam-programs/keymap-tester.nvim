local function esc(str)
   return vim.api.nvim_replace_termcodes(str, true, false, true)
end

local print_lines = function(lines)
   for _, line in pairs(lines) do
      vim.print(line)
   end
end

local Error = function (keys,expected,real,msg)
   print('\n' .. vim.o.ft .. ':',msg .. ' failed\n')
   print('keys:',"\"".. keys .. "\"")
   print('expected:\n')
   print_lines(expected)
   print('\ngot:')
   print_lines(real)
   print('\n')
end

local function checker(keys,expect, msg)
   expect = vim.split(expect, '\n')
   local lines = vim.api.nvim_buf_get_lines(0,0,-1, false)
   if #lines ~= #expect then
      Error(keys,expect,lines,msg)
      return
   end
   for i, line in pairs(expect) do
      if line ~= lines[i] then
         Error(keys,expect,lines,msg)
         return
      end
   end
end

local feedkeys = vim.api.nvim_feedkeys
vim.api.nvim_feedkeys = function(keys,mode,ignored)
   feedkeys(keys,'i' .. mode,ignored)
end

local function Test(keys, expect, err, filetype)
   vim.o.ft = filetype
   vim.api.nvim_feedkeys('i' .. esc(keys) .. esc('<esc>'),"tx",false)
   -- redraw for checker to be able to read the change
   vim.cmd.redraw()
   checker(keys,expect,err)
   vim.cmd("%d")
end

return Test
