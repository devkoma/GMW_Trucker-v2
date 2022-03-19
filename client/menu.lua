ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

--=====================================================================--
--                           RageUI Menu
--=====================================================================--

local rightPosition     = {x = 1450, y = 0}
local leftPosition      = {x = 0, y = 0}
local menuPosition      = {x = 0, y = 0}
local MenuPosition      = Config.MenuPosition

if MenuPosition then
    if MenuPosition == "left" then
        menuPosition = leftPosition
    elseif MenuPosition == "right" then
        menuPosition = rightPosition
    end
end


MenuName = Config.Name


RMenu.Add("GMW_Scripts:mainMenu", 'main', RageUI.CreateMenu(MenuName, "~b~ ", menuPosition["x"], menuPosition["y"], "themes", Config.Themes))
RMenu.Add("GMW_Scripts:subMenu", "subMenu", RageUI.CreateSubMenu(RMenu:Get("GMW_Scripts:mainMenu", 'main'), MenuName, "~g~Legaler Transport", menuPosition["x"], menuPosition["y"], "themes", Config.Themes))
RMenu.Add("GMW_Scripts:subMenuExport", "subMenuExport", RageUI.CreateSubMenu(RMenu:Get("GMW_Scripts:mainMenu", 'main'), MenuName, "~r~Illegaler Transport", menuPosition["x"], menuPosition["y"], "themes", Config.Themes))
RMenu.Add("GMW_Scripts:F6Menu", "F6Menu", RageUI.CreateMenu(MenuName, "~b~LS Logistics", menuPosition["x"], menuPosition["y"], "themes", Config.Themes))

local ped = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = GetPlayerPed(-1)
    end
end)

local MenuInfos = {
    InputKey = "~INPUT_CONTEXT~",
    InputInteger = 38,
    mainMenu = RMenu:Get("GMW_Scripts:mainMenu", 'main'),
    subMenu = RMenu:Get("GMW_Scripts:subMenu", "subMenu"),
    subMenuExport = RMenu:Get("GMW_Scripts:subMenuExport", "subMenuExport"),
    F6Menu = RMenu:Get("GMW_Scripts:F6Menu", "F6Menu")
}

JobStarted = false
DriveToCoords = false
JobInfo = nil 

local MenuTable = {}

function MenuInfos:RMenu()
    RageUI.IsVisible(self.mainMenu, function()
        RageUI.Button("Informationen", "Wähle eine der gegebenen Routen und beliefere den Kunden", {LeftBadge = RageUI.BadgeStyle.Star}, true, {
            onSelected = function() end
        })
        RageUI.Separator("-")
        RageUI.Button("~g~Legale Route auswählen", nil, {RightLabel = "→→→"}, true, {
            onSelected = function() end
        }, self.subMenu)
        RageUI.Button("~r~Illegale Route auswählen", nil, { RightLabel = "→→→" }, true, {
            onSelected = function () end
        }, self.subMenuExport)
    end)
    RageUI.IsVisible(self.subMenu, function()
        for k, v in pairs(Config.Routen) do 
            if has_value(MenuTable, k) then 
                RageUI.Button(v.Label, "Bitte warte ein wenig bevor du diese Route erneut auswählen kannst", {}, false, {onSelected = function() end})
            else 
                if JobStarted then 
                    RageUI.Button(v.Label, "~r~Da hast bereits eine Route ausgewählt! Beende sie um eine neue starten zu können!", {}, false, {onSelected = function() end})
                else
                    RageUI.Button(v.Label, "Zielort: ~b~"..v.Label, {RightLabel = v.price}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            table.insert(MenuTable, k)
                            JobStarted = true; DriveToCoords = true; JobInfo = v; 
                            TriggerEvent("GMW_Scripts:TJ_StartJob", v)
                        end 
                    })
                end 
            end 
        end     
    end)
    --[[ ROUTEN_EXPORT ]]--
    RageUI.IsVisible(self.subMenuExport, function()
        for k, v in pairs(Config.Export) do 
            if has_value(MenuTable, k) then 
                RageUI.Button(v.Label, "Bitte warte ein wenig bevor du diese Route erneut auswählen kannst", {}, false, {onSelected = function() end})
            else 
                if JobStarted then 
                    RageUI.Button(v.Label, "~r~Da hast bereits eine Route ausgewählt! Beende sie um eine neue starten zu können!", {}, false, {onSelected = function() end})
                else
                    RageUI.Button(v.Label, "Ware: ~b~"..v.Label, {RightLabel = v.price}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            table.insert(MenuTable, k)
                            JobStarted = true; DriveToCoords = true; JobInfo = v; 
                            TriggerEvent("GMW_Scripts:TJ_StartJobExport", v)
                        end 
                    })
                end 
            end 
        end     
    end)
