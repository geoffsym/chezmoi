local is_ssh = os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil or os.getenv("SSH_CONNECTION") ~= nil

-- If we are NOT in an SSH session, return an empty spec to skip loading entirely
if not is_ssh then
  return {}
end

-- Use OSC 52 clipboard provider over SSH
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Use clean emojis for lazy.nvim UI over SSH
require("lazy.core.config").options.ui.icons = {
  cmd = "⌘ ",
  config = "🛠️ ",
  event = "📅 ",
  ft = "📂 ",
  init = "⚙️ ",
  keys = "🗝️ ",
  plugin = "🔌 ",
  runtime = "💻 ",
  require = "🌙 ",
  source = "📄 ",
  start = "🚀 ",
  task = "📌 ",
  lazy = "💤 ",
  loaded = "●",
  not_loaded = "○",
}

return {
  -- 1. Disable mini.icons and enable nvim-web-devicons
  { "nvim-mini/mini.icons", enabled = false },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    opts = {
      override_by_filename = {
        ["README.md"] = {
          icon = "📖",
          color = "#51a0cf",
          name = "README"
        },
        ["readme.md"] = {
          icon = "📖",
          color = "#51a0cf",
          name = "README"
        },
        ["LICENSE"] = {
          icon = "📜",
          color = "#cbcb41",
          name = "License"
        },
        ["license"] = {
          icon = "📜",
          color = "#cbcb41",
          name = "License"
        },
        ["Makefile"] = {
          icon = "🛠️",
          color = "#6d8086",
          name = "Makefile"
        },
        ["makefile"] = {
          icon = "🛠️",
          color = "#6d8086",
          name = "Makefile"
        },
        [".pre-commit-config.yaml"] = {
          icon = "⚙️",
          color = "#fafafa",
          name = "PreCommitConfig"
        },
        [".pre-commit-config.yml"] = {
          icon = "⚙️",
          color = "#fafafa",
          name = "PreCommitConfig"
        },
      },
      override_by_extension = {
        ["yaml"] = {
          icon = "⚙️",
          color = "#fafafa",
          name = "Yaml"
        },
        ["yml"] = {
          icon = "⚙️",
          color = "#fafafa",
          name = "Yaml"
        },
        ["in"] = {
          icon = "📥",
          color = "#51a0cf",
          name = "Input"
        },
      }
    }
  },

  -- 2. Load the emoji theme
  {
    "adelarsq/vim-emoji-icon-theme",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
  },

  -- 3. Override Neo-tree to use Emojis for folders and git status
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "📁",
          folder_open = "📂",
          folder_empty = "🈚",
          default = "📄",
        },
        git_status = {
          symbols = {
            added = "✳️",
            modified = "✏️",
            deleted = "❌",
            renamed = "🔄",
            untracked = "❓",
            ignored = "🚫",
            unstaged = "⚠️",
            staged = "☑️",
            conflict = "💥",
          },
        },
      },
      renderer = {
        icons = {
          webdev_colors = false, -- Disable colors to ensure emojis render naturally
          show = {
            file = true,
            folder = true,
            folder_arrow = false, -- Hide arrows if they are broken glyphs
            git = true,
          },
        },
      },
    },
  },

  -- 4. Override Snacks Dashboard (The Main Menu) and Picker to use Emoji/Text icons and disable NerdFont file icons
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = "🔍", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "📄", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "⏳", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "📝", key = "g", desc = "Grep Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = "⚙️",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "🔄", key = "s", desc = "Restore Session", section = "session" },
            { icon = "📦", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "💤", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "🚪", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      picker = {
        prompt = "🔍 ",
        icons = {
          files = {
            enabled = true, -- Keep icons enabled but use safe Unicode/Emojis
            dir = "📁 ",
            dir_open = "📂 ",
            file = "📄 ",
          },
          kinds = {
            Folder = "📁 ",
            File = "📄 ",
          },
          ui = {
            live = "🔍 ",
            selected = "● ",
            unselected = "○ ",
          },
          git = {
            enabled = true,
            added = "+",
            deleted = "-",
            modified = "~",
            renamed = "R",
            untracked = "?",
            ignored = " ",
            staged = "●",
          },
        },
      },
      notifier = {
        icons = {
          error = "❌ ",
          warn = "⚠️ ",
          info = "ℹ️ ",
          debug = "🐞 ",
          trace = "🔍 ",
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        icons_enabled = false, -- Disable all icons
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      })
      return opts
    end,
  },

  -- 6. Bufferline configuration: text indicators and slant separators
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        separator_style = "slant",
        buffer_close_icon = "x",
        close_icon = "X",
        modified_icon = "*",
        indicator = { icon = ">" },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      })
      return opts
    end,
  },
  -- 7. Gitsigns: override symbols to use standard ASCII (+, -, ~, ?, ^) over SSH
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
      },
    },
  },

  -- 8. Which-key: disable mapping icons over SSH
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.icons = {
        mappings = false, -- Disable NerdFont icons next to keybindings
        rules = false, -- Disable automatic icon rules
        separator = "->", -- Replaces NerdFont separator arrow
        breadcrumb = ">",
        group = "+",
        keys = {
          BS = "BS",
          C = "C-",
          CR = "Enter",
          D = "D-",
          Down = "↓",
          Esc = "Esc",
          F1 = "F1",
          F2 = "F2",
          F3 = "F3",
          F4 = "F4",
          F5 = "F5",
          F6 = "F6",
          F7 = "F7",
          F8 = "F8",
          F9 = "F9",
          F10 = "F10",
          F11 = "F11",
          F12 = "F12",
          Left = "←",
          M = "M-",
          NL = "NL",
          Right = "→",
          S = "S-",
          ScrollWheelDown = "ScrollDown",
          ScrollWheelUp = "ScrollUp",
          Space = "Space",
          Tab = "Tab",
          Up = "↑",
        },
      }
      -- Disable the title bar to completely remove the top-left keyboard icon
      opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
        title = false,
      })
      return opts
    end,
  },

  -- 9. Noice: override command line icons to use safe ASCII/Unicode over SSH
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          cmdline = { icon = ":" },
          search_down = { icon = "🔍↓" },
          search_up = { icon = "🔍↑" },
          filter = { icon = "!" },
          lua = { icon = "Lua" },
          help = { icon = "Help" },
          input = { icon = "Input" },
        },
      },
    },
  },

  -- 10. Blink.cmp: override kind icons to use beautiful Emojis over SSH (no broken NerdFont glyphs)
  {
    "Saghen/blink.cmp",
    opts = {
      appearance = {
        kind_icons = {
          Text = "📝",
          Method = "⚙️",
          Function = "⚙️",
          Constructor = "🛠️",
          Field = "🏷️",
          Variable = "📦",
          Class = "💎",
          Interface = "🔌",
          Module = "📦",
          Property = "🔖",
          Unit = "📏",
          Value = "🔢",
          Enum = "🗂️",
          Keyword = "🔑",
          Snippet = "✂️",
          Color = "🎨",
          File = "📄",
          Reference = "🔗",
          Folder = "📁",
          EnumMember = "🗃️",
          Constant = "🔒",
          Struct = "🧱",
          Event = "🔔",
          Operator = "➕",
          TypeParameter = "📐",
        },
      },
    },
  },

  -- 11. Render-markdown: override link icons to use beautiful Emojis over SSH (no broken NerdFont glyphs)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      callout = {
        note = { raw = "[!NOTE]", rendered = "ℹ️ Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "💡 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "📢 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "⚠️ Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "🔥 Caution", highlight = "RenderMarkdownError" },
        abstract = { raw = "[!ABSTRACT]", rendered = "📋 Abstract", highlight = "RenderMarkdownInfo" },
        summary = { raw = "[!SUMMARY]", rendered = "📋 Summary", highlight = "RenderMarkdownInfo" },
        tldr = { raw = "[!TLDR]", rendered = "📋 Tldr", highlight = "RenderMarkdownInfo" },
        info = { raw = "[!INFO]", rendered = "ℹ️ Info", highlight = "RenderMarkdownInfo" },
        todo = { raw = "[!TODO]", rendered = "☑️ Todo", highlight = "RenderMarkdownInfo" },
        hint = { raw = "[!HINT]", rendered = "💡 Hint", highlight = "RenderMarkdownSuccess" },
        success = { raw = "[!SUCCESS]", rendered = "✅ Success", highlight = "RenderMarkdownSuccess" },
        check = { raw = "[!CHECK]", rendered = "✅ Check", highlight = "RenderMarkdownSuccess" },
        done = { raw = "[!DONE]", rendered = "✅ Done", highlight = "RenderMarkdownSuccess" },
        question = { raw = "[!QUESTION]", rendered = "❓ Question", highlight = "RenderMarkdownWarn" },
        help = { raw = "[!HELP]", rendered = "❓ Help", highlight = "RenderMarkdownWarn" },
        faq = { raw = "[!FAQ]", rendered = "❓ Faq", highlight = "RenderMarkdownWarn" },
        attention = { raw = "[!ATTENTION]", rendered = "⚠️ Attention", highlight = "RenderMarkdownWarn" },
        failure = { raw = "[!FAILURE]", rendered = "❌ Failure", highlight = "RenderMarkdownError" },
        fail = { raw = "[!FAIL]", rendered = "❌ Fail", highlight = "RenderMarkdownError" },
        missing = { raw = "[!MISSING]", rendered = "❌ Missing", highlight = "RenderMarkdownError" },
        danger = { raw = "[!DANGER]", rendered = "🔥 Danger", highlight = "RenderMarkdownError" },
        error = { raw = "[!ERROR]", rendered = "❌ Error", highlight = "RenderMarkdownError" },
        bug = { raw = "[!BUG]", rendered = "🐛 Bug", highlight = "RenderMarkdownError" },
        example = { raw = "[!EXAMPLE]", rendered = "⭐ Example", highlight = "RenderMarkdownHint" },
        quote = { raw = "[!QUOTE]", rendered = "💬 Quote", highlight = "RenderMarkdownQuote" },
        cite = { raw = "[!CITE]", rendered = "💬 Cite", highlight = "RenderMarkdownQuote" },
      },
      link = {
        icon = "🔗 ",
        hyperlink = "🔗 ",
        image = "🖼️ ",
        email = "📧 ",
        footnote = {
          icon = "🛈 ",
        },
        wiki = {
          icon = "🔗 ",
        },
        custom = {
          web = { icon = "🔗 ", pattern = "^http" },
          apple = { icon = "🍎 ", pattern = "apple%.com", kind = "url" },
          discord = { icon = "💬 ", pattern = "discord%.com", kind = "url" },
          github = { icon = "🐙 ", pattern = "github%.com", kind = "url" },
          gitlab = { icon = "🦊 ", pattern = "gitlab%.com", kind = "url" },
          google = { icon = "🔍 ", pattern = "google%.com", kind = "url" },
          hackernews = { icon = "📰 ", pattern = "ycombinator%.com", kind = "url" },
          linkedin = { icon = "💼 ", pattern = "linkedin%.com", kind = "url" },
          microsoft = { icon = "🪟 ", pattern = "microsoft%.com", kind = "url" },
          neovim = { icon = "💻 ", pattern = "neovim%.io", kind = "url" },
          reddit = { icon = "🤖 ", pattern = "reddit%.com", kind = "url" },
          slack = { icon = "💬 ", pattern = "slack%.com", kind = "url" },
          stackoverflow = { icon = "💬 ", pattern = "stackoverflow%.com", kind = "url" },
          steam = { icon = "🎮 ", pattern = "steampowered%.com", kind = "url" },
          twitter = { icon = "🐦 ", pattern = "twitter%.com", kind = "url" },
          wikipedia = { icon = "📖 ", pattern = "wikipedia%.org", kind = "url" },
          x = { icon = "✖️ ", pattern = "x%.com", kind = "url" },
          youtube = { icon = "📺 ", pattern = "youtube[^.]*%.com", kind = "url" },
          youtube_short = { icon = "📺 ", pattern = "youtu%.be", kind = "url" },
        },
      },
    },
  },

  -- 12. Trouble: override symbols/kinds to use safe Emoji/ASCII over SSH
  {
    "folke/trouble.nvim",
    opts = {
      icons = {
        indent = {
          top           = "│ ",
          middle        = "├╴",
          last          = "└╴",
          fold_open     = "▼ ",
          fold_closed   = "▶ ",
          ws            = "  ",
        },
        folder_closed   = "📁 ",
        folder_open     = "📂 ",
        kinds = {
          Array         = "🗂️ ",
          Boolean       = "☯️ ",
          Class         = "💎 ",
          Constant      = "🔒 ",
          Constructor   = "🛠️ ",
          Enum          = "🗂️ ",
          EnumMember    = "🗃️ ",
          Event         = "🔔 ",
          Field         = "🏷️ ",
          File          = "📄 ",
          Function      = "⚙️ ",
          Interface     = "🔌 ",
          Key           = "🔑 ",
          Method        = "⚙️ ",
          Module        = "📦 ",
          Namespace     = "📦 ",
          Null          = "❌ ",
          Number        = "🔢 ",
          Object        = "📦 ",
          Operator      = "➕ ",
          Package       = "📦 ",
          Property      = "🔖 ",
          String        = "📝 ",
          Struct        = "🧱 ",
          TypeParameter = "📐 ",
          Variable      = "📦 ",
        },
      },
    },
  },

}
