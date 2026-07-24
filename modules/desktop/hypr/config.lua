-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

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

-- https://wiki.hypr.land/Configuring/Basics/Monitors/

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

-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper & waybar")
    hl.exec_cmd("easyeffects", {
        workspace = "name:audio silent",
        monitor = monitors[2],
    })
end)

-- Hot reloading
hl.on("config.reloaded", function()
    hl.exec_cmd("pkill -SIGUSR2 waybar")
end)


----------------------
---- WINDOW RULES ----
----------------------

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name = "audio",
    match = { class = ".*easyeffects" },
    workspace = "name:audio silent",
    monitor = monitors[2],
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


-------------------------
---- WORKSPACE RULES ----
-------------------------

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.workspace_rule({ workspace = "1", monitor = monitors[1], default = true })
hl.workspace_rule({ workspace = "name:audio", monitor = monitors[2], default = true })


---------------------
---- KEYBINDINGS ----
---------------------

-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("command hyprctl reload"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + X", hl.dsp.window.close())
hl.bind(mainMod .. " + escape",
    hl.dsp.exec_raw(". ~/helenix/modules/desktop/hypr/save.sh ; hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

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
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        border_size      = 2,
        gaps_in          = 2,
        gaps_out         = 2,

        col              = {
            active_border   = { colors = { "rgba(e8b43aee)" }, angle = 60 },
            inactive_border = "rgba(060402ff)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "master",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 1,

        shadow         = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(000000aa)"
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = true,
    },

    binds = {
        scroll_event_delay = 10,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 0.5, 0.5 }, { 0.0, 1.1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "bounce" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "bounce", style = "popin 20%" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "bounce", style = "popin 20%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "bounce", style = "slide" })

-- https://wiki.hypr.land/Configuring/Layouts/
hl.config({
    master = {
        mfact = "0.2",
        new_status = "slave",
        orientation = "bottom",
    },
})


----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        animate_manual_resizes       = true,
        animate_mouse_windowdragging = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        focus_on_close      = 1,
        follow_mouse        = 1,
        follow_mouse_shrink = 8,
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
