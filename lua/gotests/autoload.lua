local M = {}
local fn = vim.fn
local shellescape = fn.shellescape

local function range(from, to)
  local step = 1
  return function(_, lastvalue)
    local nextvalue = lastvalue + step
    if step > 0 and nextvalue <= to or step < 0 and nextvalue >= to or
      step == 0
    then
      return nextvalue
    end
  end,nil, from - step
end

function M.tests(first, last)
  local bin = vim.g.gotests_bin
  if fn.executable(bin) == nil then
    print('gotests.nvim: gotests binary not found.')
    return
  end

  -- search function names
  local matchstr = vim.fn.matchstr
  local getline = vim.fn.getline
  local funcMatch = ''

  for lineno in range(first, last) do
    local funcName = matchstr(getline(lineno), [[^func\s*\(([^)]\+)\)\=\s*\zs\w\+\ze(]])
    if funcName ~= '' then
      funcMatch = funcMatch .. '|' .. funcName
    end
  end

  if funcMatch ~= '' then
    -- remove first pipe('|')
    funcMatch = string.sub(funcMatch, 2)
  else
    print('gotests.nvim: No function selected!')
    return
  end

  local tmplDir = ''
  if vim.g.gotests_template_dir ~= '' then
    tmplDir = '-template_dir ' .. shellescape(vim.g.gotests_template_dir)
  end
  local file = vim.fn.expand('%')
  local out = vim.fn.system(bin .. ' -w -only ' .. shellescape(funcMatch) .. ' ' .. tmplDir .. ' ' .. shellescape(file))

  print('gotests.nvim: ' .. out)
end

function M.alltests()
  local bin = vim.g.gotests_bin
  if fn.executable(bin) == nil then
    print('gotests.nvim: gotests binary not found.')
    return
  end

  local tmplDir = ''
  if vim.g.gotests_template_dir ~= '' then
    tmplDir = '-template_dir ' .. shellescape(vim.g.gotests_template_dir)
  end

  local file = vim.fn.expand('%')
  local out = vim.fn.system(bin .. ' -w -all ' .. tmplDir .. ' ' .. shellescape(file))
  print('gotests.nvim: ' .. out)
end

return M
