--=====================================================================--
--                          Code Utils
--=====================================================================--

-- notification
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

-- Left corner help message
function ShowHelp(text, bleep, time)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, time)
end

-- Play Animation 
function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end

-- Dialog
function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
	    result = GetOnscreenKeyboardResult()
	end
end

-- Text auf dem Bildschirm
function DisplayOnScreenText(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour(r, g, b, a )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline(outline)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/1.835, y - height/2 + -0.002)
end

-- Fahrzeug Spawnen
function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, x, y, z, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetEntityAsNoLongerNeeded(vehicle)
    SetVehicleNumberPlateText(vehicle, Config.CarPlateName)
    SetVehicleNumberPlateTextIndex(vehicle, Config.CarPlateColor)
    SetModelAsNoLongerNeeded(vehicleName)
end

-- Trailer Spawnen
function SpawnTrailer(car, x, y, z, h)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end
    local vehicle = CreateVehicle(car, x, y, z, h, true, false)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
end

-- Fahrzeug Löschen
function deleteCar(entity)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

-- Blackscreen triggern
function ScreenFade(WaitTime)
    DoScreenFadeOut(1000)
    Citizen.Wait(WaitTime)
    DoScreenFadeIn(1000)
end

-- function um Zahlen zu runden
function round(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

-- Checkt ob eine Index in der Tabelle ist
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function addMarker(x, y, z)
    DrawMarker(1, x, y, z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
end 

function RenderRect(x, y, w, h, r, g, b, a)
    local x, y, w, h = (tonumber(x) or 0) / 1920, (tonumber(y) or 0) / 1080, (tonumber(w) or 0) / 1920, (tonumber(h) or 0) / 1080
    DrawRect(x + w * 05, y + h * 0.5, w, h, tonumber(r) or 255, tonumber(g) or 255, tonumber(b) or 255, tonumber(a) or 255)
end

function drawProgressBar(x, y, width, height, colour, percent)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(9)
    local w = width * (percent/100)
    local x = (x - (width * (percent/100))/2)-width/2    
    DrawRect(x + w, y, w, height, colour[1], colour[2], colour[3], colour[4])
end

function DisablePlayerControls()
    DisableControlAction(0, 32, true) -- W
    DisableControlAction(0, 34, true) -- A
    DisableControlAction(0, 31, true) -- S
    DisableControlAction(0, 30, true) -- D
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 21, true) -- Run
    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 22, true) -- Jump
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 288,  true) -- Disable phone
    DisableControlAction(0, 289, true) -- Inventory
    DisableControlAction(0, 170, true) -- Animations
    DisableControlAction(0, 167, true) -- Job
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(2, 36, true) -- Disable going stealth
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
    DisableControlAction(0, 303, true) -- U
    DisableControlAction(0, 20, true) -- Z
    DisableControlAction(0, 137, true) -- CAPSLOCK
    DisableControlAction(0, 243, true) -- `/ ^
end 