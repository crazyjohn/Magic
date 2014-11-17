-- MessageTypeToHandlerRegistry;
-- 消息注册表;
-- @author crazyjohn;

local MessageTypeToHandlerRegistry = class("MessageTypeToHandlerRegistry")

function MessageTypeToHandlerRegistry:ctor()
	self.functions = {}
end

function MessageTypeToHandlerRegistry:register(messageType, executeFunction)
	-- body
	if self.functions[messageType] ~= nil then
		-- TODO: 提示重复注册
		printError("Already registed to type: " .. messageType)
		return
	end
	if executeFunction then
		--printInfo("Registed messageType: %d", messageType)
		self.functions[tostring(messageType)] = executeFunction
	end
end

function MessageTypeToHandlerRegistry:getExecuteHandler(messageType)
	return self.functions[tostring(messageType)]
end

return MessageTypeToHandlerRegistry