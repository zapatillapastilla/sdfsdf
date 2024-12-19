models.model:setPrimaryRenderType("TRANSLUCENT_CULL")
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
vanilla_model.PLAYER:setVisible(false)
--models.model.root.Upbody.Head:setScale(1.5,1.5,1.5)


animations.model.fly:play()
animations.model.wingjump:setSpeed(2)
models.model.root2:setOpacity(50)
animations.model.shadeidle:play()
animations.model.shadeidle:setSpeed(.2)

function events.tick()
local sprinting = player:isSprinting()
local crouching = player:getPose() == "CROUCHING"
local runsword = player:getHeldItem(false)
local sneak = player:isCrouching()
local flying = host:isFlying()
local jump = host:isJumping()
local elytrafly = player:isGliding()
--local walking = player:getVelocity().xz:length() > .01


animations.model.run:setPlaying(sprinting and not crouching)
animations.model.sneaking:setPlaying(crouching)
animations.model.boostspin:play()
animations.model.boostspin:setSpeed(3)
models.model.boost:setOpacity(150)

	if flying then 
	models.model.boost:setVisible(false)
	models.model.root.Upbody.body.wings:setVisible(true)
	animations.model.runsword:stop()
	animations.model.boostspin:stop()
	--animations.model.jump:play()
	--animations.model.wingjump:play()
	 
	elseif elytrafly then 
	models.model.boost:setVisible(true)
	animations.model.sneaking:stop()
	animations.model.sneakarm:stop()
	
	elseif runsword and runsword.id:find("sword") and sprinting then
	animations.model.runsword:play()
	models.model.boost:setVisible(false)
	
	elseif crouching and walking then
	models.model.root.Upbody.Head:setPos(0,3,0)
	animations.model.sneaking:stop()
	animations.model.sneakarm:stop()
	 
	elseif walking then
	animations.model.walking:play()
	--print(1)
	
	elseif crouching then
	models.model.root.Upbody.Head:setPos(0,2.9,0)
	animations.model.sneaking:play()
	animations.model.sneakarm:play()
	--print(1)
	

	
	else
	animations.model.boostspin:stop()
	models.model.boost:setVisible(false)
	animations.model.sneakarm:stop()
--	animations.model.jump:stop()
	animations.model.runsword:stop()
	animations.model.wingjump:stop()
	animations.model.sneaking:stop()
--	models.model.root.Upbody.body.wings:setVisible(false)
	models.model.root.Upbody.Head:setPos(0,0,0)
end

	
    local hasElytraEquipped = player:getItem(5).id == "minecraft:elytra"
   models.model.root.Upbody.body.wings:setVisible(not hasElytraEquipped)
	if hasElytraEquipped and flying then 
	--print(1)
	models.model.root.Upbody.body.wings:setVisible(true)
	models.model.root2.Upbody2.body2.wings2:setVisible(true)
	else
	models.model.root.Upbody.body.wings:setVisible(false)
	models.model.root2.Upbody2.body2.wings2:setVisible(false)
	end
end


function events.tick(change)
local heldItem = player:getHeldItem(false)
local heldItem2 = player:getHeldItem(true)

if heldItem and heldItem.id:find("sword") then
	models.model.nail:setVisible(false)

elseif heldItem2 and heldItem2.id:find("sword") then
	models.model.nail:setVisible(true)
	vanilla_model.LEFT_ITEM:setVisible(false)
	
else
	models.model.nail:setVisible(true)
	vanilla_model.LEFT_ITEM:setVisible(true)
	models.model.ItemNail:setVisible(true)
end
end

function events.item_render(item)
    if  item.id:find("sword") then
        return models.model.ItemNail 
	end
end



local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)


function pings.shade(state)
end

local shade = mainPage:newAction()
    :title("Disable Shade")
    :toggleTitle("Enable Shade")
    :item("red_wool")
    :toggleItem("green_wool")
    :setOnToggle(pings.shade) 
	
	
	
function pings.shade(bool)
    models.model.root:setVisible(bool)
	--models.model:removeParticles(bool)
	
	models.model.root2:setVisible(bool == false)
end 

function events.tick()
--	particles:removeParticles(state)

	for i=1,20 do
	--	particles:newParticle("smoke", player:getPos(), vec(0,.01, 0))
	end
end