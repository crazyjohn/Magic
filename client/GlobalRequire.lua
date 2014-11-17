-- 全局的引入库;
-- 初始化有时序;
-- @author crazyjohn;
-- 引入常量定义
require "client.GlobalConstInit"
-- 引入客户端配置
require "client.ClientConfig"
-- 引入quicks框架
require "framework.init"
-- 引入消息类型
MessageType = require(CLIENT_MESSAGE_PATH .. "MessageType")
-- 引入全局方法库
require "client.GlobalFunctions"
-- 引入枚举类型(依赖于全局方法)
require(CLIENT_ENUM_PATH.. "EnumInit")

-- ---------- LoggerSystem begin -----------
-- 游戏日志系统
-- 日志级别定义;
DEBUG = 0
INFO = 1
WARN = 2
ERROR = 3
-- 游戏日志级别设置
Game_Logger_Level = DEBUG 
-- 日志工具引入
require(CLIENT_UTIL_PATH .. "DebugUtil")
LoggerFactory = requireAndNew(CLIENT_LOGGER_PATH .. "LoggerFactory")
-- ---------- LoggerSystem end -----------

-- CCFileUtils:sharedFileUtils():getCachePath()

-- 引入管理器工厂(依赖于MessageType)
require "client.Managers"

-- ---------- Net begin -----------
-- socket库的引入
-- GameTCPService
GameSocketClass = require(CLIENT_NET_PATH .. "GameTCPService")
GameSocket = GameSocketClass.new(ServerIp, ServerPort, false)
-- ---------- Net end -----------

-- ---------- EventBus begin ----------
EventBus = requireAndNew(CLIENT_EVENT_PATH .. "EventBus")
EventType = require(CLIENT_EVENT_PATH .. "EventType")


-- ---------- EventBus end ----------





