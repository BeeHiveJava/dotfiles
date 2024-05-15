local wezterm = require "wezterm"
local module = {}

local function is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

local function wsl()
    return {
        label = "Debian",
        args = { "debian" }
    }
end

local function powershell()
    return {
        label = "PowerShell",
        args = { "pwsh.exe", "-NoLogo" }
    }
end

function module.apply_to_config(config)
    local launch_menu = {}

    if is_windows then
        config.default_prog = { "debian" }
        table.insert(launch_menu, wsl())
        table.insert(launch_menu, powershell())
    end

    config.launch_menu = launch_menu
end

return module
