-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "roxterm"
dark_terminal = "xfce4-terminal"
fm = "thunar"
editor = "vim"
geditor = "gvim"
irc = "irssi"
locker = "slock"
browser = "firefox"
ec = "emacsclient -c"
et = "emacsclient -t"

editor_cmd = dark_terminal .. " -e " .. editor
irc_cmd = dark_terminal.. " -e " .. irc
lock_cmd = terminal .. " -e " .. locker
emacs_terminal_cmd = terminal .. " -e " .. et

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,            -- 1
    awful.layout.suit.tile.left,       -- 2
    awful.layout.suit.tile.bottom,     -- 3
    awful.layout.suit.tile.top,        -- 4
    awful.layout.suit.fair,            -- 5
    awful.layout.suit.fair.horizontal, -- 6
    awful.layout.suit.spiral,          -- 7
    awful.layout.suit.spiral.dwindle,  -- 8
    awful.layout.suit.max,             -- 9
    awful.layout.suit.max.fullscreen,  -- 10
    awful.layout.suit.floating,        -- 11
    awful.layout.suit.magnifier        -- 12
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

 -- {{{ Tags
 -- Define a tag table which will hold all screen tags.
 tags = {
   names  = { "1-FF ", "2-Emacs ", "3-PDF ", "4-Pic ", "5-IM", "6-Win"},
   layout = { layouts[1], layouts[10], layouts[3], layouts[1], layouts[1],
              layouts[1]
 }}
 for s = 1, screen.count() do
     -- Each screen has its own tag table.
     tags[s] = awful.tag(tags.names, s, tags.layout)
 end
 -- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
                                    { "EClient", ec },
                                    { "ECLI", emacs_terminal_cmd },
                                    { "File", fm },
                                    { "Firefox", browser },
                                    { "Lock", lock_cmd },
                                    { "Light", terminal },
                                    { "Dark", dark_terminal },
                                    { "IRC", irc_cmd },
                                    { "Awesome", myawesomemenu },
                                    { "Poweroff", terminal .. " -e poweroff "},
                                    { "Reboot", terminal .. " -e reboot"}
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %Y 年 %m 月 %d 日 %H:%M:%S %A")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(dark_terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({modkey }, "r", function() awful.util.spawn( "dmenu_run"  ) end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true,
                     tag = tags[1][6],
                     switchtotag = true
                   }
    },

    { rule = { class = "Vlc" },
       properties = { tag = tags[1][6],
                      switchtotag = true
                   }
    },

    { rule = { class = "pinentry" },
      properties = { floating = true } },

    { rule = { class = "Roxterm" },
      properties = { opacity = 0.8 } },

    { rule = { class = "Emacs", instance = "emacs" },
      properties = { opacity = 0.9,
                     switchtotag = true,
		     tag = tags[1][2]
    } },

    { rule = { class = "Gimp" },
      properties = { tag = tags[1][6],
                     switchtotag = true,
                     floating = true
                   }
    },

    { rule = { class = "Gimp", role = "toolbox" },
        properties = { tag = tags[1][6],
                        switchtotag = true,
                        floating = true,
                        maximized_vertical = true,
                        ontop = true
                    }
    },

    -- Place all libreoffice windows on tag "office"
    { rule = { class = "libreoffice[%a%d_-]*" },
      properties = { tag = tags[1][3],
                     switchtotag = true
                   }
    },

    { rule = { class = "Virtualbox" },
      properties = { tag = tags[1][6],
                     switchtotag = true
                   }
    },

    { rule = { class = "Wireshark", name = "Wireshark" },
        properties = { floating = true }
    },

    { rule = { class = "Thunar" },
      properties = { tag = tags[1][4],
                     switchtotag = true
                   }
    },

    -- Firefox YouTube: fullscreen appears in background
    { rule = { instance = "plugin-container" },
      properties = { floating = true,
                    maximized_vertical = false,
                    maximized_horizontal = false
                   }
    },

    { rule = { class = "Firefox" },
    properties = { maximized_vertical = true,
                   maximized_horizontal = true,
                   switchtotag = true,
                   floating = false,
                   opacity = 0.9
                 }
    },

    { rule = { class = "Zathura" },
    properties = { tag = tags[1][3],
                   switchtotag = true
                 }
    },

    -- For Chrome
    { rule = { instance = "exe" },
      properties = { floating = true } },
    -- For pidgin
    -- http://stackoverflow.com/questions/5120399/setting-windows-layout-for-a-specific-application-in-awesome-wm

    { rule = { class = "Pidgin", role = "buddy_list" },
        properties = { floating=true,
                    tag = tags[1][5],
                    maximized_vertical=true,
                    opacity = 0.9,
                    maximized_horizontal=false },
        callback = function (c)
            local cl_width = 250   -- width of buddy list window
            local def_right = true -- default placement. note: you have to restart
                                   -- pidgin for changes to take effect

            local scr_area = screen[c.screen].workarea
            local cl_strut = c:struts()
            local geometry = nil

            -- adjust scr_area for this client's struts
            if cl_strut ~= nil then
                if cl_strut.left ~= nil and cl_strut.left > 0 then
                    geometry = {x=scr_area.x-cl_strut.left, y=scr_area.y,
                                width=cl_strut.left}
                elseif cl_strut.right ~= nil and cl_strut.right > 0 then
                    geometry = {x=scr_area.x+scr_area.width, y=scr_area.y,
                                width=cl_strut.right}
                end
            end
            -- scr_area is unaffected, so we can use the naive coordinates
            if geometry == nil then
                if def_left then
                    c:struts({left=cl_width, right=0})
                    geometry = {x=scr_area.x, y=scr_area.y,
                                width=cl_width}
                else
                    c:struts({right=cl_width, left=0})
                    geometry = {x=scr_area.x+scr_area.width-cl_width, y=scr_area.y,
                                width=cl_width}
                end
            end
            c:geometry(geometry)
        end },

    { rule = { class = "Pidgin", role = "conversation" },
        properties = {
                    opacity = 0.9,
                    tag = tags[1][5],
                    maximized_vertical = true,
                    maximized_horizontal = false }, },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

--Autostart{{{
  --为了让启动过程更加平滑，xrandr应该在awesome启动前执行，所以移到xinitrc中去
  --awful.util.spawn_with_shell("xrandr --output LVDS1 --auto")
  -- awful.util.spawn_with_shell("xrandr --output VGA1 --left-of LVDS1 --auto")
  awful.util.spawn_with_shell(" compton --config ~/.compton.conf -b")
  -- awful.util.spawn_with_shell("compton -cCG -o 0.75 -f 0.05 -t 0.01 -l 0.01 -r 2.5 &")
  awful.util.spawn_with_shell("wicd-gtk --tray &")
  awful.util.spawn_with_shell("python2.7 .goagent/local/proxy.py &")
  awful.util.spawn_with_shell("fcitx")
  awful.util.spawn_with_shell("goldendict &")
  awful.util.spawn_with_shell("dropboxd")
  awful.util.spawn_with_shell("deepin-mucis-player &")
  awful.util.spawn_with_shell("yunio &")
  awful.util.spawn_with_shell("volti")
  awful.util.spawn_with_shell("pidgin ")
  awful.util.spawn_with_shell("offlineimap &")
  awful.util.spawn_with_shell("emacs")
  awful.util.spawn_with_shell("~/.config/awesome/autorun/mail_check &")
-- }}}
