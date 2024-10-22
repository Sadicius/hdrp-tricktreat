Config = {}

Config.FadeIn           = true
Config.DistanceSpawn    = 20.0

Config.Trollprevent         = 30.0 -- dont ever select treat

Config.RadiusEvent          = 30.0
Config.weaponfithChange     = false -- true or false, in false use lantern
Config.weaponhalloween      = 99 -- % give weapons

-- Active addons
Config.outfithChange        = true
Config.clownsuithalloween   = true -- true or false -- link https://forum.cfx.re/t/free-clown-suit-halloween-special/5273104
Config.clownsuit            = 50.0 -- % appearance Clow Terror

-- Reward
Config.AmountMin = 1
Config.AmountMax = 4

Config.Items = {
    'card_tarot_b1',
    'matches',
    'cigarette10',
    'ammo_arrow',
    'horsexp10',
    'bottle',
    'wood',
    'ind_na1',
    'ind_headband4',
    'ind_cradle1',
    'fob_racing_basic',
    'card_tarot_pack',
    'card_packge_cards',
}

-- New AngryPeds configuration
Config.AngryClows = {
    models = {
		'a_f_m_nbxwhore_01', -- Saint Denis Prostitute
        'a_m_m_blwlaborer_01',
        -- 're_deadjohn_males_01',
        -- 'mp_u_m_m_dyingpoacher_04',
        -- 'mp_de_u_m_m_centralunionrr_01',
        -- 'mp_g_m_m_armyoffear_01',
        -- 're_lostfriend_males_01',
        -- 're_rallydispute_males_01',
        -- 'shack_ontherun_males_0',
        -- 'u_m_m_chelonianjumper_01',
        -- 'u_m_m_chelonianjumper_04',
        -- 'cs_daveycallender',
        -- 'cs_vampire',
        -- 're_injuredrider_males_01',
    },
    -- settings
    number      = math.random(1, 5),  -- Number of peds to spawn
    spawnRadius = 20.0,  -- Spawn radius around the fight location
    despawnTime = 60000,  -- Time in ms after which peds will despawn (60 seconds)
    RestrictionDuration  = 120000, -- 60 Sec fight attaker
    SeeingRange          = 20.0,
    HearingRange         = 65.0,
    Walks = {
        {"default", "very_drunk"},
        {"murfree", "very_drunk"},
        {"default", "dehydrated_unarmed"},
    },
    -- blip
    ShowtrickBlips      = true,
    trickBlipSprite     = -839369609
}

