require("cmp_dictionary").setup({
  dic = {
    ["*"] = { "/usr/share/dict/words" },
    ["lua"] = "path/to/lua.dic",
    ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
    filename = {
      ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
    },
    filepath = {
      ["%.tmux.*%.conf"] = "path/to/tmux.dic"
    },
  },
  -- The following are default values, so you don't need to write them if you don't want to change them
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = "wn %s -over",
  async = false,
  capacity = 5,
  debug = false,
})
