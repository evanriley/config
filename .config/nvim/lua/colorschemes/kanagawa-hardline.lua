local colors = {
  black = {gui = "#16161D"},
  blue = { gui = "#2D4F67"},
  cyan = {gui = "#7FB4CA"},
  green = {gui = "#76946A"},
  grey_comment = {gui = "#C8C093"},
  grey_cursor = {gui = "#16161D"},
  grey_menu = {gui = "#54546D"},
  purple = {gui = "#957FB8"},
  red = {gui = "#C34043"},
  white = {gui = "#DCD7BA"},
  yellow = {gui = "#FF9E3B"},
}

local inactive = {
  guifg = colors.grey_comment.gui,
  guibg = colors.grey_cursor.gui,
}

return {
  mode = {
    inactive = inactive,
    normal = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
    },
    insert = {
      guifg = colors.black.gui,
      guibg = colors.blue.gui,
    },
    replace = {
      guifg = colors.black.gui,
      guibg = colors.cyan.gui,
    },
    visual = {
      guifg = colors.black.gui,
      guibg = colors.purple.gui,
    },
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
    },
  },
  low = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_cursor.gui,
    },
    inactive = inactive,
  },
  med = {
    active = {
      guifg = colors.yellow.gui,
      guibg = colors.grey_cursor.gui,
    },
    inactive = inactive,
  },
  high = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_menu.gui,
    },
    inactive = inactive,
  },
  error = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
    },
    inactive = inactive,
  },
  warning = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.yellow.gui,
    },
    inactive = inactive,
  },
  bufferline = {
    separator = inactive,
    current = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
    },
    current_modified = {
      guifg = colors.black.gui,
      guibg = colors.blue.gui,
    },
    background = {
      guifg = colors.green.gui,
      guibg = colors.black.gui,
    },
    background_modified = {
      guifg = colors.blue.gui,
      guibg = colors.black.gui,
    },
  },
}
