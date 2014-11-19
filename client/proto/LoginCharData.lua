-- LoginCharData (proto data object, do not modified!)
-- @author crazyjohn

-- create class
local LoginCharData = class("LoginCharData")

-- deserializable;
function LoginCharData:readSelf(data)
	-- 角色的guid
	self.humanGuid = data:readLong()
	-- 角色名称
	self.name = data:readStringUShort()
	-- 职业
	self.occupation = data:readInt()
	-- 角色等级
	self.level = data:readInt()
	-- 当前精力值
	self.energy = data:readLong()
	-- 角色主城等级
	self.homeLevel = data:readInt()
	-- 角色当前金币数量
	self.coins = data:readLong()
end

-- serializable;
function LoginCharData:writeSelf(data)
	-- 角色的guid
	data:writeLong(self.humanGuid)
	-- 角色名称
	data:writeStringUShort(self.name)
	-- 职业
	data:writeInt(self.occupation)
	-- 角色等级
	data:writeInt(self.level)
	-- 当前精力值
	data:writeLong(self.energy)
	-- 角色主城等级
	data:writeInt(self.homeLevel)
	-- 角色当前金币数量
	data:writeLong(self.coins)
end

return LoginCharData