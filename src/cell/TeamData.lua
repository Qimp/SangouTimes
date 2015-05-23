--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.cell.ArmyNode"


local s_tagLeft_base = 300
local s_tagRight_base = 350


TeamData = class("TeamData")

function TeamData:ctor()
    self.m_heroList = {}
    self.m_formationId = FormationType.SanKai      -- 使用的阵型
    self.m_nodeList = {}        -- 节点列表
    self.m_inLR = LR.Left       -- 默认在左边


end
-- 创建
function TeamData.create( heroList, inLR )
    local instance = TeamData.new()
    if instance then
        instance:init(heroList, inLR)
    end
    return instance
end
-- 初始化
function TeamData:init(heroList, inLR)
    self.m_heroList = heroList
    self.m_inLR = inLR or LR.Left
end
-- 设置阵型
function TeamData:setFormation( formationType ) 
    self.m_formationId = formationType
end
-- 获取阵型
function TeamData:getFormation()
    return self.m_formationId
end

-- 节点相关
-- 获取节点的攻击距离
function TeamData:getNodeAttackRange( node )
    local hero = node:getHero()
    return hero:getAttackRange()
end
-- 获取移动速度
function TeamData:getNodeMoveSpeed( node )
    local hero = node:getHero()
    return hero:getMoveSpeed()
end
-- 获取攻击力
function TeamData:getNodeAttack( node )
    local hero = node:getHero()
    return hero:getAttack()
end
-- 通过行号获取armyNode
function TeamData:getArmyNodeByRow( row )
    local baseTag = 0
    if self.m_inLR == LR.Left then
        baseTag = s_tagLeft_base
    else
        baseTag = s_tagRight_base
    end
    local findTag = baseTag + row
    for k, node in pairs(self.m_nodeList) do
        if node:getTag() == findTag then
            return node
        end
    end
end

-- 注册节点生命周期
function TeamData:registerArmyNode( armyNode )
    local function enterOrExit(event)
        if event == "exit" then
            local nodeList = self.m_nodeList
            for k, node in pairs(nodeList) do
                if node == armyNode then
                    nodeList[k] = nil
                    break
                end
            end
        end
    end
    armyNode:registerScriptHandler(enterOrExit)
end
-- 创建军队节点
function TeamData:createArmyNode()
    local nodeList = {}
    for k, hero in ipairs( self.m_heroList ) do
        local node = ArmyNode.create( hero )
        if node then
            nodeList[hero] = node
            node:setLRDirection( self.m_inLR )
            node:setTeam( self )
            self:registerArmyNode( node )
        end        
    end
    self.m_nodeList = nodeList
    return nodeList
end
-- 把军队节点加入到parent中
function TeamData:addArmyNodeToMap( parent )
    self:createArmyNode()
    for k, node in pairs(self.m_nodeList) do
        local hero = node:getHero()
        local formationRow = hero.m_formationRow
        local pos = gfun.getOnFormationPos( formationRow, self.m_formationId, self.m_inLR )
        if self.m_inLR == LR.Right then
            node:setTag( s_tagRight_base + formationRow )
        else
            node:setTag( s_tagLeft_base + formationRow )
        end
        gfun.addChild( parent, node, pos)
    end
end
-- 运行
function TeamData:run()
    local nodeList = self.m_nodeList
    for k, node in pairs(nodeList) do
        node:run()   
    end
end


--endregion
