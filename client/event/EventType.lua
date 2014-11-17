-- 事件类型;
-- @author crazyjohn
-- @date 2014-11-16 12:52:43
--

EventType = {}
-- 事件后缀
local EVENT_POSTFIX = "_EVENT"

-- 服务器通知自动命名名称事件
EventType.GC_AUTO_NAME = "GC_AUTO_NAME" .. EVENT_POSTFIX
-- 服务器通知角色列表
EventType.GC_CHAR_LIST = "GC_CHAR_LIST" .. EVENT_POSTFIX


return EventType
