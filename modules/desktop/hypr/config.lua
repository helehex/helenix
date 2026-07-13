-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

local monitors = {
    "desc:Dell Inc. Dell S2417DG #ASM6P/O8Uczd",
    "desc:SEK SE19HY10",
}

hl.monitor({
    output   = monitors[1],
    mode     = "2560x1440@144",
    position = "auto-center-right",
    scale    = "1",
}, {
    output   = monitors[2],
    mode     = "preferred",
    position = "auto-center-left",
    scale    = "1",
}, {
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "rofi -show drun"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

hl.workspace_rule({ workspace = "1", monitor = monitors[1], default = true })
hl.workspace_rule({ workspace = "name:discord", monitor = monitors[2], default = true })

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper & waybar")
    hl.exec_cmd("easyeffects", {
        workspace = "name:audio silent",
        monitor = monitors[2],
        no_initial_focus = true,
    })
    hl.exec_cmd("discord", {
        workspace = "name:discord silent",
        monitor = monitors[2],
        no_initial_focus = true,
    })
    -- hl.timer(function()
    --     hl.dispatch(hl.dsp.focus({ workspace = "1" }))
    -- end, { timeout = 100, type = "oneshot" })
end)

-- Hot reloading
hl.on("config.reloaded", function()
    hl.exec_cmd("pkill -SIGUSR2 waybar")
end)


----------------------
---- WINDOW RULES ----
----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- hl.window_rule({
--     match = { class = "Alacritty" },
--     workspace = "name:test silent",
--     monitor = monitors[2],
--     no_initial_focus = true,
-- })

hl.window_rule({
    name = "discord",
    match = { class = "discord" },
    workspace = "name:discord silent",
    monitor = monitors[2],
    no_initial_focus = true,
})

hl.window_rule({
    name = "audio",
    match = { class = ".*easyeffects" },
    workspace = "name:audio silent",
    monitor = monitors[2],
    no_initial_focus = true,
})

hl.window_rule({
    name = "steam",
    match = { class = "steam" },
    workspace = "name:steam",
    monitor = monitors[1]
})

hl.window_rule({
    name = "games",
    match = { class = "(steam_app_\\d+)|(haven.*)" },
    fullscreen_state = 2,
    sync_fullscreen = true,
    monitor = monitors[1]
})

hl.window_rule({
    match = { class = "brave-browser" },
    workspace = "name:brave silent",
    monitor = monitors[2],
    no_initial_focus = true,
})

-- start browsers in their last workspaces
local browser_workspaces_path = os.getenv("HOME") .. "/.config/BraveSoftware/Brave-Browser/workspaces.json"
local browser_workspaces_file = io.open(browser_workspaces_path, "a+")
if browser_workspaces_file then
    for title, workspace in browser_workspaces_file:read("*a"):gmatch('"(.-)"%s*: "(.-)"%s*') do
        hl.window_rule({
            match = { class = "brave-browser", title = title },
            workspace = workspace .. " silent",
            monitor = monitors[1],
            no_initial_focus = true,
        })
    end
    browser_workspaces_file:close()
end

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- -- Hyprland-run windowrule
-- hl.window_rule({
--     name  = "move-hyprland-run",
--     match = { class = "hyprland-run" },

--     move  = "20 monitor_h-120",
--     float = true,
-- })

-- local suppressMaximizeRule = hl.window_rule({
--     -- Ignore maximize requests from all apps. You'll probably like this.
--     name           = "suppress-maximize-events",
--     match          = { class = ".*" },

--     suppress_event = "maximize",
-- })
-- suppressMaximizeRule:set_enabled(false)


-----------------
---- Cleanup ----
-----------------

-- hl.on("window.close", function(window)
--     if window.class == "brave-browser" then
--         hl.notification.create({ text = window.title .. ": " .. window.workspace.name, timeout = 2000, icon = "ok" })
--         hl.exec_cmd("jq '.\"" .. window.title .. "\" = \"" .. window.workspace.name .. "\"' " ..
--             browser_workspaces_path .. " > tmp.json && mv tmp.json " .. browser_workspaces_path)
--     end
-- end)

-- hl.on("hyprland.shutdown", function()
--     hl.dsp.exec_cmd([[hyprctl clients -j
--  | jq -r 'map(select(.class == "brave-browser") | {(.title): .workspace.name}) | add'
--  > ~/.config/BraveSoftware/Brave-Browser/workspaces.json]])
-- end)


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("command hyprctl reload"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + X", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + escape",
    hl.dsp.exec_cmd(". ~/helenix/modules/desktop/hypr/graceful-shutdown.sh"))
-- hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        border_size      = 2,
        gaps_in          = 2,
        gaps_out         = 2,

        col              = {
            active_border   = { colors = { "rgba(e8b43aee)", "rgba(e8843aee)" }, angle = 60 },
            inactive_border = "rgba(100c08aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "master",
    },

    decoration = {
        rounding         = 16,
        rounding_power   = 1,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 0.5, 0.5 }, { 0.0, 1.1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "bounce" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "bounce", style = "popin 20%" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "bounce", style = "popin 20%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "bounce", style = "slide" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        mfact = "0.2",
        new_status = "slave",
        orientation = "bottom",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        -- force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        vrr                          = 1,
        animate_manual_resizes       = true,
        animate_mouse_windowdragging = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout           = "us",
        kb_variant          = "",
        kb_model            = "",
        kb_options          = "",
        kb_rules            = "",

        focus_on_close      = 1,
        follow_mouse        = 1,
        follow_mouse_shrink = 8,
        sensitivity         = 0, -- -1.0 - 1.0, 0 means no modification.

        -- touchpad     = {
        --     natural_scroll = false,
        -- },
    },
})


----------------
---- RENDER ----
----------------

hl.config({
    render = {
        expand_undersized_textures = false,
    }
})


----------------
---- Cursor ----
----------------

hl.config({
    cursor = {
        default_monitor = monitors[1],
        hide_on_key_press = true,
    }
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more


-------------------------
---- WORKSPACE RULES ----
-------------------------

-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
