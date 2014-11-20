-- 视图层管理器
-- @author crazyjohn;
-- @date: 2014-10-20

-- logger
local logger = LoggerFactory:getLogger("LayerManager")
-- class
local LayerManager = class("LayerManager")
-- touchGroupLayer 负责触摸事件处理;
local touchGroupLayer = TouchGroup:create()
-- 真正的UI层, 使用addWidget添加到touchGroupLayer
local rootUILayer = Layout:create()

-- 初始化视图层管理器;
-- @param root 基础层节点;
function LayerManager:initLayerManager(root)
	-- 1. UI层
	root:addChild(touchGroupLayer)
	-- 天杀的这里要使用这个接口才可以;
	touchGroupLayer:addWidget(rootUILayer)
	-- 2. popUpManager层
	local popUpLayer = Layout:create()
	touchGroupLayer:addWidget(popUpLayer)
	PopUpManager:setRoot(popUpLayer)
end

-- 添加视图到模块视图层;
-- @param view 要添加的视图;
function LayerManager:addViewToModuleLayer(view)
	rootUILayer:addChild(view)
end

-- 从模块视图层移除指定的视图;
-- @param 需要移除的视图;
function LayerManager:removeViewToModuleLayer(view)
	rootUILayer:removeChild(view, true)
end

return LayerManager