-- 管理器集合;
-- @author crazyjohn;
-- @date: 2014-10-20
-- ---------- MVC begin ----------
-- 模块管理器
ModuleManagerInstance = requireAndNew(CLIENT_MANAGERS_PATH .. "ModuleManager")
-- 视图层管理器
LayerManagerInstance = requireAndNew(CLIENT_MANAGERS_PATH .. "LayerManager")
-- 业务模型管理器
ModelManager = requireAndNew(CLIENT_MANAGERS_PATH .. "ModelManager")
-- ---------- MVC end ----------

-- 全局消息注册表;
GlobalMessageRegistry = requireAndNew(CLIENT_MANAGERS_PATH .. "MessageTypeToHandlerRegistry") 
-- 全局消息处理器静态工厂
GlobalHandlers = requireAndNew(CLIENT_MANAGERS_PATH .. "Handlers") 
-- GC消息注册
require(CLIENT_MESSAGE_REGISTRY .. "GCMessageRegistry") 
-- CG消息註冊
require(CLIENT_MESSAGE_REGISTRY .. "CGMessageRegistry")