end

function MenuInfos:F6menu()
    RageUI.IsVisible(self.F6Menu, function()
        RageUI.Button("Wegpunkt zum Depot setzen", nil, {}, true, {
            onSelected = function()
                for k, v in pairs(Config.DepotPoint) do 
                    local x, y = table.unpack(v.Coords)
                    SetNewWaypoint(x, y)
                    notify("Wegpunkt wurde zum ~g~Depot~w~ gesetzt")
                end
            end
        })
        if JobStarted then 
            RageUI.Button("~r~Auftrag beenden!", "Solltest du diese Aktion tätigen, musst du für die Kosten der Ware zahlen!", {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1200)
                    local veh = GetVehiclePedIsIn(ped)
                    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
                        local pos = GetEntityCoords(ped) 
                        if (GetPedInVehicleSeat(veh, -1) == ped) then 
                            SetEntityAsMissionEntity(veh, true, true)
                            deleteCar(veh)
                            local x, y, z = GetEntityCoords(ped)
                            SetEntityCoords(ped, x, y, z)
                            TriggerEvent("GMW_Scripts:AbortJob", JobInfo)
                        end  
                    end
                    Citizen.Wait(2000)
                    DoScreenFadeIn(1000)
                    Citizen.Wait(1200)
                end
            })
        end 
    end)
end 

function MenuInfos:OpenMenu(x, y, z, MarkerDist, MenuDist)
    Citizen.CreateThread(function()    
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        local dist = Vdist(coords, x, y, z)
        if dist <= MarkerDist then 
            addMarker(x, y, z)
            if dist <= MenuDist then
                ShowHelp("Drücke "..self.InputKey.." um das Menü zu verwalten", true) 
                if IsControlJustPressed(0, self.InputInteger) then 
                    RageUI.Visible(self.mainMenu, not RageUI.Visible(self.mainMenu))
                end 
            end 
        end
    end)
    Citizen.CreateThread(function()
        if IsControlJustPressed(0, 167) and GetLastInputMethod(0) then
            RageUI.Visible(self.F6Menu, not RageUI.Visible(self.F6Menu))
        end 
    end)
end 

function MenuInfos:NoJob(x, y, z, msg)
    local coords = GetEntityCoords(ped)
    local dist = Vdist(coords, x, y, z)
    if dist <= 5 then
        ShowHelp(msg, true)
    end 
end 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        for k, v in pairs(Config.DepotPoint) do 
            local x, y, z = table.unpack(v.Coords)
            if Config.needJob then
                if (ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "trucker") then
                    MenuInfos:OpenMenu(x, y, z, 8, 2)
                else
                    MenuInfos:NoJob(x, y, z, "~r~Du musst Arbeitnehmer bei LS Logistik sein, um mit dem Auftraggeber interagieren zu können!")
                end  
            else 
                MenuInfos:OpenMenu(x, y, z, 8, 2)
            end
        end   
        Citizen.CreateThread(function()
            Citizen.Wait(0)
            MenuInfos:RMenu()
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(0)
            MenuInfos:F6menu()
        end)
    end 
end)
