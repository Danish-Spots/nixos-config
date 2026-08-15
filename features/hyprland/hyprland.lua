local mainMod = "SUPER"

hl.on("hyprland.start", function()
    hl.exec_cmd("quickshell")
end)

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())