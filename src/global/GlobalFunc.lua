--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.global.Global"

gfun = {}
-- 把索引转换为字符串
function gfun.getAnimationStrByState( index )
    if index == StateIndex.Attack then
        return "m_attack"
    elseif index == StateIndex.Move then
        return "m_move"
    elseif index == StateIndex.Wait then
        return "m_wait"
    end
end
-- 增加子节点
function gfun.addChild( parent, node, pos, anchorPos )
    pos = pos or gg.zeroPoint
    anchorPos = anchorPos or gg.midPoint
    if node==nil then
        return false
    end
    node:setPosition( pos)
    node:setAnchorPoint( anchorPos)
    if parent==nil then
        return false
    end
    parent:addChild( node)
    return true
end
-- 获取节点的中点
function gfun.getNodeMidPos( node )
    if node then
        local size = node:getContentSize()
        local x, y = size.width/2, size.height/2
        return cc.p(x,y), x, y
    end
    return cc.p(0,0), 0, 0
end
-- 创建精灵
function gfun.createSprWithFrameName( node, frameName, pos, anchorPos, scale)
    if frameName == nil or frameName == "" then
        return nil
    end
    local spr = cc.Sprite:createWithSpriteFrameName( frameName)
    if spr then
        gfun.addChild( node, spr, pos, anchorPos)
        if scale then
            spr:setScale(scale)
        end
    end
    return spr
end
-- 创建精灵(用文件)
function gfun.createSprWithFileName( node, fileName, pos, anchorPos, scale)
    if fileName == nil or fileName == "" then
        return nil
    end
    local spr = cc.Sprite:create( fileName)
    if spr then
        gfun.addChild( node, spr, pos, anchorPos)
        if scale then
            spr:setScale(scale)
        end
    end
    return spr
end
-- 创建label
function gfun.CreateLabel( node, str, color, fontName, fontSize, pos, anchorPos)
    local label = nil
    if string.len(fontName)>1 and cc.FileUtils:getInstance():isFileExist(fontName) then
        label = cc.Label:createWithTTF(str,fontName,fontSize)
    else
        label = cc.Label:createWithSystemFont(str," ",fontSize)
    end

    if label then
        label:setColor( color)
        gfun.addChild( node, label, pos, anchorPos)
    end
    return label
end
-- 创建节点
function gfun.createNode( parent, pos, anchorPos)
    local node = cc.Node:create()
    gfun.addChild(parent,node,pos,anchorPos)
    return node
end
-- 创建菜单
function gfun.createMenu( parent, pos )
    pos = pos or gg.zeroPoint
    local menu = cc.Menu:create()
    if menu then
        gfun.addChild( parent, menu, pos, nil )
    end
    return menu
end
-- 创建菜单项
function gfun.createScaleItem( parent, str, fontSize, frame, pos, anchorPos, tag, func )
    str = str or ""
    fontSize = fontSize or 1
    local lab = cc.Label:createWithSystemFont(str," ",fontSize)
    if lab then
        local item = cc.MenuItemLabel:create(lab)
        if item then
            if frame and string.len(frame)>1 then
                local sp = gfun.createSprWithFrameName( nil, frame, gg.zeroPoint, nil, nil)
                if sp then
                    item:setContentSize( sp:getContentSize() )
                    local midP = gfun.getNodeMidPos(item)
                    gfun.addChild( item, sp, midP, nil )
                    lab:setPosition(midP)
                    lab:setAnchorPoint(gg.midPos)
                    lab:setLocalZOrder(1)
                end
            end
            if tag then
                item:setTag(tag)
            end
            if func then
                item:registerScriptTapHandler(func)
            end
            gfun.addChild( parent, item, pos, anchorPos )
        end
        return item
    end
end
-- 创建九宫格
function gfun.createScale9SpriteWithFrameName( parent, frameName, size, pos, anchorPoint )
    if frameName == nil or frameName == "" then
        return 
    end
    local sp = ccui.Scale9Sprite:createWithSpriteFrameName(frameName)
    if sp then
        if size then
            sp:setContentSize(size)
        end
    end
    gfun.addChild(parent, sp , pos, anchorPoint)
    return sp
end
-- 创建九宫格(用文件)
function gfun.createScale9SpriteWithFileName( parent, fileName, size, pos, anchorPoint )
    if fileName == nil or fileName == "" then
        return 
    end
    local sp = ccui.Scale9Sprite:create(fileName)
    if sp then
        if size then
            sp:setContentSize(size)
        end
    end
    gfun.addChild(parent, sp , pos, anchorPoint)
    return sp
end
-- 设置层触摸不穿透
function gfun.setLayerTouchSwallowTrue( layer)
    if not layer then
        return
    end
    -- 触摸不向下传递
    local function onTouchBegan(touch, event)
        return true
    end
    local function onTouchMoved( touch, event)
    end
    local function onTouchEnded( touch, event)
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true) -- 不向下传递
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = layer:getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
end
-- 获取在阵上的位置( 阵上的第几行  第几列  是否在右边)
function gfun.getOnFormationPos( row, col, inLR )
    local startX = 80
    local startY = 480
    local moveX = 50
    local moveY = 100
    local startXR = 880
    if inLR == LR.Left then -- 在左边
        local x = startX + (col-1)*moveX
        local y = startY - (row-1)*moveY
        return cc.p(x,y), x, y
    else
        local x = startXR - (col-1)*moveX
        local y = startY - (row-1)*moveY
        return cc.p(x,y), x, y
    end
end
-- 发送消息
function gfun.sendEvent( sender, whichEvent, cmd, w1, w2, w3)
    local event = cc.EventCustom:new( whichEvent)
    event.__cmd = cmd
    event.__w1 = w1
    event.__w2 = w2
    event.__w3 = w3

    local eventDispatcher = sender:getEventDispatcher()
    eventDispatcher:dispatchEvent(event)
end
--endregion
