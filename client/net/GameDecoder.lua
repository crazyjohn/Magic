-- 消息解码器;
-- @author crazyjohn
-- @date 2014-11-10 14:58:59
--

-- create logger
local logger = LoggerFactory:getLogger("GameDecoder")
-- create class
local GameDecoder = class("GameDecoder")
-- readBuffer
local readBuffer = requireNewByteArray()

-- ctor
function GameDecoder:ctor()
    -- decoded msgs
    self.__msgs = {}
end

-- 消息头大小;
local MESSAGE_HEADER_SIZE = 4
-- 消息头长度大小;
local HEADER_LENGTH_SIZE = 2

function GameDecoder:decode(data)
	readBuffer:writeBuf(data)
	readBuffer:setPos(1)
	-- 解析出所有的消息包;
	while true do
		-- 1. 无数据直接返回;
		if readBuffer:getAvailable() <= 0 then
			-- reset the readBuffer
			readBuffer = requireNewByteArray()
			return
		end
		-- 2. 小于消息头中消息长度的大小;
		if readBuffer:getAvailable() < HEADER_LENGTH_SIZE  then
		 	readBuffer = self:__cutPacketShitAndNewBuffer()
		 	return
		 end 
		 -- 3. 小于消息本身的长度;
		local msgLength = readBuffer:readShort()
		if readBuffer:getAvailable() < (msgLength - HEADER_LENGTH_SIZE) then
			-- 把剩余的字节剪切到新的buffer上;
			readBuffer:setPos(readBuffer:getPos() - HEADER_LENGTH_SIZE)
			readBuffer = self:__cutPacketShitAndNewBuffer()
			return
		end
		-- 4. 消息可以解析出来;
		-- read messageType
		local messageType = readBuffer:readShort()
		local executeHandler = GlobalMessageRegistry:getExecuteHandler(messageType)
		--dump(readBuffer:toString(), "before cut")
		if executeHandler == nil then
			-- 跳过无处理器的流;
			local bodySize = msgLength - MESSAGE_HEADER_SIZE
			readBuffer:setPos(readBuffer:getPos() + bodySize)
			logger:error("No such executeHandler: %s (%d)", getMessageTypeName(messageType), messageType)
		else
			logger:debug("Received message type is: %s (%d)", getMessageTypeName(messageType), messageType)
			executeHandler(readBuffer)
		end
		
	end
end

--[[
	这里的实现方式有问题，会导致lpack报错
	[LUA-print] [INFO] LUA ERROR: [string "framework/cc/utils/ByteArray.lua"]:101: too many results to unpack
	可以去参考网址：http://www.lua.org/bugs.html
	原因是因为unpack的数据太多，导致lua的栈空间不够；
	解决此问题
--]]
-- 把不完整的消息包数据切除下来，放置到新的buffer上;
-- @param offset 切除前buffer指针需要做的移位;
-- @return 返回切除有用数据以后的新的buffer;
function GameDecoder:__cutPacketShitAndNewBuffer(offset)
	offset = offset or 0
	-- copy to new buffer
	local newBuffer = requireNewByteArray()
	readBuffer:setPos(readBuffer:getPos() + offset)
	newBuffer:writeBuf(readBuffer:getPack(readBuffer:getPos(), readBuffer:getLen()))
	-- reset
	newBuffer:setPos(1)
	return newBuffer
end

return GameDecoder
