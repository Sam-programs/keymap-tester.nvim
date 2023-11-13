a simple plugin that allows u to test keymaps
the plugin returns 1 function which takes 4 arguments  
1 keys to press  
2 expected output to add multiple lines use \n  
3 comment/error message  
4 filetype  
usage example with expand.nvim:  
```lua
-- init.lua
-- if u are using lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/'
vim.o.rtp = 
lazypath .. 'keymap-tester.nvim' .. ',' ..
lazypath .. 'expand.nvim' .. ','
lazypath .. 'indent.nvim'

require('expand').setup{}


-- if u don't turn off indenting you'ill have to add the extra spaces to the tests
vim.o.indentexpr = '0'

local Test = require('keymap-tester')
-- use \n for new lines
Test('if(true)<C-space>','if(true){\n\n}','if statement check','c')
Test('if(rue)<C-space>','if(true){\n\n}','should fail','c)

vim.cmd('q!')
```
```
	nvim -u NONE '+so init.lua' --headless
```
you should get an output like
```
c: should fail failed
keys: "if(rue)<C-space>"
expected:
if(true){

}

got:
if(rue){

}
```
please do not use this plugin outside of a testing enviroment it may break your config!
