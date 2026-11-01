local addonName = ...
local manager = _G.RebuffedVersionChecks
if not manager then
    manager = {addons = {}}
    _G.RebuffedVersionChecks = manager
    local function parse(value)
        if type(value) ~= "string" then return end
        local a, b, c = value:match("^(%d+)%.(%d+)%.(%d+)$")
        if a and #value <= 24 then return tonumber(a), tonumber(b), tonumber(c) end
    end
    local function newer(a, b)
        local x, y, z = parse(a)
        local i, j, k = parse(b)
        return x and i and (x > i or x == i and (y > j or y == j and z > k)) or false
    end
    manager.newer = newer
    local function report(all)
        local german = GetLocale() == "deDE"
        for _, name in ipairs(manager.addons) do
            local current = GetAddOnMetadata(name, "Version") or "0.0.0"
            local status = _G.RebuffedUpdateStatus and _G.RebuffedUpdateStatus[name]
            local latest = status and status.latest
            local url = "https://github.com/Derfavo/" .. name .. "/releases/latest"
            if newer(latest, current) then
                local text = german and "%s: Update %s verfügbar (installiert: %s). Download: %s"
                    or "%s: Update %s available (installed: %s). Download: %s"
                DEFAULT_CHAT_FRAME:AddMessage("|cffffc040" .. string.format(text, name, latest, current, url) .. "|r")
            elseif all then
                local text = name .. ": " .. current
                if latest and parse(latest) then
                    text = text .. (german and " | zuletzt geprüft: " or " | last checked: ")
                        .. (status.checkedAt and date("%Y-%m-%d %H:%M", status.checkedAt) or "?")
                else
                    text = text .. (german and " | noch kein Online-Prüfergebnis" or " | no online check result yet")
                end
                DEFAULT_CHAT_FRAME:AddMessage(text .. " | " .. url)
            end
        end
    end
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:SetScript("OnEvent", function() report(false) end)
    SLASH_REBUFFEDUPDATES1 = "/rebuffedupdates"
    SlashCmdList.REBUFFEDUPDATES = function() report(true) end
end
for _, name in ipairs(manager.addons) do if name == addonName then return end end
manager.addons[#manager.addons + 1] = addonName
