--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.cfg.FuncStrCfg"

local str_img_btn2 = "ui_btn_2.png"


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

    local cfgId = data:getBuildCfgId()
    local cfg = BuildCfg[cfgId]
    -- 背景
    gfun.createSprWithFileName( self, cfg["m_bg"], gg.midPos, nil, nil)
    -- 创建菜单显示
    self:updateMenuShow()

    -- 注册消息
    self:registerMsg()

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
    local startY = 400
    local moveY = 35
    local menu = gfun.createMenu(node,gg.zeroPoint)
    local funcList = bulidData:getOpenFuncList()
    for k, funcType in ipairs(funcList) do
        local str = FuncStrCfg[funcType] or ""
        gfun.createScaleItem( menu, str, 24, gg.color_black, str_img_btn2, cc.p(gg.midX,startY-k*moveY), nil, funcType, onBtn )
    end
    -- 退出按钮
    gfun.createScaleItem( menu, str_btn_quit, 24, gg.color_black, str_img_btn2, cc.p(gg.midX,startY-(#funcList+1)*moveY), nil, nil, function()
        self:quit()
    end )
end
-- 按钮回调
function BuildingLayer:onButtonCallFunc(tag,sender)
    if tag == FuncType.Buy then   -- 购买

    elseif tag == FuncType.Sell then -- 卖出
    end

    cclog("tag == " .. tag)
end
-- 处理父界面
function BuildingLayer:dualWithParentWin( bShow )
    local parent = self:getParent()
    if parent and parent.showMenuByChild then
        parent:showMenuByChild(bShow)
    end
end
-- 注册消息
function BuildingLayer:registerMsg()
    local function enterOrExit(event)
        if event == "enter" then
            self:dualWithParentWin( false )
        elseif event == "exit" then
            self:dualWithParentWin( true )
        end
    end
    self:registerScriptHandler(enterOrExit)
end
-- 退出
function BuildingLayer:quit()
    self:removeFromParent(true)
end


--endregion
