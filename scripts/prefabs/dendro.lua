



local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}


-- Your character's stats
TUNING.DENDRO_HEALTH = 200
TUNING.DENDRO_HUNGER = 175
TUNING.DENDRO_SANITY = 150


-- Custom funcions --

-- function to give a bonus when eating food, in this case, the hungrier the character is, the more hunger it will restore. If the character is with 0 hunger, it will restore 18 hunger.
local function foodBonus(inst, food)
	if inst.components.hunger then
		local oncurrent = inst.components.hunger:oncurrent()
		local onmax = inst.components.hunger:onmax()
		if oncurrent > 0 then
    		inst.components.hunger:DoDelta(onmax/(oncurrent/10))
		else
			inst.components.hunger:DoDelta(18)		
		end
  	end
end

-- Function to reduce sanity when killing non-player characters
local function onKill(inst, data)
	local victim = data.victim
	if victim and not victim:HasTag("player") and inst.components.sanity then
		inst.components.sanity:DoDelta(-TUNING.SANITY_TINY)
	end
end

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.DENDRO = {
	"dendro_bamboo"
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.DENDRO
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "dendro_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "dendro_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "dendro.tex" )

	-- Character specific (optional)
	inst:AddTag("monk")
    inst:AddTag("vegetarian")
    inst:RemoveTag("scarytoprey")
	inst:AddTag("nosteal")
    inst:AddTag("")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.DENDRO_HEALTH)
	inst.components.hunger:SetMax(TUNING.DENDRO_HUNGER)
	inst.components.sanity:SetMax(TUNING.DENDRO_SANITY)
	
	-- Damage multiplier
    inst.components.combat.damagemultiplier = 0.5

	-- Sanity drain at night
	inst.components.sanity.night_drain_mult = 0 
	
	-- Hunger rate
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

	-- Insulation time
	inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED
    inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_MED
	
	-- Food affinity
	inst.components.foodaffinity:AddPrefabAffinity("barnaclesushi", TUNING.AFFINITY_15_CALORIES_MED)

	-- Food bonus
	if inst.components.eater ~= nil then
        inst.components.eater:SetIgnoresSpoilage(true)
        inst.components.eater:SetOnEatFn(foodBonus)
    end

	-- Loses sanity when killing non-player characters
	inst:ListenForEvent("killed", onKill)

	

	

	inst:AddComponent("kramped")

	local kramped = inst.components.kramped

	print(kramped:GetDebugString() )
	
	end




	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end



return MakePlayerCharacter("dendro", prefabs, assets, common_postinit, master_postinit, prefabs)
