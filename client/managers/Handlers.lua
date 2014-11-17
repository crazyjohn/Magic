-- Handlers;
-- 消息处理器静态工厂;
-- @author crazyjohn;

local Handlers = class("Handlers")

function Handlers:ctor( ... )
	self.__handlers = {}
end

function Handlers:getHandler(handleName)
	return self.__handlers[handleName]
end

function Handlers:register(handlerName, handler)
	self.__handlers[handlerName] = handler
end
return Handlers