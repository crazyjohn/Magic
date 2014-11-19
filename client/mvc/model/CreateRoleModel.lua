-- 创建角色领域模型;
-- @author crazyjohn
-- @date 2014-11-14 22:31:44
--

-- create logger
local logger = LoggerFactory:getLogger("CreateRoleModel")
-- create class
local CreateRoleModel = class("CreateRoleModel")

-- ctor
function CreateRoleModel:ctor()
    -- body of ctor
end

-- set data
function CreateRoleModel:setData(data)
	logger:dump(data, "CreateRoleModel")
	self.__data = data
end

-- 根据索引获取职业描述;
-- index = 1 --> occupationType = 1
-- index = 2 --> occupationType = 2
-- index = 3 --> occupationType = 4
local indexTable = {1, 2, 4}
function CreateRoleModel:getDescByIndex(index)
	for k,v in pairs(self.__data) do
		if tostring(v["occupationType"]) == tostring(indexTable[index]) then
			self.__currentOccupation = indexTable[index]
			return v["feature"]
		end
	end
	return nil
end

function CreateRoleModel:getCurrentOccupation()
	return self.__currentOccupation
end

return CreateRoleModel
