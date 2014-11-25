 -- GameTCPService;
-- 游戏TCP服务;
-- @author crazyjohn;
-- 继承自{@code SocketTCP}

-- 日志
local logger = LoggerFactory:getLogger("GameTCPService")

local GameTCPService = class("GameTCPService", requireAndNew("framework.cc.net.SocketTCP"))
-- gameDecoder
local gameDecoder = requireAndNew("client.net.GameDecoder")

function GameTCPService:ctor( ... )
	-- 调用父类的构造器
	GameTCPService.super:ctor(...)
	-- init SocketTCP
	--self.__socket = requireAndNew("framework.cc.net.SocketTCP")
	self:addEventListener(self.EVENT_CONNECTED, handler(self,self.onConnected))
	self:addEventListener(self.EVENT_DATA, handler(self,self.onDataReceived))
	-- closeEvent
	self:addEventListener(self.EVENT_CLOSE, handler(self,self.onClosed))
	-- connectFailed
	self:addEventListener(self.EVENT_CONNECT_FAILURE, handler(self,self.onConnectFailed))
end

-- 建立连接以后回调;
function GameTCPService:onConnected(event)
	logger:info("Socket status: %s", event.name)
	local userName = "john"
	local password = "john"
	CGPlayerMessage:CG_PLAYER_LOGIN(userName, password)
end

function GameTCPService:onClosed(event)
	logger:info("Socket status: %s", event.name)
	local alertLayer = requireNewLayer("AlertLayer")
	alertLayer:showMe("失去服务器连接!", {"确定"}, {
			function( ... )
				PopUpManager:removePopUp(alertLayer)
			end
		})
end

function GameTCPService:onConnectFailed(event)
	logger:info("Socket status: %s", event.name)
	local alertLayer = requireNewLayer("AlertLayer")
	alertLayer:showMe("连接服务器失败!", {"确定"}, {
			function( ... )
				PopUpManager:removePopUp(alertLayer)
			end
		})
end

-- 发送消息包;
-- @param messageType 消息类型;
-- @param body 消息体;
function GameTCPService:sendPacket(messageType, body)
	body = body or requireNewByteArray()
	-- wirteBuffer
	local writeBuffer = requireNewByteArray()
	writeBuffer:writeShort(body:getLen() + 4)
	logger:debug("Send message type is: %s (%d)", getMessageTypeName(messageType), messageType)
	writeBuffer:writeShort(messageType)
	if body:getLen() > 0 then
		writeBuffer:writeBytes(body)
	end
	self:send(writeBuffer:getPack())
end

-- 接受到服务器数据;
-- @param event 回调网络事件;
function GameTCPService:onDataReceived(event)
	-- 这里要处理粘包的情况，写一个Decoder
	-- logger:debug("Socket status: %s", event.name)
	gameDecoder:decode(event.data)
end

return GameTCPService