-- locations
Config.Doors = {
    {coords =  vector3(-285.3168, 869.17932, 121.24163), z = 7.7, looted = false},
    {coords =  vector3(-260.10, 844.22, 123.59),         z = 7.7, looted = false},
    {coords =  vector3(-263.46, 761.92, 118.15),         z = 7.7, looted = false},
    {coords =  vector3(-281.03, 912.86, 128.00),         z = 7.7, looted = false},
    {coords =  vector3(-255.03, 741.63, 118.16),         z = 7.7, looted = false},
    {coords =  vector3(-229.54, 750.26, 117.75),         z = 7.7, looted = false},
    {coords =  vector3(-404.60, 662.49, 115.56),         z = 7.7, looted = false},
    {coords =  vector3(-444.16, 500.54, 98.95),          z = 7.7, looted = false},
    -- houses coord door
    {coords = vector3(215.800, 988.065, 189.901), z = 7.7, looted = false },
    {coords = vector3(222.826, 990.534, 189.901), z = 7.7, looted = false },
    {coords = vector3(-615.940, -27.086, 84.997), z = 7.7, looted = false },
    {coords = vector3(-608.738, -26.613, 84.998), z = 7.7, looted = false },
    {coords = vector3(1888.170, 297.959, 76.076), z = 7.7, looted = false },
    {coords = vector3(1891.083, 302.622, 76.092), z = 7.7, looted = false },
    {coords = vector3(1781.106, -89.116, 55.816), z = 7.7, looted = false },
    {coords = vector3(1781.362, -82.688, 55.799), z = 7.7, looted = false },
    {coords = vector3(1792.064, -83.224, 55.799), z = 7.7, looted = false },
    {coords = vector3(1264.195, -404.071, 96.595), z = 7.7, looted = false },
    {coords = vector3(1266.838, -412.629, 96.595), z = 7.7, looted = false },
    {coords = vector3(1627.250, -366.256, 74.910), z = 7.7, looted = false },
    {coords = vector3(-2368.842, -2390.406, 61.520), z = 7.7, looted = false },
    {coords = vector3(1114.063, 493.746, 96.291), z = 7.7, looted = false },
    {coords = vector3(1116.399, 485.992, 96.306), z = 7.7, looted = false },
    {coords = vector3(-64.243, -393.561, 71.249), z = 7.7, looted = false },
    {coords = vector3(338.253, -669.948, 41.821), z = 7.7, looted = false },
    {coords = vector3(347.247, -666.053, 41.823), z = 7.7, looted = false },
    {coords = vector3(1111.466, -1297.578, 65.418), z = 7.7, looted = false },
    {coords = vector3(1114.607, -1305.075, 65.418), z = 7.7, looted = false },
    {coords = vector3(1365.420, -872.880, 69.162), z = 7.7, looted = false },
    {coords = vector3(1376.024, -873.242, 69.115), z = 7.7, looted = false },
    {coords = vector3(2068.360, -847.321, 42.351), z = 7.7, looted = false },
    {coords = vector3(2069.723, -847.315, 42.351), z = 7.7, looted = false },
    {coords = vector3(2064.389, -847.321, 42.351), z = 7.7, looted = false },
    {coords = vector3(2065.751, -847.315, 42.351), z = 7.7, looted = false },
    {coords = vector3(2069.722, -855.879, 42.351), z = 7.7, looted = false },
    {coords = vector3(2068.359, -855.886, 42.351), z = 7.7, looted = false },
    {coords = vector3(2253.847, -797.305, 43.133), z = 7.7, looted = false },
    {coords = vector3(2257.268, -792.704, 43.167), z = 7.7, looted = false },
    {coords = vector3(2257.942, -786.598, 43.185), z = 7.7, looted = false },
    {coords = vector3(2254.546, -781.735, 43.166), z = 7.7, looted = false },
    {coords = vector3(2252.363, -781.660, 43.166), z = 7.7, looted = false },
    {coords = vector3(2370.930, -857.486, 42.043), z = 7.7, looted = false },
    {coords = vector3(2370.871, -864.438, 42.040), z = 7.7, looted = false },
    {coords = vector3(1709.399, -1003.762, 42.481), z = 7.7, looted = false },
    {coords = vector3(2628.221, 1694.329, 114.666), z = 7.7, looted = false },
    {coords = vector3(2993.424, 2188.438, 165.736), z = 7.7, looted = false },
    {coords = vector3(2989.108, 2193.741, 165.740), z = 7.7, looted = false },
    {coords = vector3(2473.853, 1996.406, 167.226), z = 7.7, looted = false },
    {coords = vector3(2472.618, 2001.778, 167.226), z = 7.7, looted = false },
    {coords = vector3(-422.664, 1733.570, 215.590), z = 7.7, looted = false },
    {coords = vector3(900.344, 265.218, 115.048), z = 7.7, looted = false },
    {coords = vector3(-1347.948, 2435.204, 307.496), z = 7.7, looted = false },
    {coords = vector3(-1348.300, 2447.085, 307.481), z = 7.7, looted = false },
    {coords = vector3(-556.417, 2698.864, 319.380), z = 7.7, looted = false },
    {coords = vector3(-557.964, 2708.988, 319.432), z = 7.7, looted = false },
    {coords = vector3(-1019.111, 1688.299, 243.280), z = 7.7, looted = false },
    {coords = vector3(-1815.149, 654.964, 130.883), z = 7.7, looted = false },
    {coords = vector3(-2182.511, 716.464, 121.629), z = 7.7, looted = false },
    {coords = vector3(-2575.826, -1379.358, 148.272), z = 7.7, looted = false },
    {coords = vector3(-2578.786, -1385.246, 148.262), z = 7.7, looted = false },
    {coords = vector3(-2374.364, -1592.602, 153.300), z = 7.7, looted = false },
    {coords = vector3(-1410.572, -2674.223, 41.185), z = 7.7, looted = false },
    {coords = vector3(-3958.390, -2129.394, -5.235), z = 7.7, looted = false },
    {coords = vector3(-4366.012, -2416.306, 19.423), z = 7.7, looted = false },
    {coords = vector3(-5552.146, -2401.521, -9.714), z = 7.7, looted = false },
    {coords = vector3(-5555.267, -2397.352, -9.715), z = 7.7, looted = false },
    {coords = vector3(-3552.384, -3012.100, 10.820), z = 7.7, looted = false },
    {coords = vector3(-3555.440, -3007.938, 10.820), z = 7.7, looted = false },
    {coords = vector3(-1959.185, 2160.204, 326.554), z = 7.7, looted = false },
    {coords = vector3(-1961.024, 2167.063, 326.554), z = 7.7, looted = false },
    {coords = vector3(-2582.004, 3634.328, 144.016), z = 7.7, looted = false },
    {coords = vector3(-2537.209, 3645.796, 144.018), z = 7.7, looted = false },
    {coords = vector3(-3102.932, 3096.826, 39.426), z = 7.7, looted = false },
    {coords = vector3(-3110.024, 3097.133, 39.426), z = 7.7, looted = false },
    {coords = vector3(1832.958, 3894.301, 33.351), z = 7.7, looted = false },
    {coords = vector3(1835.444, 3898.872, 33.330), z = 7.7, looted = false },
    {coords = vector3(1497.212, 3603.066, 35.022), z = 7.7, looted = false },
    {coords = vector3(1500.682, 3612.421, 34.938), z = 7.7, looted = false },
    {coords = vector3(-169.424, 304.498, 111.073), z = 7.7, looted = false },
    {coords = vector3(228.176, -1177.812, 53.342), z = 7.7, looted = false }

}

