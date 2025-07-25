local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")
local wibox = require("wibox")

local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')

local media_text = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
}

-- Update text from playerctl
awful.widget.watch('playerctl metadata --format "{{ trunc(title,24) }}"', 0.2,
    function(widget, stdout, stderr)
        local output = "  " .. string.gsub((stdout ~= "" and stdout or stderr), "%s+$", "") .. "  "
        media_text:set_text(output)
    end
)
-- Make it clickable to toggle play/pause
local media_player = wibox.widget {
    media_text,
    widget = wibox.container.background,
    buttons = gears.table.join(
        awful.button({}, 1, function()
            awful.spawn("playerctl play-pause", false)
        end)
    ),
}

local mysystray = wibox.widget.systray()
-- mysystray:set_base_size(10, 1)

myawesomemenu = {
    { "Hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual",      Terminal .. " -e man awesome" },
    { "Edit Config", Editor_cmd .. " " .. awesome.conffile },
    { "Restart",     awesome.restart },
    { "Quit",        function() awesome.quit() end },
}

mypowermenu = {
    { "Reboot",    "reboot" },
    { "Hibernate", "systemctl hibernate" },
    { "Power Off", "poweroff" },
}

mymainmenu = awful.menu({
    items = { { "Awesome", myawesomemenu },
        {},
        { "Terminal",     Terminal },
        { "Browser",      "flatpak run app.zen_browser.zen" },
        { "File Manager", "nautilus" },
        {},
        { "Log Out",      function() awesome.quit() end },
        { "Power Off",    mypowermenu },
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

menubar.utils.Terminal = Terminal -- Set the Terminal for applications that require it

mytextclock = wibox.widget.textclock()


local function rounded_container(widget, bg_color)
    return wibox.widget {
        {
            widget,
            margins = 4, -- Padding inside the box
            widget = wibox.container.margin,
        },
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4) -- 6px corner radius
        end,
        bg = bg_color or "#000000",
        widget = wibox.container.background,
    }
end


focused_app = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    font = "sans 8",
    bg = "#000000"
}

client.connect_signal("focus", function(c)
    focused_app.text = (c.name or "No Title")
end)
client.connect_signal("unfocus", function()
    focused_app.text = ""
end)

awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 26, bg = "#0c0c0c9a" })

    s.mywibox.bg_normal = "#00000000"
    s.mywibox.bg_maximized = "#222222dd"


    -- Add widgets to the wibox
    s.mywibox:setup {
        { layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal, spacing = 5,
                rounded_container(mylauncher),
                rounded_container(media_player),
            },
            focused_app, -- Middle widget
            {            -- Right widgets
                layout = wibox.layout.fixed.horizontal, spacing = 5,
                rounded_container(mysystray),
                rounded_container(volume_widget {
                    widget_type = 'arc',
                    tooltip = true,
                    mute_color = "#333333",
                    main_color = "#c1c1c1",
                    step = 10,
                }),
                rounded_container(mytextclock),
            }, },
        margins = 2,
        widget = wibox.container.margin
    }
end)
