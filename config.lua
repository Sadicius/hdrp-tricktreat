Config = {}

Config.FadeIn           = true
Config.DistanceSpawn    = 20.0

Config.UseTarget            = false -- u can choose prompt too xP 

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
}

Config.weaponModels = {
    'weapon_melee_lantern_halloween',
    'weapon_melee_knife',
    'weapon_melee_hatchet',
    'weapon_melee_machete',
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
    url = '',
    wmessage = 'Hallowen Fight Started by\n**First Name:** %s\n**Last Name:** %s\n**Steam Hex:** (%s)'
}
