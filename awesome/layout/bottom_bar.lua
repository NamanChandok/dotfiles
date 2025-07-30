local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")
local wibox = require("wibox")
local naughty = require("naughty")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ Modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ Modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

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

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "I", "II", "III", "IV", "V" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                id = "icon_role",
                widget = wibox.widget.imagebox,
                resize = true,
            },
            create_callback = function(self, c, index, objects)
                if c.class == "dev.zed.Zed" then
                    local z_icon_path = "/usr/share/pixmaps/zed.png"
                    if gears.filesystem.file_readable(z_icon_path) then
                        self:get_children_by_id("icon_role")[1].image = gears.surface.load_uncached(z_icon_path)
                    end
                elseif c.class == "obsidian" then
                    local ob_icon_path = "/usr/share/pixmaps/obsidian.png"
                    if gears.filesystem.file_readable(ob_icon_path) then
                        self:get_children_by_id("icon_role")[1].image = gears.surface.load_uncached(ob_icon_path)
                    end
                else
                    self:get_children_by_id("icon_role")[1].image = gears.surface(c.icon)
                end
            end,
            layout = wibox.layout.align.horizontal,
        }
    }
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s, height = 26, bg = "#0c0c0c9a" })

    -- Add widgets to the wibox
    s.mywibox:setup {
        { layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal, spacing = 5,
                rounded_container(s.mytaglist),
            },
            { layout = wibox.layout.fixed.horizontal }, rounded_container(s.mytasklist)
        },
        margins = 2,
        widget = wibox.container.margin
    }
end)
