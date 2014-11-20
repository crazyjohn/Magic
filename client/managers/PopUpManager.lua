-- PopUpManager
-- @author crazyjohn
-- @date 2014-11-19 16:35:15
--

-- create logger
local logger = LoggerFactory:getLogger("PopUpManager")
-- create class
local PopUpManager = class("PopUpManager")

-- ctor
function PopUpManager:ctor()
    -- body of ctor
end

function PopUpManager:setRoot(root)
	self.__root = root
	-- local redLayer = CCLayerColor:create(ccc4(255,0,0,100))
	-- redLayer:setContentSize(1024, 768)
	-- self.__root:addNode(redLayer)
	self.__root:setSize(CCSize(display.width, display.height))
end

function PopUpManager:addPopUp(popUp, isModal, isCenter, animationType)
	-- body
	if isCenter then
		--popUp:setAnchorPoint(ccp(0.5, 0.5))
		--logger:debug("PopUp x: %d, y: %d, width:%d, height:%d", popUp:getAnchorPoint().x, popUp:getAnchorPoint().y, popUp:getContentSize().width, popUp:getContentSize().height)
		popUp:setPosition(ccp((self.__root:getSize().width - popUp:getContentSize().width)/2, (self.__root:getSize().height - popUp:getContentSize().height)/2))
	end
	self.__root:addChild(popUp)
end

function PopUpManager:removePopUp(popUp)
	self.__root:removeChild(popUp, true)
end

function PopUpManager:centerPopUp(popUp)
	self:addPopUp(popUp, true, true)
end

function PopUpManager:isPopUp(popUp)
	-- body
end

return PopUpManager
