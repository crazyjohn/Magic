-- GCTemplateMessage
-- @author crazyjohn;
-- @date: 2014-11-04

local GCTemplateMessage = class("GCTemplateMessage")

function GCTemplateMessage:register()
	-- 注册处理方法
	GlobalMessageRegistry:register(MessageType.GC_LOGIN_RESULT, handler(self, self.GC_LOGIN_RESULT))
	-- 注册处理器
	GlobalHandlers:register("LoginHandler", requireNewHandler("LoginHandler"))
end

function GCTemplateMessage:GC_LOGIN_RESULT(data)
	-- body
	-- 1. deserizalize all params from data
	-- 2. pass the params to handler
	-- eg:some mock code
	-- local resultCode = readInt(data)
	-- Handlers:getHandler("LoginHandler"):GC_LOGIN_RESULT(resultCode)
	local resultCode = data:readInt()
	GlobalHandlers:getHandler("LoginHandler"):GC_LOGIN_RESULT(resultCode)
end


return GCTemplateMessage