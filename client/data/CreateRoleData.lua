-- 创建角色数据层;
-- @author crazyjohn
-- @date 2014-11-14 22:31:44
--

-- create logger
local logger = LoggerFactory:getLogger("CreateRoleData")
-- create class
local CreateRoleData = class("CreateRoleData")

-- ctor
function CreateRoleData:ctor()
    -- body of ctor
end

-- set data
function CreateRoleData:setData(data)
	logger:dump(data, "CreateRoleData")
	self.__data = data
end

-- 根据索引获取职业描述;
-- index = 1 --> occupationType = 1
-- index = 2 --> occupationType = 2
-- index = 3 --> occupationType = 4
local indexTable = {1, 2, 4}
function CreateRoleData:getDescByIndex(index)
	for k,v in pairs(self.__data) do
		if tostring(v["occupationType"]) == tostring(indexTable[index]) then
			self.__currentOccupation = indexTable[index]
			return v["feature"]
		end
	end
	return nil
end

function CreateRoleData:getCurrentOccupation()
	return self.__currentOccupation
end

return CreateRoleData
