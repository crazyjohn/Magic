-- 事件总线;
-- @author crazyjohn
-- @date 2014-11-16 12:51:59
--

-- create logger
local logger = LoggerFactory:getLogger("EventBus")
-- create class
local EventBus = class("EventBus")

-- ctor
function EventBus:ctor()
    -- 所有监听器
    self.__listeners = {}
    -- 宿主信息
    self.__hostListeners = {}
end

-- 添加事件监听器;
-- @param eventType 事件类型
-- @param listener 监听器
-- @param listenerHost 监听器的宿主对象(可以使用removeEventListenersByHost接口移除该宿主关联的所有监听器)
function EventBus:addEventListener(eventType, listener, listenerHost)
	local typeListeners = self.__listeners[eventType]
	if typeListeners == nil then
		typeListeners = {}
		self.__listeners[eventType] = typeListeners
	end
	typeListeners[#typeListeners + 1] = listener
	-- set host
	if listenerHost ~= nil then
		--listener.host = listenerHost
		self:__hostListener(listenerHost, listener)
	end
	logger:debug("Add listener, eventType: %s", tostring(eventType))
end

-- 关联宿主关系;
-- @param listenerHost 宿主对象;
-- @param listener 监听器;
function EventBus:__hostListener(listenerHost, listener)
	local listeners = self.__hostListeners[listenerHost]
	if listeners == nil then
		listeners = {}
		self.__hostListeners[listenerHost] = listeners
	end
	listeners[#listeners + 1] = listener
end

-- 移除指定的监听器;
-- @param eventType 事件类型
-- @param listener 监听器
function EventBus:removeEventListener(eventType, listener)
	local typeListeners = self.__listeners[eventType]
	if typeListeners == nil then
		return
	end
	-- 是否可以在遍历的时候删除元素????
	for i,v in ipairs(typeListeners) do
		if v == listener then
			table.remove(typeListeners, i)
		end
	end
end

-- 根据事件类型和宿主对象移除所有指定监听器;
-- @param eventType 事件类型
-- @param host 宿主
function EventBus:removeEventListenersByHost(host)
	for k,typeListeners in pairs(self.__listeners) do
		for i,v in ipairs(typeListeners) do
			if self:__hostMe(host, v) then
				table.remove(typeListeners, i)
			end
		end
	end
	self:__clearHost(host)
end

-- 清理宿主信息;
function EventBus:__clearHost(host)
	self.__hostListeners[host] = nil
end

-- 是否是指定监听器的宿主;
function EventBus:__hostMe(host, listener)
	local listeners = self.__hostListeners[host]
	if listeners == nil then
		return false
	end
	for i,v in ipairs(listeners) do
		if v == listener then
			return true
		end
	end
	return false
end

-- 分发事件;
-- @param eventType 事件类型;
-- @param data 事件数据;
function EventBus:fireEvent(eventType, data)
	local typeListeners = self.__listeners[eventType]
	if typeListeners == nil then
		logger:error("No such listener, eventType: %s", tostring(eventType))
		return
	end
	for i,v in ipairs(typeListeners) do
		v({eventType = eventType, data = data})
	end
end

return EventBus
