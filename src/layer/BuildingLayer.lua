--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.cfg.FuncStrCfg"


local str_btn_quit = "出去"


BuildingLayer = class("BuildingLayer",function()
    return cc.Layer:create()
end)

-- 构造
function BuildingLayer:ctor()
    self.m_build = {}               -- 绑定数据
    self.m_node_menu = nil          -- 节点
end
-- 创建
function BuildingLayer:create( parent, data )
    local instance = BuildingLayer.new()
    if instance then
        instance:init(data)
        gfun.setLayerTouchSwallowTrue(instance)
        gfun.addChild( parent, instance, gg.zeroPoint, nil)
    end
    return instance
end
-- 初始化
function BuildingLayer:init( data )
    if not data then
        return 
    end
    self.m_build = data

    -- 创建菜单显示
    self:updateMenuShow()

    -- 退出按钮
    gfun.createSingleBtn( self, str_btn_quit, 20, nil, cc.p(900,300), nil, nil, function()
        self:quit()
    end )

end
-- 更新菜单
function BuildingLayer:updateMenuShow()
    local node = self.m_node_menu
    if node then
        node:removeAllChildren(true)
    else
        node = gfun.createNode(self)
        self.m_node_menu = node
    end

    local bulidData = self.m_build
    local cfgId = bulidData:getBuildCfgId()
    local cfg = BuildCfg[cfgId]

    -- 创建按钮
    local function onBtn(tag,sender)
        self:onButtonCallFunc(tag,sender) 
    end
    local menu = gfun.createMenu(node,gg.zeroPoint)
    local funcList = bulidData:getOpenFuncList()
    for k, funcType in ipairs(funcList) do
        local str = FuncStrCfg[funcType] or ""
        gfun.createScaleItem( menu, str, 20, nil, cc.p(300,500-k*50), nil, funcType, onBtn )
    end
end
-- 按钮回调
function BuildingLayer:onButtonCallFunc(tag,sender)
    if tag == 1 then   -- 购买
        cclog("tag == " .. tag)
    elseif tag == 2 then -- 卖出
        cclog("tag == " .. tag)
    end
end
-- 退出
function BuildingLayer:quit()
    self:removeFromParent(true)
end


--endregion
