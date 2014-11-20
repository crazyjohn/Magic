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
    self.__children = {}
end

--[[

设置根节点;
@param root 根节点;

]]
function PopUpManager:setRoot(root)
	self.__root = root
	-- local redLayer = CCLayerColor:create(ccc4(255,0,0,100))
	-- redLayer:setContentSize(1024, 768)
	-- self.__root:addNode(redLayer)
	--self.__root:setSize(CCSize(display.width, display.height))
end

--[[

创建蒙版层;

]]
function PopUpManager:__createMask()
	-- body
	local touchLayer = Layout:create()
	touchLayer:setSize(CCSize(display.width, display.height))
	local maskContent = CCLayerColor:create(ccc4(0, 0, 0, 150))
	touchLayer:addNode(maskContent)
	return touchLayer, maskContent
end

-- pop post fix
local POP_POSTFIX = "pop"
function PopUpManager:__addPopChild(child)
	self.__children[(#self.__children + 1) .. POP_POSTFIX] = child
end

function PopUpManager:__removePopChild(child)
	for k,v in pairs(self.__children) do
		if v == child then
			self.__children[k] = nil
		end
	end
end

--[[

添加弹出对象;
@param popUp 弹出对象;
@param isModal 是否模态展示;
@param isCenter 是否居中;
@param noMask 是否有蒙板;
@param animationType 动画类型;

]]
function PopUpManager:addPopUp(popUp, isModal, isCenter, noMask, animationType)
	-- is center?
	if isCenter then
		--popUp:setAnchorPoint(ccp(0.5, 0.5))
		--logger:debug("PopUp x: %d, y: %d, width:%d, height:%d", popUp:getAnchorPoint().x, popUp:getAnchorPoint().y, popUp:getContentSize().width, popUp:getContentSize().height)
		popUp:setPosition(ccp((display.width - popUp:getContentSize().width)/2, (display.height - popUp:getContentSize().height)/2))
	end
	local touchLayer, maskContent = self:__createMask()
	self.__root:addChild(touchLayer)
	touchLayer:addChild(popUp)
	-- add pop child
	self:__addPopChild(popUp)
	-- is modal?
	if isModal then
		logger:debug("It's modal state")
		touchLayer:setTouchEnabled(false)
	end
	-- no mask?
	if not noMask then
		-- fadeTo
		maskContent:setOpacity(0)
		local fadeTo = CCFadeTo:create(0.5, 150)
		maskContent:runAction(fadeTo)
	end
	-- TODO: crazyjohn animationType
	
end

--[[

移除弹出对象;

]]
function PopUpManager:removePopUp(popUp)
	-- is popUp
	if not self:isPopUp(popUp) then
		return
	end
	self:__removePopChild(popUp)
	local parent = popUp:getParent()
	popUp:removeFromParentAndCleanup(true)
	self.__root:removeChild(parent, true)
end

--[[

居中显示弹出对象;

]]
function PopUpManager:centerPopUp(popUp)
	self:addPopUp(popUp, true, true, false)
end

--[[

是否是弹出对象;

]]
function PopUpManager:isPopUp(popUp)
	for k,v in pairs(self.__children) do
		if v == popUp then
			return true
		end
	end
	return false
end

return PopUpManager
