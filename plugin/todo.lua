T = require("todo")

vim.api.nvim_create_user_command("TodoToggle", function()
  T.toggle()
end, {})

vim.api.nvim_create_user_command("TodoOpen", function()
  T.open()
end, {})

vim.api.nvim_create_user_command("TodoClose", function()
  T.close()
end, {})
