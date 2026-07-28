------------------
---- MONITORS ----
------------------

local monitors = {
    {
        output   = "desc:Dell Inc. Dell S2417DG #ASM6P/O8Uczd",
        mode     = "2560x1440@144",
        position = "auto-center-right",
        scale    = "1",
    },
    {
        output   = "desc:SEK SE19HY10",
        mode     = "preferred",
        position = "auto-center-left",
        scale    = "1",
    },
}

local map_monitor = {}
local unmap_monitor = {}
for _, user_config in ipairs(monitors) do hl.monitor(user_config) end

-- Todo: hl monitors are not discoverable on first config load...
hl.on("monitor.layout_changed", function()
    for user_id, user_config in ipairs(monitors) do
        local monitor = hl.get_monitor(user_config.output)
        if monitor then
            unmap_monitor[user_id] = user_config.output
            map_monitor[monitor.id] = user_id
        end
    end

    for _, hypr_config in ipairs(hl.get_monitors()) do
        local monitor = hl.get_monitor(hypr_config.name)
        if monitor and map_monitor[monitor.id] == nil then
            local next_user_id = #unmap_monitor + 1
            unmap_monitor[next_user_id] = hypr_config.name
            map_monitor[monitor.id] = next_user_id
        end
    end
end)


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "rofi -show drun"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper & waybar & udiskie")
    hl.exec_cmd("easyeffects")
end)

-- Hot reloading
hl.on("config.reloaded", function()
    hl.exec_cmd("pkill -SIGUSR2 waybar ; pkill hyprpaper ; hyprpaper")
end)


----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name = fileManager,
    match = { class = fileManager },
    workspace = "special",
    float = true,
})

hl.window_rule({
    name = "audio",
    match = { class = ".*easyeffects" },
    workspace = "name:audio silent",
    monitor = monitors[2].output,
})

hl.window_rule({
    name = "steam",
    match = { class = "steam" },
    workspace = "name:steam",
    monitor = monitors[1].output
})

hl.window_rule({
    name = "games",
    match = { class = "(steam_app_\\d+)|(haven.*)" },
    fullscreen_state = 2,
    sync_fullscreen = true,
    monitor = monitors[1].output
})

-- Start browsers in their last workspaces
local browser_workspaces_path = os.getenv("HOME") .. "/.config/BraveSoftware/Brave-Browser/workspaces.json"
hl.on("window.open", function(window)
    if window.class == "brave-browser" then
        local jq = io.popen(([[jq '."%s"' %s]]):format(window.title, browser_workspaces_path))
        local workspace = jq and jq:read("*l")
        if jq then jq:close() end

        if workspace and workspace ~= "null" then
            hl.dispatch(hl.dsp.window.move({
                window = window,
                workspace = workspace,
                follow = false,
            }))
        end
    end
end)

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

-- Give each monitor it's own range of 100 workspaces
-- This needs a timer delay: hl.on("workspace.created", function(workspace)...
for user_id, monitor in pairs(monitors) do
    for w = 1, 101 do
        hl.workspace_rule({
            workspace = tostring(w + ((user_id - 1) * 100)),
            monitor = monitor.output,
            default = w == 1,
        })
    end
end


---------------------
---- KEYBINDINGS ----
---------------------

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

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0

    -- Switch workspaces with mainMod + [0-9]
    hl.bind(mainMod .. " + " .. key, function()
        hl.dispatch(hl.dsp.focus({ workspace = i + (map_monitor[hl.get_active_monitor().id] - 1) * 100 }))
    end)

    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    hl.bind(mainMod .. " + SHIFT + " .. key, function()
        hl.dispatch(hl.dsp.window.move({ workspace = i + (map_monitor[hl.get_active_monitor().id] - 1) * 100 }))
    end)
end

-- New workspace
hl.bind(mainMod .. " + equal", hl.dsp.focus({ workspace = "emptynm" }))

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

hl.config({
    general = {
        border_size      = 2,
        gaps_in          = 2,
        gaps_out         = 2,

        col              = {
            active_border   = "rgba(e8b43aee)",
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

-- Animations
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 0.5, 0.5 }, { 0.0, 1.1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "bounce" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "bounce", style = "popin 30%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "bounce", style = "slide" })

-- Layout
hl.config({
    master = {
        mfact = "0.2",
        new_status = "slave",
        new_on_top = true,
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
        default_monitor = monitors[1].output,
        hide_on_key_press = true,
    }
})
