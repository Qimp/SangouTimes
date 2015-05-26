--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.manager.CityManager"
require "src.layer.BuildingLayer"
require "src.manager.PlayerManager"

local str_img_bg = "ui_bg.png"
local str_img_bgBar = "ui_bar.png"
local str_img_btn1 = "ui_btn_1.png"

local str_btn_quit = "退出"
local str_tips_cityExpLv = "城市发展:%d(%s)"
local str_tips_gold = "金币:%s"
local str_tips_food = "资源:%s"

CityLayer = class("CityLayer",function()
    return cc.Layer:create()
end)

-- 构造
function CityLayer:ctor()
    self.m_cityCfgId = 0

    self.m_node_bulid = nil         -- 建筑按钮节点

    self.m_node_msgBar = nil        -- 建筑信息节点
    self.m_lab_cityName = nil       -- 城市名字
    self.m_lab_exp = nil            -- 城市发展值
    self.m_lab_offerGold = nil      -- 城市税收
    self.m_lab_playerGold = nil     -- 玩家金币
    self.m_lab_playerFood = nil     -- 玩家资源

    self.m_node_season = nil        -- 季节节点
    self.m_lab_season = nil         -- 季节

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

    local cityData = CityManager.m_cityDataList[cfgId]
    if not cityData then
        return 
    end
    local cityCfg = cityData:getCityCfg() 
    -- 城市背景
    gfun.createSprWithFileName( self, cityCfg["m_bg"], gg.midPos, nil, nil)
    -- 边框
    gfun.createScale9SpriteWithFrameName( self, str_img_bg, cc.size(960,640), gg.midPos, nil )
    -- 条框
    gfun.createSprWithFrameName( self, str_img_bgBar, cc.p(480,605), nil, nil)
    -- 创建/更新城市信息栏
    self:updateCityMsgBarShow()
    -- 创建/更新季节
    self:updateSeasonShow()
    -- 更新城市建筑
    self:updateBulidShow()

    -- 注册消息
    self:registerMsg()
end
-- 创建/更新城市信息栏
function CityLayer:updateCityMsgBarShow()
    local node = self.m_node_msgBar
    if not node then
        node = gfun.createNode(self)
        self.m_node_msgBar = node
    end
    -- 标签
    local color = gg.color_white
    local fontName = gg.systemFont
    local fontSize = 20
    local anchorPos = cc.p(0,0.5)
    local startY = 605

    local cityData = CityManager.m_cityDataList[self.m_cityCfgId]
    local cityCfg = cityData:getCityCfg() 
    -- 名字
    if self.m_lab_cityName then
    else
        self.m_lab_cityName = gfun.CreateLabel( node, cityCfg["m_name"], color, fontName, fontSize+4, cc.p(50,startY), anchorPos)
    end
    -- 规模
    local expLv, lvStr = cityData:getCityLv()
    local str = string.format(str_tips_cityExpLv, cityData:getExp(), lvStr or "")
    if self.m_lab_exp then
        self.m_lab_exp:setString(str)
    else
        self.m_lab_exp = gfun.CreateLabel( node, str, color, fontName, fontSize, cc.p(200,startY), anchorPos)
    end
    -- 金币
    local strGold = string.format(str_tips_gold,PlayerManager.m_gold)
    if self.m_lab_playerGold then
        self.m_lab_playerGold:setString( strGold )
    else
        self.m_lab_playerGold = gfun.CreateLabel( node, strGold, color, fontName, fontSize, cc.p(400,startY), anchorPos)
    end
    -- 军粮
    local strFood = string.format(str_tips_food,PlayerManager.m_food)
    if self.m_lab_playerFood then
        self.m_lab_playerFood:setString( strFood )
    else
        self.m_lab_playerFood = gfun.CreateLabel( node, strFood, color, fontName, fontSize, cc.p(600,startY), anchorPos)   
    end
end
-- 创建/更新城市季节
function CityLayer:updateSeasonShow()
    local node = self.m_node_season
    if not node then
        node = gfun.createNode(self)
        self.m_node_season = node
    end

    local color = gg.color_white
    local fontName = gg.systemFont
    local fontSize = 20
    local anchorPos = cc.p(0,0.5)
    local startY = 605
    -- 季节
    if self.m_lab_season then
        self.m_lab_season:setString( TimeManager:getSeasonStr() )
    else
        self.m_lab_season = gfun.CreateLabel( node, TimeManager:getSeasonStr(), color, fontName, fontSize, cc.p(800,startY), anchorPos)
    end
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

    local function onBuild(tag,sender)
        local data = sender["temp_data"]
        BuildingLayer:create( self, data )
    end
    local menu = gfun.createMenu( node )
    -- 创建建筑按钮
    local buildList = cityData:getBuildList()
    local i = 0
    local startX = 80
    local startY = 500
    local moveY = 45
    for k, data in ipairs( buildList) do
        if data:isOpen() then
            local bulidName = data:getBuildName()
            local cfgId = data:getBuildCfgId()
            local item = gfun.createScaleItem( menu, bulidName, 22, gg.color_black, str_img_btn1, cc.p(startX,startY - i*moveY), nil, cfgId, onBuild )
            item["temp_data"] = data
            i = i + 1
        end
    end
    -- 退出按钮
    gfun.createScaleItem( menu, str_btn_quit, 22, gg.color_black, str_img_btn1, cc.p(startX,startY - i*moveY), nil, nil, function()
        self:quit()
    end )


end
-- 隐藏/显示菜单
function CityLayer:showMenuByChild( bShow )
    local node = self.m_node_bulid
    if node then
        node:setVisible(bShow)
    end
end
-- 注册消息
function CityLayer:registerMsg()
    local function listener_season_CB(event)
        self:updateSeasonShow()
    end

    local listenr_season = nil
    local function enterOrExit(event)
        local dispatcher = self:getEventDispatcher()
        if event == "enter" then
            listenr_season = cc.EventListenerCustom:create(gmsg.MSG_SEASON, listener_season_CB)     
            dispatcher:addEventListenerWithFixedPriority( listenr_season, 1 )       
        elseif event == "exit" then
            dispatcher:removeEventListener( listenr_season )
        end
    end
    self:registerScriptHandler(enterOrExit)
end
-- 退出
function CityLayer:quit()
    self:removeFromParent(true)
end

--endregion
