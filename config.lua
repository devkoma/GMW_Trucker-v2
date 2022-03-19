Config = {}

Config.Debug = true

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                   SETTINGS                             
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.MenuPosition = "left" -- "right" / "left"

Config.Name = "LS Logistics" -- Dein Menu Title

Config.needJob = true -- true = braucht den Job | false = braucht nicht den Job

Config.CarPlateName = "Cock" -- Lege dein Kennzeichen Fest

Config.CarPlateColor = 1 -- Plates: Blue/White - 0 Yellow/black - 1 Yellow/Blue - 2 Blue/White2 - 3 Blue/White3 - 4 Yankton - 5

Config.Themes = "blue-theme" -- "blue-theme"; "black-theme"; "green-theme"

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                Depot Coords                               
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.DepotPoint = {
    {Label = "LS Logistics", Coords = vector4(1014.18, -2523.53, 28.31, 90.01)}
}

Config.Health = "engine" -- "body"

Config.VehSpawnPoint = vector4(983.98, -2530.77, 28.32, 355.00)

Config.TrailerSpwnPoint = vector4(982.92, -2543.71, 28.3, 355.00)

Config.EndPoint = vector3(1022.34, -2493.32, 28.5)


-- ════════════════════════════════════════════════════════════════════════════════════ --
--                                Touren Coords                               
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.Routen = {
    {Label = "Klärwerk ~r~(Rancho)",                price = "~g~80$", Coords = vector3(476.01, -2151.01, 5.93),     Reward = 80},
    {Label = "Bauernhof ~r~(Sandy Shores)",         price = "~g~300$", Coords = vector3(-128.23, 1927.81, 196.95),  Reward = 300},
    {Label = "Cluckin Bell Fabrik ~r~(Paleto Bay)", price = "~g~600$", Coords = vector3(193.21, 6403.46, 31.35),    Reward = 600},
    {Label = "Sägewerk ~r~(Paleto Bay)",            price = "~g~600$", Coords = vector3(-598.67, 5343.73,  69.68),  Reward = 600},
    {Label = "Baustelle ~r~(Little Seoul)",         price = "~g~90$", Coords = vector3(-473.43, -1020.91,  23.59),  Reward = 90},
    {Label = "Werkstatt ~r~(Paleto Bay)",           price = "~g~600$", Coords = vector3(69.46, 6490.27, 31.25),     Reward = 600},
    {Label = "Golfplatz ~r~(Innenstadt)",           price = "~g~300$", Coords = vector3(-1383.09, 96.68,54.57),     Reward = 300},
    {Label = "Hafen ~r~(Terminal)",                 price = "~g~85$", Coords = vector3(1204.33, -2971.57, 5.9),     Reward = 85},
    {Label = "Hafen ~r~(La Puerta)",                price = "~g~100$", Coords = vector3(-854.08, -1256.81, 5.0),    Reward = 100},
    {Label = "Power-Station ~r~(Route 15)",         price = "~g~320$", Coords = vector3(2683.1, 1599.81, 24.51),    Reward = 320},
    {Label = "Tankstelle ~r~(Grove Street)",        price = "~g~90$", Coords = vector3(-25.85, -1758.78, 29.24),    Reward = 90},
    {Label = "Tankstelle ~r~(Mirror Park)",         price = "~g~95$", Coords = vector3(1170.9, -316.5, 69.18),      Reward = 95},
    {Label = "Tankstelle ~r~(Sandy Shores)",        price = "~g~450$", Coords = vector3(1978.82, 3783.74, 32.18),   Reward = 450},
    {Label = "Tankstelle ~r~(Paleto Bay)",          price = "~g~600$", Coords = vector3(200.99, 6617.44, 31.7),     Reward = 600},
}

Config.Export = {
    {Label = "Waffen Transport ~r~(Cayo Perico)",                price = "~g~25000$", Coords = vector3(5136.3047, -5145.4199, 2.1807),     Reward = 25000},
    {Label = "Waffen Transport ~r~(Nackten Camp)",                price = "~g~10000$", Coords = vector3(-1091.1788, 4911.7915, 214.8668),     Reward = 10000}
}

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                            LEGAL / TRUCKs / TRAILER                           
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.Trailers = {
    [1] = {spwn = "trailers"},
    [2] = {spwn = "trailers2"},
    [3] = {spwn = "trailers3"},
    [4] = {spwn = "trailers4"},
    [5] = {spwn = "tvtrailer"},
    [6] = {spwn = "docktrailer"},
}

Config.Trucks = {
    [1] = {spwn = "Phantom"},
    [2] = {spwn = "hauler"},
    [3] = {spwn = "Packer"},
}

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                            ILLEGAL / TRUCKs  / TRAILER                         
-- ════════════════════════════════════════════════════════════════════════════════════ --


Config.TrailersExport = {
    [1] = {spwn = "trailers"},
    [2] = {spwn = "trailers2"},
    [3] = {spwn = "trailers3"},
    [4] = {spwn = "trailers4"},
    [5] = {spwn = "tvtrailer"},
    [6] = {spwn = "docktrailer"},
    [7] = {spwn = "tanker"},
    [8] = {spwn = "tanker2"},
    [9] = {spwn = "armytanker"},
}

Config.TrucksExport = {
    [1] = {spwn = "Phantom"},
    [2] = {spwn = "hauler2"},
    [3] = {spwn = "Packer"},
}
