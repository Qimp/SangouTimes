--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.manager.CityManager"



CityLayer = class("CityLayer",function()
    return cc.Layer:create()
end)

-- 构造
function CityLayer:ctor()
    self.m_cityCfgId = 0

    self.m_node_bulid = nil
end
-- 创建
function CityLayer.create( parent, cfgId )
    local instance = CityLayer.new()
    if instance then
        instance:init( cfgId )
        gfun.setLayerTouchSwallowTrue( instance)
        gfun.addChild( parent, instance, gg.zeroPoint)
    end
    return instance
end
-- 初始化
function CityLayer:init(cfgId)
    self.m_cityCfgId = cfgId
    self:updateBulidShow()
end
-- 更新城市建筑
function CityLayer:updateBulidShow()
    local node = self.m_node_bulid
    if node then
        node:removeAllChildren()
    else
        node = gfun.createNode(self,gg.zeroPoint,nil)
        self.m_node_bulid = node
    end

    local cfgId = self.m_cityCfgId
    local cityData = CityManager.m_cityDataList[cfgId]
    if not cityData then
        return 
    end

    local function onBuild(tag,sender)
        
    end
    local menu = gfun.createMenu( node )
    -- 创建建筑
    local buildList = cityData:getBuildList()
    local i = 0
    for k, data in ipairs( buildList) do
        if data:isOpen() then
            local bulidName = data:getBuildName()
            local cfgId = data:getBuildCfgId()
            gfun.createScaleItem( menu, bulidName, 20, "", cc.p(200,300 - i*30), nil, cfgId, onBuild )
            i = i + 1
        end
    end
end
-- 注册消息
function CityLayer:registerMsg()

end
-- 退出
function CityLayer:quit()
    self:removeFromParent(true)
end

--endregion
