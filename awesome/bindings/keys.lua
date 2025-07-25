local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup")
local switcher = require("awesome-switcher")

switcher.settings.preview_box = false

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ Modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ Modkey, }, "`", function() mymainmenu:toggle() end,
        { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ "Mod1", }, "Tab",
        function()
            switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
        end,
        { description = "switch windows", group = "client" }),
    awful.key({ "Mod1", "Shift" }, "Tab",
        function()
            switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
        end,
        { description = "switch windows reverse", group = "client" }),
    awful.key({ Modkey }, "Tab",
        function()
            awful.spawn("rofi -show window -show-icons")
        end,
        { description = "show all windows", group = "client" }),

    -- Standard program
    awful.key({ Modkey, }, "Return", function() awful.spawn(Terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ Modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ Modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ Modkey, "Shift" }, "s", function() awful.spawn("flameshot gui") end,
        { description = "take screenshot", group = "launcher" }),
    awful.key({}, "Print", function() awful.spawn("flameshot gui") end,
        { description = "take screenshot", group = "launcher" }),

    -- Prompt
    awful.key({ Modkey }, "r", function() awful.spawn("rofi -show drun -show-icons") end,
        { description = "run prompt", group = "layout" }),
    awful.key({ Modkey }, "e", function() awful.spawn("nautilus") end,
        { description = "run prompt", group = "layout" })
)

clientkeys = gears.table.join(
    awful.key({ Modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ "Mod1" }, "F4", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ Modkey, }, "Down",
        function(c)
            local x = c.maximized
            if x then
                c.maximized = false
                c:raise()
            end
            if not x then
                c.minimized = true
            end
        end,
        { description = "minimize", group = "client" }),
    awful.key({ Modkey, }, "Up",
        function(c)
            c.maximized = true
            c:raise()
        end,
        { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ Modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ Modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" })
    )
end

-- Set keys
root.keys(globalkeys)
-- }}}
