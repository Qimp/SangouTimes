--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.global.GlobalFunc"
require "src.layer.battle.BattleLayer"
require "src.layer.MapLayer"


local str_com_plist = "res/common.plist"
local str_com_png = "res/common.png"

MainLayer = class("MainLayer", function()
    return cc.Layer:create()
end)


-- 构造
function MainLayer:ctor()

end
-- 创建
function MainLayer.create()
    local instance = MainLayer.new()
    if instance then
        instance:init()
    end
    return instance
end
-- 初始化
function MainLayer:init()

    -- 加入plist
    CacheManager:addPlist( str_com_plist, str_com_png )


--[[
    -- 左队
    local heroLeftList = {}
    for i = 1, 5 do
        local hero = HeroData.create( 20001 )
        hero.m_formationRow = i
        table.insert(heroLeftList,hero)
    end
    local teamLeft = TeamData.create( heroLeftList, LR.Left )

    -- 右队
    local heroRightList = {}
    for i = 1, 5 do
        local hero = HeroData.create( 20001 )
        hero.m_formationRow = i
        table.insert(heroRightList,hero)
    end
    local teamRight = TeamData.create( heroRightList, LR.Right)

    -- 状态
    local state = BattleState.create( teamLeft, teamRight)
    -- 战役
    local battleLayer = BattleLayer.create(state)
    battleLayer:startBattle()
    gfun.addChild( self, battleLayer, gg.zeroPoint)
    --]]
    CityManager:initCity()
    local layer = MapLayer.create()
    gfun.addChild( self, layer, gg.zeroPoint)

end


--endregion
