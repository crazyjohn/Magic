-- BattlePopInfoData (proto data object, do not modified!)
-- @author crazyjohn

-- create class
local BattlePopInfoData = class("BattlePopInfoData")

-- deserializable;
function BattlePopInfoData:readSelf(data)
	-- 角色ID
	self.roleId = data:readLong()
	-- pop内容
	self.words = {}
end

-- serializable;
function BattlePopInfoData:writeSelf(data)
	-- 角色ID
	data:writeLong(self.roleId)
	-- pop内容
	BattlePopInfoData.words = {}
end

return BattlePopInfoData