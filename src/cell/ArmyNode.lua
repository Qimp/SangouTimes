--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.cell.AnimateObj"
require "src.cell.HeroData"


local s_teamNum = 1000 -- 每一队最多人数

local s_nameLabTag = 2000
local s_numLabTag = 2001

local s_width = 35
local s_height = 30

local s_armyPosList = {
    [1] = cc.p(0,0),
    [2] = cc.p(s_width,0),
    [3] = cc.p(s_width,s_height),
    [4] = cc.p(s_width,-s_height),
    [5] = cc.p(0,s_height),
    [6] = cc.p(0,-s_height),
    [7] = cc.p(-s_width,s_height),
    [8] = cc.p(-s_width,0),
    [9] = cc.p(-s_width,-s_height)
}
local s_armyZOrderList = {
    [1] = 5,
    [2] = 6,
    [3] = 3,
    [4] = 9,
    [5] = 2,
    [6] = 8,
    [7] = 1,
    [8] = 4,
    [9] = 7
}

local s_armyMaxNum = table.getn(s_armyPosList)      -- 军团精灵最大数量



ArmyNode = class("ArmyNode", function()
    return cc.Node:create()
end)


-- 动作状态


-- buff状态


function ArmyNode:ctor()
    self.m_hero = nil           -- 英雄
    self.m_aniCfgId = 0         -- 动画配置id
    self.m_spriteList = {}      -- 军团精灵
    self.m_isDone   = true
    self.m_stateIndex = StateIndex.Wait   -- 动作状态索引
    self.m_inLR = LR.Left
    self.m_halfWidth = 0        -- 偏移量
    self.m_rangeCountX = 0      -- 计算距离的x 

    self.m_team = nil           -- 绑定的队伍
end

function ArmyNode.create( hero )
    local instance = ArmyNode.new()
    if instance and hero then
        instance:init(hero)
    end
    return instance
end
-- 初始化
function ArmyNode:init(hero)
    -- 绑定英雄
    self.m_hero = hero
    -- 动画配置id
    local armyTypeCfg = ArmyTypeCfg[ hero.m_curArmyId ] or {}
    local aniCfgId = armyTypeCfg["m_aniCfgId"] or 0
    self.m_halfWidth = armyTypeCfg["m_halfWidth"] or 0
    self.m_aniCfgId = aniCfgId
    self:updateArmyShow()
end
-- 从精灵表中删除
function ArmyNode:removeFromSpriteList( sp )
    for pos, data in pairs(self.m_spriteList) do
        if data == sp then
            table.remove(self.m_spriteList, pos)
            break
        end
    end
end
-- 获取绑定的英雄
function ArmyNode:getHero()
    return self.m_hero
end
-- 设置方向
function ArmyNode:setLRDirection(dir)
    self.m_inLR = dir
    self:updateArmyShow()
end
-- 设置绑定的队伍
function ArmyNode:setTeam( team )
    self.m_team = team
end
-- 获取绑定的队伍
function ArmyNode:getTeam()
    return self.m_team
end

