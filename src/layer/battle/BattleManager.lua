--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


BattleManager = {}


local s_tagLeft_base = 300
local s_tagRight_base = 350


-- 获取敌对的节点
function BattleManager.getHostileNode( node )
    local tag = node:getTag()
    local hostileTag = 0
    if tag > s_tagRight_base then
        hostileTag = tag - s_tagRight_base + s_tagLeft_base
    else
        hostileTag = tag - s_tagLeft_base + s_tagRight_base
    end
    local parent = node:getParent()
    if parent then
        return parent:getChildByTag( hostileTag )
    end
end






--endregion
