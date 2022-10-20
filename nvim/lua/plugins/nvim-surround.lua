require("nvim-surround").setup({
  surrounds = {
    invalid_key_behavior = function(char)
      return { char, char }
    end,
  },
})
