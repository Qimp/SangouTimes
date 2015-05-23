--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.cell.TeamData"
require "src.layer.battle.BattleManager"


BattleState = class("BattleState", function()
    return cc.Node:create()
end)


function BattleState:ctor()
    self.m_leftTeam = nil
    self.m_rightTeam = nil
end
-- 创建
function BattleState.create( leftTeam, rightTeam)
    local instance = BattleState.new()
    if instance then
        instance:init(leftTeam, rightTeam)
    end
    return instance
end
-- 初始化
function BattleState:init(leftTeam, rightTeam)
    self.m_leftTeam = leftTeam
    self.m_rightTeam = rightTeam

    -- 注册消息
    self:registerMsg()
end
-- 是否在攻击范围内
function BattleState:isInAttackRange( atkNode, defNode )
    if atkNode == nil or defNode == nil then
        return false
    else
        local distance = math.abs(atkNode:getAtkCountX() - defNode:getAtkCountX() )
        local atkTeam = atkNode:getTeam()
        local atkRange = atkTeam:getNodeAttackRange( atkNode )
        if distance <= atkRange then
            return true
        end
    end
    return false
end
-- 是否能移动
function BattleState:isCanMove( node )
    return true
end
-- AI
function BattleState:battleAI( leftTeam, rightTeam )
    for row = 1, 5 do
        local leftNode = leftTeam:getArmyNodeByRow(row)
        local rightNode = rightTeam:getArmyNodeByRow(row)

        if leftNode and rightNode then
            if self:isInAttackRange( leftNode, rightNode ) then
                leftNode:playActionByIStatendex( StateIndex.Attack )
            else
                if self:isCanMove(leftNode) then
                    leftNode:playActionByIStatendex( StateIndex.Move )
                end
            end
            if self:isInAttackRange( rightNode, leftNode ) then
                rightNode:playActionByIStatendex( StateIndex.Attack )
            else
                if self:isCanMove(rightNode) then
                    rightNode:playActionByIStatendex( StateIndex.Move )
                end
            end
        elseif leftNode then
            if self:isCanMove(leftNode) then
                leftNode:playActionByIStatendex( StateIndex.Move )
            end
        elseif rightNode then
            if self:isCanMove(rightNode) then
                rightNode:playActionByIStatendex( StateIndex.Move )
            end
        end
    end
end
-- 注册消息
function BattleState:registerMsg()
    local i = 0
    local function battle_listener_CB(event)
        local cmd = event.__cmd
        local w1 = event.__w1
        local w2 = event.__w2
        local w3 = event.__w3

        if cmd == MSG_BATTLE.ATTACK_START then
            i = i + 1
            cclog("start" .. i)

        elseif cmd == MSG_BATTLE.ATTACK_FINISH then
            local atkNode = w1
            local defNode = BattleManager.getHostileNode( atkNode )

            local atk = 0
            if atkNode then
                local atkTeam = atkNode:getTeam()
                if atkTeam then
                    atk = atkTeam:getNodeAttack( atkNode )
                end
            end
            
            if defNode then
                defNode:delArmyNum( atk )
            end
        end
    end


    local dispathcer = self:getEventDispatcher()
    local battle_listener = nil
    local function enterOrExit( event )
        if event == "enter" then
            battle_listener = cc.EventListenerCustom:create( MSG_BATTLE.TOTAL, battle_listener_CB )
            dispathcer:addEventListenerWithFixedPriority( battle_listener, 1 )
        elseif event == "exit" then
            dispathcer:removeEventListener( battle_listener )
        end
    end

    self:registerScriptHandler(enterOrExit)
end
-- 运行
function BattleState:start()
    local leftTeam = self.m_leftTeam
    local rightTeam = self.m_rightTeam
    -- 加入队伍节点
    if leftTeam then
        leftTeam:addArmyNodeToMap( self )
    end
    if rightTeam then
        rightTeam:addArmyNodeToMap( self )
    end
    -- 开始运行AI
    local function runLayer()
        local leftTeam = self.m_leftTeam
        local rightTeam = self.m_rightTeam
        if leftTeam and rightTeam then
            self:battleAI(leftTeam,rightTeam)
            leftTeam:run()
            rightTeam:run()
        end
    end
    -- 计时器
    schedule(self,function()
        runLayer()
    end,0.01)
end




--endregion
