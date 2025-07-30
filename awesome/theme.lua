local beautiful                                     = require("beautiful")
local theme_assets                                  = require("beautiful.theme_assets")
local xresources                                    = require("beautiful.xresources")
local dpi                                           = xresources.apply_dpi
local themes_path                                   = os.getenv("HOME") .. "/.config/awesome/" -- gfs.get_themes_dir()

beautiful.bg_normal                                 = "#0c0c0c"
beautiful.bg_focus                                  = "#0c0c0c"
beautiful.bg_systray                                = beautiful.bg_normal
beautiful.fg_normal                                 = "#c1c1c1"
beautiful.fg_focus                                  = "#eeeeee"

beautiful.border_normal                             = "#0c0c0c"
beautiful.border_focus                              = "#222222"
beautiful.border_marked                             = "#a06666"

beautiful.taglist_bg_focus                          = "#333333"
beautiful.taglist_bg_urgent                         = "#a06666"
beautiful.taglist_fg_focus                          = "#eeeeee"
beautiful.taglist_fg_urgent                         = "#000000"

local taglist_square_size                           = dpi(0)
beautiful.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
    taglist_square_size, beautiful.fg_normal
)
beautiful.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
    taglist_square_size, beautiful.fg_normal
)

beautiful.menu_bg_focus                             = "#333333"
beautiful.menu_fg_focus                             = "#eeeeee"
beautiful.menu_border_width                         = dpi(5)
beautiful.menu_border_color                         = "#0C1112"
beautiful.menu_height                               = 20
beautiful.menu_width                                = 180
beautiful.menu_bg_normal                            = "#0c0c0c"
beautiful.menu_fg_normal                            = "#cccccc"

beautiful.menu_height                               = dpi(20)
beautiful.menu_width                                = dpi(190)

beautiful.awesome_icon                              = theme_assets.awesome_icon(
    beautiful.menu_height, beautiful.fg_normal, beautiful.bg_normal
)

beautiful.titlebar_maximized_button_normal_inactive = themes_path .. "icons/maximized_normal_inactive.png"
beautiful.titlebar_maximized_button_focus_inactive  = themes_path .. "icons/maximized_focus_inactive.png"
beautiful.titlebar_maximized_button_normal_active   = themes_path .. "icons/maximized_normal_active.png"
beautiful.titlebar_maximized_button_focus_active    = themes_path .. "icons/maximized_focus_active.png"

beautiful.titlebar_minimize_button_normal           = themes_path .. "icons/minimize_normal.png"
beautiful.titlebar_minimize_button_focus            = themes_path .. "icons/minimize_focus.png"

beautiful.titlebar_close_button_normal              = themes_path .. "icons/close_normal.png"
beautiful.titlebar_close_button_focus               = themes_path .. "icons/close_focus.png"

beautiful.icon_theme                                = "/usr/share/icons/WhiteSur-grey-dark"

beautiful.systray_icon_spacing                      = dpi(6)
