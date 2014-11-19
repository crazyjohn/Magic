
-- 全局的方法定义;
-- @author crazyjohn;
-- @date: 2014-10-20
function ccLog( ... )
	print(string.format(...))
end

-- 进入指定的模块;
-- @param moduleName 模块名称;
-- @param params 进入模块传递的参数;
function globalEnterModule(moduleName, params)
	-- body
	ModuleManagerInstance:enterModule(moduleName, params)
end

-- 退出指定的模块;
-- @param moduleName 模块的名称;
-- @param params 退出模块传递的参数;
function globalExitModule(moduleName, params)
	ModuleManagerInstance:exitModule(moduleName, params)
end

function addViewToModuleLayer(view)
	LayerManagerInstance:addViewToModuleLayer(view)
end

function removeViewFromModuleLayer(view)
	LayerManagerInstance:removeViewToModuleLayer(view)
end

-- 引入指定的模块并且返回一个新的实例
-- @param moduleName; 模块名称;
-- @return instance; 返回指定的模块实例
function requireAndNew(moduleName, ...)
	-- body
	local instanceClass = require(moduleName)
	local instance = nil
	local params = {...}
	if params ~= nil and #params > 0 then
		instance = instanceClass.new(unpack(params))
	else
		instance = instanceClass.new()
	end
	return instance
end

-- 引入指定的消息处理器并且返回一个新的实例
-- @param handlerName; 消息处理器名称;
-- @return instance; 返回指定的消息处理器实例
function requireNewHandler(handlerName, ...)
	-- body
	local handlerPath = CLIENT_HANDLER_PATH .. handlerName
	return requireAndNew(handlerPath)
end

function requireNewMessage(messageName, ...)
	local messagePath = CLIENT_MESSAGE_PATH .. messageName
	return requireAndNew(messagePath)
end

function requireNewModel(modelName, ...)
	local modelPath = CLIENT_DATA_PATH .. modelName
	return requireAndNew(modelPath)
end

function requireNewLayer(layerName, ...)
	local layerPath = CLIENT_LAYER_PATH .. layerName
	return requireAndNew(layerPath)
end


-- 创建新的日志类;
-- @param loggerName 日志名称;
-- @param level 日志等级;
function requireNewLogger(loggerName, level)
	local loggerPath = CLIENT_LOGGER_PATH .. "Logger"
	return requireAndNew(loggerPath, loggerName, level)
end

function requireNewByteArray()
	return requireAndNew("framework.cc.utils.ByteArray")
end

function requireNewProtoData(protoName)
	local protoPath = CLIENT_PROTO_DATA_PATH .. protoName
	return requireAndNew(protoPath)
end

-- 引入枚举类型;
function requireEnum(enumName)
	return require(CLIENT_ENUM_PATH .. enumName)
end

-- 加载指定的CocosStudio生成的json格式的ui文件;
-- @param jsonFile json文件;
-- @return 返回ui的组件Widget root节点;
function loadUI(jsonFile)
	-- body
	local widget = GUIReader:shareReader():widgetFromJsonFile(jsonFile)
	--- why??? clons?
	--widget = widget:clone()
	return tolua.cast(widget, "Layout")
end

function getMessageTypeName(messageType)
	for k,v in pairs(MessageType) do
		if messageType == v then
			return tostring(k)
		end
	end
	return "UnknowMessageType"
end

