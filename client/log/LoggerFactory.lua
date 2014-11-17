-- 日志工厂;
-- Author: crazyjohn
-- Date: 2014-11-05 15:51:48
--

local LoggerFactory = class("LoggerFactory")

-- 构造方法;
-- @param level 日志等级;
function LoggerFactory:ctor(...)
	self.__loggers = {}
	self.__level = Game_Logger_Level
end

-- 根据日志名称获取日志类;
-- @param loggerName 日志名称;
function LoggerFactory:getLogger(loggerName)
	local logger = self.__loggers[loggerName]
	if logger == nil then
		logger = requireNewLogger(loggerName, self.__level)
		self.__loggers[loggerName] = logger
	end
	return logger
end




return LoggerFactory