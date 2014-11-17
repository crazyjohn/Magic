-- use lua to build game client engine.
-- The Game Launcher
-- engine_version:cocos2d-x 2.2.5
-- @author crazyjohn
--
require "client.GlobalRequire"
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    printInfo("----------------------------------------")
    printInfo("LUA ERROR: " .. tostring(msg) .. "\n")
    printInfo(debug.traceback())
    printInfo("----------------------------------------")
end


function main( ... )
	printInfo("YO YO YO, WHAT'S UP BIATCH(LUA)?")

	local sceneGame = CCScene:create()
	-- 初始化视图层
	LayerManagerInstance:initLayerManager(sceneGame)
	-- ui begin
	-- enterLoginModule
	globalEnterModule("LoginModule")
	-- ui end
    CCDirector:sharedDirector():runWithScene(sceneGame)
end


xpcall(main, __G__TRACKBACK__)