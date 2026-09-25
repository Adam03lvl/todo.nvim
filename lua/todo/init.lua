local T = {}

local defaults = {
  path = vim.fn.getcwd() .. "/.todo",
  cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
}

T.config = defaults
T.is_open = false

function T.setup(opts)
  opts = opts or {}
  T.config = vim.tbl_deep_extend("force", defaults, opts)
end

function T.toggle()
  if T.is_open then
    T.close()
  else
    T.open()
  end
end

function T.open()
  local buf = vim.fn.bufadd(T.config.path)
  vim.fn.bufload(buf)

  local width, height = 50, 15
  T.win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = "TO DO: " .. T.config.cwd_name,
    title_pos = "center"
  })

  T.is_open = true
end

function T.close()
  if not T.win or not vim.api.nvim_win_is_valid(T.win) then
    return
  end

  local buf = vim.api.nvim_win_get_buf(T.win)
  vim.api.nvim_buf_call(buf, function ()
    vim.cmd("silent write")
  end)

  vim.api.nvim_win_close(T.win, false)
  T.win = nil
  T.is_open = false
end

return T
