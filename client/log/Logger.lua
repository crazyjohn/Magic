-- 日志类;
-- Author: crazyjohn
-- Date: 2014-11-05 15:54:25
--
local Logger = class("Logger")

function Logger:ctor(loggerName, level)
	self.__name = loggerName or "UnknowLogger"
	self.__level = level or INFO -- 默认日志级别为INFO
end

-- 获取日志名称;
function Logger:getName()
	return self.__name
end

-- dump;
-- 默认使用DEBUG级别;
function Logger:dump(value, desciption, nesting)
	if self.__level > DEBUG then
		return
	end
	dump(value, desciption, nesting)
end

-- 调试日志接口;
function Logger:debug(message, ...)
	if self.__level > DEBUG then
		return
	end
	printLogger("debug", self:getName(), message, ...)
end

-- 基本日志接口;
function Logger:info(message, ...)
	if self.__level > INFO then
		return
	end
	printLogger("info", self:getName(), message, ...)
end

-- 警告日志接口;
function Logger:warn(message, ...)
	if self.__level > WARN then
		return
	end
	printLogger("warn", self:getName(), message, ...)
end

-- 错误日志接口;
function Logger:error(message, ...)
	if self.__level > ERROR then
		return
	end
	printLogger("error", self:getName(), message, ...)
end




return Logger