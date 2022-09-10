RegisterServerEvent("screenshot")
AddEventHandler(
    "screenshot",
    function(target, image)
        local steamid, license, xbl, playerip, discord, liveid = getidentifiers(target)
        if notAdmin(steamid, license) then return end
        local log = {
            {
                ["title"] = "> Player Screenshot",
                ["color"] = "14883322",
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S"),
                ["fields"] = {
                    {
                        ["name"] = "> ID:"..target,
                        ["value"] = "> Name:" .. GetPlayerName(target) .. "\n> Discord:" .. discord .. "\n> ||" .. steamid .. "||\n> ip:||"..playerip.."||\n > ||"..license.."||",
                        ["inline"] = true
                    }
                },
                ["image"] = {
                    ["url"] = image.attachments[1].proxy_url
                },
                ["footer"] = {
                    ["text"] = "Bot"
                }
            }
        }
        PerformHttpRequest(
            Config.Settings["webhook"],
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {
                    username = "Eyes Bot",
                    embeds = log,
                    avatar_url = "https://media.discordapp.net/attachments/627114895183446016/1017646816625442906/eyes.png?width=715&height=671"
                }
            ),
            {["Content-Type"] = "application/json"}
        )
    end,
    "GET",
    ""
)

function notAdmin(steam, license)
    for k,v in pairs(Config.BypassList) do
        if v == steam or v == license then
        return false
    end
end
return true
end


RegisterServerEvent("weapon")
AddEventHandler(
    "weapon",
    function(target, image, weapon, clip, ammo, health, armor)
        local clip, ammo = 0,0
        local steamid, license, xbl, playerip, discord, liveid = getidentifiers(target)
        if not notAdmin(steamid, license) then return end
        local log = {
            {
                ["author"] = {
                    ["name"] = "Banned gun alert!",
                    ["url"] = "https://discord.gg/EkwWvFS",
                    ["icon_url"] = "https://media.discordapp.net/attachments/627114895183446016/1017646816625442906/eyes.png?width=715&height=671"
                },
                ["thumbnail"] = {
                    ["url"] = image.attachments[1].proxy_url
                },
                ["color"] = 1752220,
                ["fields"] = {
                    {
                        ["name"] = "\nID:"..target.."\nDetected:",
                        ["value"] = "\n> " ..
                            weapon ..
                                "\n> ammo:" .. clip .. "/" .. ammo .. "\n> health:%" .. health .. "\n> armor:%" .. armor,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Player Information:",
                        ["value"] = "> Name:" ..
                            GetPlayerName(target) ..
                                "\n> Discord:" .. discord .. "\n> ||" .. steamid .. "||\n> ip:||" .. playerip .. "||",
                        ["inline"] = false
                    }
                },
                ["color"] = 16314897,
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
        PerformHttpRequest(
            Config.Settings["webhook"],
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {
                    username = "Eyes Bot",
                    embeds = log,
                    avatar_url = "https://media.discordapp.net/attachments/627114895183446016/1017646816625442906/eyes.png?width=715&height=671"
                }
            ),
            {["Content-Type"] = "application/json"}
        )
    end,
    "GET",
    ""
)

getidentifiers = function(player)
    local steamid = "Not Linked"
    local license = "Not Linked"
    local discord = "Not Linked"
    local xbl = "Not Linked"
    local liveid = "Not Linked"
    local ip = "Not Linked"

    for k, v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    return steamid, license, xbl, ip, discord, liveid
end
