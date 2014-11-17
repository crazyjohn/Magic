-- CG消息模板类;
-- @author crazyjohn;
-- @date: 2014-11-04

local CGTemplateMessage = class("CGTemplateMessage")

-- 字节序列;
local bodyArray = requireAndNew("framework.cc.utils.ByteArray")

-- login(rpc method for client to use);
-- @param userName;
-- @param password;
function CGTemplateMessage:CG_QUICK_LOGIN(userName, password)
	-- body
	-- 1. write to bodyArray
	bodyArray:writeStringUShort(userName)
	bodyArray:writeStringUShort(password)
	--bodyArray:setPos(1)
	-- 2. use socket to send
	GameSocket:sendPacket(MessageType.CG_QUICK_LOGIN, bodyArray)
end

-- exit(rpc method for client to use);
-- @param guid;
function CGTemplateMessage:CG_Exit(guid)
	-- body
end


return CGTemplateMessage