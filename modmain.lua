PrefabFiles = {
	"dendro",
	"dendro_none",
    "dendro_bamboo",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/dendro.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/dendro.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/dendro.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/dendro.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/dendro_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/dendro_silho.xml" ),

    Asset( "IMAGE", "bigportraits/dendro.tex" ),
    Asset( "ATLAS", "bigportraits/dendro.xml" ),
	
	Asset( "IMAGE", "images/map_icons/dendro.tex" ),
	Asset( "ATLAS", "images/map_icons/dendro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_dendro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_dendro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_dendro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_dendro.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_dendro.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_dendro.xml" ),
	
	Asset( "IMAGE", "images/names_dendro.tex" ),
    Asset( "ATLAS", "images/names_dendro.xml" ),
	
	Asset( "IMAGE", "images/names_gold_dendro.tex" ),
    Asset( "ATLAS", "images/names_gold_dendro.xml" ),
}

AddMinimapAtlas("images/map_icons/dendro.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.dendro = "The Optimistic Monk"
STRINGS.CHARACTER_NAMES.dendro = "Dendro"
STRINGS.CHARACTER_DESCRIPTIONS.dendro = "*Animal friendly and monkey friend\n*He is one with the wildness\n*The hungrier he is, the more satisfied he becomes\n*He's vegetarian\n*He can't use armor\n*His karma affects him personally"

STRINGS.CHARACTER_QUOTES.dendro = "\"The glass is half full\""
STRINGS.CHARACTER_SURVIVABILITY.dendro = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.DENDRO = require "speech_dendro"

-- The character's name as appears in-game 
STRINGS.NAMES.DENDRO = "Dendro"
STRINGS.SKIN_NAMES.dendro_none = "Dendro"

STRINGS.NAMES.DENDRO_BAMBOO = "Dendro Bamboo"
STRINGS.RECIPE_DESC.DENDRO_BAMBOO = "Stick go bonk."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DENDRO_BAMBOO = "I'd hate to get whacked with this thing!"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("dendro", "MALE", skin_modes)


local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

AddRecipe2("dendro_bamboo", -- name
	{ -- ingredients
		Ingredient("rope", 1),
		Ingredient("twigs", 1),
	},
	TECH.SCIENCE_ONE, -- tech
	{ -- config
		product = "bamboo",
		builder_tag = "monk",
		numtogive = 1,
	}, 
	{ -- filters
		"WEAPONS",
	}
)