-- 更新军队显示
function ArmyNode:updateArmyShow()
    local hero = self.m_hero
    local armyNum = hero:getSoldierNum()
    local spNum = 0

    -- 计算精灵数量
    local tempNum = math.floor( armyNum / s_teamNum )
    if armyNum - tempNum*s_teamNum > 0 then
        spNum = tempNum + 1
    else
        spNum = tempNum
    end

    if spNum == 0 then
        self:removeFromParent(true)
        return 
    elseif spNum > s_armyMaxNum then
        spNum = s_armyMaxNum
    end
    -- 更新精灵
    for k = 1, s_armyMaxNum do
        local tempSp = self:getChildByTag(k)
        if not tempSp then
            if k <= spNum then
                local sp = AnimateObj.create(self.m_aniCfgId)
                if sp then
                    gfun.addChild(self,sp,s_armyPosList[k] )
                    sp:setLocalZOrder(s_armyZOrderList[k])
                    sp:setTag(k)
                    table.insert(self.m_spriteList, sp)
                    if self.m_inLR == LR.Right then
                        sp:setRotationSkewY(180)
                    end
                end
            end
        else
            if k > spNum then
                tempSp:removeFromParent(true)
                self:removeFromSpriteList( tempSp )
            else
                if self.m_inLR == LR.Right then
                    tempSp:setRotationSkewY(180)
                end
            end
        end
    end


    if spNum <= 1 then
        self.m_rangeCountX = self.m_halfWidth           -- 计算距离的x 
    else
        self.m_rangeCountX = self.m_halfWidth + s_width -- 计算距离的x 
    end
    --[[
    -- 标签
    local labName = self:getChildByTag(s_nameLabTag)
    if labName then
        labName:setString(hero["m_name"])
    else
        labName = gfun.CreateLabel( self, hero["m_name"], gg.color_white, gg.systemFont, 16, cc.p(0,-30), nil)
        if labName then
            labName:setTag(s_nameLabTag)
        end
    end
    --]]
    local labNum = self:getChildByTag(s_numLabTag)
    if labNum then
        labNum:setString(hero:getSoldierNum())
    else
        labNum = gfun.CreateLabel( self, hero:getSoldierNum(), gg.color_white, gg.systemFont, 30, cc.p(0,-50), nil)
        if labNum then
            labNum:setTag(s_numLabTag)
            labNum:setLocalZOrder(10)
        end
    end


end
-- 播放动作
function ArmyNode:doAction( index, actionFunc, startFunc, finishFunc )
    local spriteList = self.m_spriteList
    for k, sp in pairs(spriteList) do
        if k == 1 then
            actionFunc( sp , index, nil, startFunc, finishFunc)
        else
            actionFunc(sp, index, nil, nil, nil)
        end
    end
end
-- 获取攻击距离的判断x
function ArmyNode:getAtkCountX()
    local baseX = self:getPositionX()

    if self.m_inLR == LR.Right then
        return baseX - self.m_rangeCountX
    end
    return baseX + self.m_rangeCountX
end
-- 增加士兵数量
function ArmyNode:addArmyNum( num )
    self.m_hero:addSoldierNum(num)
    self:updateArmyShow()
end
-- 减少兵数量
function ArmyNode:delArmyNum( num )
    self.m_hero:delSoldierNum(num)
    self:updateArmyShow()
end
-- 移动距离
function ArmyNode:moveDistance()

    local team = self.m_team
    local moveSpeed = 0
    if team then
        moveSpeed = team:getNodeMoveSpeed( self )
    else
        local hero = self.m_hero
        moveSpeed = hero:getMoveSpeed()
    end
    if self.m_inLR == LR.Right then
        moveSpeed = 0 - moveSpeed
    end

    local moveX = self:getPositionX() + moveSpeed
    local moveY = self:getPositionY()

    self:setPosition( cc.p(moveX, moveY) )
end
-- 运行 0.05秒运行应该比较合适
function ArmyNode:run( time )
    local index = self.m_stateIndex

    if index == StateIndex.Attack then
        self:doAction( index, AnimateObj.playAnimationEntry, function()
            gfun.sendEvent( self, MSG_BATTLE.TOTAL, MSG_BATTLE.ATTACK_START, self, w2, w3)   -- 开始攻击
        end, function()
            gfun.sendEvent( self, MSG_BATTLE.TOTAL, MSG_BATTLE.ATTACK_FINISH, self, w2, w3)   -- 完成攻击
        end )
    elseif index == StateIndex.Move then
        self:doAction( index, AnimateObj.playAnimationEntry )
        self:moveDistance()

    elseif index == StateIndex.Wait then
        self:doAction( index, AnimateObj.playAnimationEntry )

    end
end
-- 改变索引实现播放动画
function ArmyNode:playActionByIStatendex( index )
    self.m_stateIndex = index
end












--endregion
