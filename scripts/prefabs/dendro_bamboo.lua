local assets={    
    Asset("ANIM", "anim/dendro_bamboo.zip"),    
    Asset("ANIM", "anim/swap_dendro_bamboo.zip"),    
    Asset("ATLAS", "images/inventoryimages/dendro_bamboo.xml"),    
    Asset("IMAGE", "images/inventoryimages/dendro_bamboo.tex"),
}

prefabs = {}

local function fn()    
    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_dendro_bamboo", "swap_dendro_bamboo")        
        owner.AnimState:Show("ARM_carry")        
        owner.AnimState:Hide("ARM_normal")    
    end    
    
    local function OnUnequip(inst, owner)        
        owner.AnimState:Hide("ARM_carry")        
        owner.AnimState:Show("ARM_normal")    
    end    
    
    local inst = CreateEntity()    
    local trans = inst.entity:AddTransform()    
    local anim = inst.entity:AddAnimState()    
    local sound = inst.entity:AddSoundEmitter()    
    MakeInventoryPhysics(inst)        
    anim:SetBank("dendro_bamboo")    
    anim:SetBuild("dendro_bamboo")    
    anim:PlayAnimation("idle")    
    inst:AddComponent("inspectable")        
    inst:AddComponent("inventoryitem")    
    inst.components.inventoryitem.imagename = "dendro_bamboo"    
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dendro_bamboo.xml"        
    inst:AddComponent("equippable")    
    inst.components.equippable:SetOnEquip( OnEquip )    
    inst.components.equippable:SetOnUnequip( OnUnequip )    
    return inst
end

return Prefab("common/inventory/dendro_bamboo", fn, assets, prefabs)











