--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.global.GlobalFunc"
require "src.layer.battle.BattleLayer"
require "src.layer.MapLayer"


local str_com_plist = "res/common.plist"
local str_com_png = "res/common.png"

MainLayer = class("MainLayer", function()
    return cc.Layer:create()
end)


-- 构造
function MainLayer:ctor()

end
-- 创建
function MainLayer.create()
    local instance = MainLayer.new()
    if instance then
        instance:init()
    end
    return instance
end
-- 初始化
function MainLayer:init()

    -- 加入plist
    CacheManager:addPlist( str_com_plist, str_com_png )


    --[[
    -- 左队
    local heroLeftList = {}
    for i = 1, 5 do
        local hero = HeroData.create( 20001 )
        hero.m_formationRow = i
        table.insert(heroLeftList,hero)
    end
    local teamLeft = TeamData.create( heroLeftList, LR.Left )

    -- 右队
    local heroRightList = {}
    for i = 1, 5 do
        local hero = HeroData.create( 20001 )
        hero.m_formationRow = i
        table.insert(heroRightList,hero)
    end
    local teamRight = TeamData.create( heroRightList, LR.Right)

    -- 状态
    local state = BattleState.create( teamLeft, teamRight)
    -- 战役
    local battleLayer = BattleLayer.create(state)
    battleLayer:startBattle()
    gfun.addChild( self, battleLayer, gg.zeroPoint)
    --]]


    CityManager:initCity()
    local layer = MapLayer.create()
    gfun.addChild( self, layer, gg.zeroPoint)

    --self:test()
end

function MainLayer:test()
    
    local tableView = cc.TableView:create(cc.size(700,350))
    local cellHeight = 350/10

    local function onItem(tag, sender)
        cclog(tag)
    end

    local function tableCellAtIndex(table, idx)     -- 滑动的时候要显示的cell
        local cell = table:dequeueCell()
        if nil == cell then
            cell = cc.TableViewCell:new()
        else
            cell:removeAllChildren(true)
        end
        if cell then
            local menu = FreeMenu:create()
            local sss = tableView:getContentSize()
            --menu:setTouchSize(  cc.size(700, 30) )
            menu:setMenuParent(  table, cc.size(700,350) )
            
            menu:setAnchorPoint( cc.p(0,0) )
            gfun.createScaleItem( menu, string.format("%d加适量房间",idx), 30, nil,"", cc.p(0,0), nil, idx, onItem )
            gfun.addChild(cell,menu,cc.p(0,0),nil)
        end
        return cell
    end
    local function numberOfCellsInTableView( table )
        return 20       -- 返回要建立多少个cell
    end

    local function cellSizeForTable(table,idx) 
        return cellHeight,0  -- ( cell之间的  高  宽   在垂直之间高有效， 在水平之间宽有效)
    end
    if tableView then
        tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)    -- 设置垂直
        tableView:setPosition(cc.p(130,89))
        tableView:setDelegate()
        tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)   -- 上靠
        self:addChild(tableView)
        tableView:registerScriptHandler(cellSizeForTable,cc.TABLECELL_SIZE_FOR_INDEX)   -- 回调绑定
        tableView:registerScriptHandler(tableCellAtIndex,cc.TABLECELL_SIZE_AT_INDEX)
        tableView:registerScriptHandler(numberOfCellsInTableView,cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
        tableView:reloadData()  -- 最后必须有
    end
end


--endregion
