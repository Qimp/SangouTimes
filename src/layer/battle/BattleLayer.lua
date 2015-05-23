--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.layer.battle.BattleState"

BattleLayer = class("BattleLayer", function()
    return cc.Layer:create()
end)

-- 构造
function BattleLayer:ctor()
    self.m_battleState = nil
end
-- 创建
function BattleLayer.create( battleState )
    local instance = BattleLayer.new()
    if instance then
        instance:init(battleState)
    end
    return instance
end
-- 初始化
function BattleLayer:init(battleState)
    self.m_battleState = battleState
end
-- 运行
function BattleLayer:startBattle()
    local battleState = self.m_battleState
    if battleState then
        gfun.addChild(self,battleState,gg.zeroPoint)
        battleState:start()
    end
end




--endregion
