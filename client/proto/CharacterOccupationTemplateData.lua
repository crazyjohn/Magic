-- CharacterOccupationTemplateData (proto data object, do not modified!)
-- @author crazyjohn

-- create class
local CharacterOccupationTemplateData = class("CharacterOccupationTemplateData")

-- deserializable;
function CharacterOccupationTemplateData:readSelf(data)
	-- 职业类型(1 = 战士; 2 = 游侠;    3    = 法师)
	self.occupationType = data:readInt()
	-- 职业名称
	self.nameIcon = data:readInt()
	-- 职业特色
	self.feature = data:readStringUShort()
	-- 职业系别
	self.classes = data:readStringUShort()
	-- 天赋1图标id
	self.giftIcon1 = data:readInt()
	-- 天赋1名称
	self.giftName1 = data:readStringUShort()
	-- 天赋1详细文字说明
	self.giftDesc1 = data:readStringUShort()
	-- 天赋2图标id
	self.giftIcon2 = data:readInt()
	-- 天赋2名称
	self.giftName2 = data:readStringUShort()
	-- 天赋2详细文字说明
	self.giftDesc2 = data:readStringUShort()
	-- 天赋3图标id
	self.giftIcon3 = data:readInt()
	-- 天赋3名称
	self.giftName3 = data:readStringUShort()
	-- 天赋3详细文字说明
	self.giftDesc3 = data:readStringUShort()
end

-- serializable;
function CharacterOccupationTemplateData:writeSelf(data)
	-- 职业类型(1 = 战士; 2 = 游侠;    3    = 法师)
	data:writeInt(self.occupationType)
	-- 职业名称
	data:writeInt(self.nameIcon)
	-- 职业特色
	data:writeStringUShort(self.feature)
	-- 职业系别
	data:writeStringUShort(self.classes)
	-- 天赋1图标id
	data:writeInt(self.giftIcon1)
	-- 天赋1名称
	data:writeStringUShort(self.giftName1)
	-- 天赋1详细文字说明
	data:writeStringUShort(self.giftDesc1)
	-- 天赋2图标id
	data:writeInt(self.giftIcon2)
	-- 天赋2名称
	data:writeStringUShort(self.giftName2)
	-- 天赋2详细文字说明
	data:writeStringUShort(self.giftDesc2)
	-- 天赋3图标id
	data:writeInt(self.giftIcon3)
	-- 天赋3名称
	data:writeStringUShort(self.giftName3)
	-- 天赋3详细文字说明
	data:writeStringUShort(self.giftDesc3)
end

return CharacterOccupationTemplateData