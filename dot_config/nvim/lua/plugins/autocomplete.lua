return {
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "fallback" }, -- Disable Enter from accepting completion
        ["<Tab>"] = { "accept", "fallback" }, -- Use Tab to accept completion instead
      },
      completion = {
        menu = {
          auto_show_delay_ms = 250, -- Delay autocomplete popup by 250ms to reduce visual noise while typing
        },
      },
    },
  },
}
