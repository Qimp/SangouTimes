--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.manager.CityManager"
require "src.layer.CityLayer"

local str_img_map = "res/mainmap.jpg"

MapLayer = class("MapLayer",function()
    return cc.Layer:create()
end)


-- 构造
function MapLayer:ctor()

end
-- 创建
function MapLayer.create()
    local instance = MapLayer.new()
    if instance then
        instance:init()
        gfun.setLayerTouchSwallowTrue( instance)
    end
    return instance
end
-- 初始化
function MapLayer:init()
    -- 地图
    --gfun.createSprWithFileName( self, str_img_map, gg.midPos, nil, nil)
    gfun.createScale9SpriteWithFileName( self, "res/bg.png", cc.size(960,640), gg.midPos, nil )
    local menu = gfun.createMenu( self )

    local function onCity(tag,sender)
        CityLayer.create(self, tag)
    end
    for cfgId, cityData in pairs( CityManager.m_cityDataList ) do
        local cfg = cityData:getCityCfg()
        local x = cfg["m_x"] or 0
        local y = cfg["m_y"] or 0
        gfun.createScaleItem( menu, cfg["m_name"], 50, "city1_1.png", cc.p(x,y), nil, cfgId, onCity )
    end

end
-- 按钮回调
function MapLayer:onButtonCallFunc(tag,sender)
    
end
-- 注册消息
function MapLayer:registerMsg()

end
-- 退出
function MapLayer:quit()
    self:removeFromParent(true)
end

--endregion
