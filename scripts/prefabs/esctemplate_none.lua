local assets =
{
	Asset( "ANIM", "anim/dendro.zip" ),
	Asset( "ANIM", "anim/ghost_dendro_build.zip" ),
}

local skins =
{
	normal_skin = "dendro",
	ghost_skin = "ghost_dendro_build",
}

return CreatePrefabSkin("dendro_none",
{
	base_prefab = "dendro",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"DENDRO", "CHARACTER", "BASE"},
	build_name_override = "dendro",
	rarity = "Character",
})