-- models trick or treat
Config.trick = {'p_pumpkin_01x'}
Config.treat = {'p_cs_lootsack01x'}

-- ped trick or treat
Config.Peds = {
    'mp_predator',
    'cs_odprostitute',
    're_voice_females_01',
    'a_m_m_blwlaborer_01',
    'cs_mud2bigguy',
    'cs_mp_teddybrown',
    'cs_vampire',
	'A_M_M_SkpPrisoner_01',
	'CS_CAVEHERMIT',
	'A_M_M_EmRFarmHand_01',
	'A_M_M_BLWObeseMen_01',
	'A_M_M_BlWLaborer_01',
	'A_M_M_BlWUpperClass_01',
	'A_M_M_DOMINOESPLAYERS_01',
	'A_M_M_ASBTOWNFOLK_01_LABORER',
	'A_M_M_SDLaborers_02',
	'A_M_M_AsbMiner_01',
}

Config.weaponModels = {
    'weapon_melee_lantern_halloween',
    'weapon_melee_knife',
    'weapon_melee_hatchet',
    'weapon_melee_machete',
    -- 'weapon_melee_machete_horror',
    -- 'weapon_melee_machete_collector',
    'weapon_melee_torch',
}

-- notifications
Config.FightNotification = {
    title = "Notification",
    message = "Saloon Fight Begins!",
}

-- mng random
Config.msg = {
    'Monsters and ghosts are real. They live inside us. And sometimes, they win!',
    'Shadows murmur, the mist answers; darkness purrs like midnight sighs',
    'The luckiest die first',
    'Have you ever felt those sharp things on the back of your neck? It\'s them...',
    'Afraid of death? One should fear life, not death',
    'Take advantage of this day to externalize the dark side that you keep inside.',
    'Let terror become a gift',
    'It\'s Halloween... Everyone is entitled to a good scare!',
    'Between ghosts, pumpkins and spells, get ready for a night of lots of screams',
    'Be afraid. Be very afraid',
    'May the ghost be with you',
    'A candy a day keeps the monsters away',
    'Whatever you do … don’t fall asleep',
    'I’m not a vampire, I just sparkle naturally',
    'Keep calm and scare on',
    'Don’t look under the bed',
}

-- webhook
Config.DiscordWebhook = {
    url = 'https://discord.com/api/webhooks/1257539138043777087/CWIUMZPS8BcxacXco4TTDxiCeqW6j7vcenWy5vUOMe2iV9aOHjRStnUEKNa6dWgBhrKi',
    wmessage = 'Hallowen Fight Started by\n**First Name:** %s\n**Last Name:** %s\n**Steam Hex:** (%s)'
}