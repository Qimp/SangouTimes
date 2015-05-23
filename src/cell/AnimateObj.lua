--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.cfg.AnimateCfg"
require "src.manager.CacheManager"

-- 创建帧动画
local function createAnimate( animationName, aniData )
    if aniData then
        local animation = cc.AnimationCache:getInstance():getAnimation( animationName )
        if not animation then
            local framesNum = aniData[1]        -- 帧数量
            local framesTime = aniData[2]       -- 帧间隔
            local framesList = {}
            for k = 1, framesNum do
                local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame( string.format("%s_%d.png", animationName,k) )
                table.insert( framesList, frame)
            end
            animation = CacheManager:createAnimation( animationName, framesList, framesTime )
        end
        if animation then
            return cc.Animate:create( animation )
        end 
    end
end

local s_animationTag = 1001             -- 动画标记


AnimateObj = class("AnimateObj", function()
    return cc.Sprite:create()
end)

AnimateObj.m_cfgId = {}             -- 配置id
AnimateObj.m_cfg = {}               -- 配置

AnimateObj.m_isDone = true          -- 动画是否完成
AnimateObj.m_runningAniIndex = 0    -- 正在播放的动画索引


function AnimateObj:ctor()
    self.m_cfgId = {}       -- 配置id
    self.m_cfg = {}         -- 配置
    self.m_isDone = true          -- 动画是否完成
    self.m_runningAniIndex = 0    -- 正在播放的动画索引
end

function AnimateObj.create( cfgId )
    local instance = AnimateObj.new()
    instance:init(cfgId)
    return instance
end
-- 初始化
function AnimateObj:init( cfgId )
    self.m_cfgId = cfgId
    local cfg = AnimateCfg[cfgId]
    if not cfg then
        return
    end
    self.m_cfg = cfg
    -- 加载plist
    CacheManager:addPlist( cfg["m_plistPath"], cfg["m_pngPath"]  )
    --cc.SpriteFrameCache:getInstance():addSpriteFrames( cfg["m_plistPath"] )
end
-- 获取播放状态
function AnimateObj:getPlayState()
    return self.m_isDone
end
-- 播放动作
function AnimateObj:playAnimation( aniStr, speedTimes, finishCallFunc )
    local animationName = string.format( "%s_%d", aniStr, self.m_cfgId )   -- m_attack_10001 动画名
    local aniDataList = self.m_cfg["m_action"]
    local aniData = aniDataList[aniStr]

    local animate = createAnimate(animationName, aniData)
    if animate then
        local action = animate
        -- 完成回调
        if finishCallFunc then
            action = cc.Sequence:create( action, cc.CallFunc:create(finishCallFunc) )
        end
        -- 速度
        if speedTimes and speedTimes ~= 1 then
            action = cc.Speed:create( action , speedTimes)
        end
        if action then
            local oldAction = self:getActionByTag(s_animationTag)
            if oldAction then
                self:stopAction(oldAction)
            end
            action:setTag(s_animationTag)
            self:runAction( action )
        end
    end
end
-- 播放入口
function AnimateObj:playAnimationEntry( index, speedTimes, startFunc,  callFunc )
    local curIndex = self.m_runningAniIndex

    if index == curIndex and self.m_isDone == false then
        return
    else
        if startFunc then
            startFunc()
        end
        local aniStr = gfun.getAnimationStrByState( index )
        if aniStr then
            self.m_isDone = false
            self.m_runningAniIndex = index
            self:playAnimation( aniStr, speedTimes, function()
                self.m_isDone = true
                if callFunc then
                    callFunc()
                end
            end )
        end
    end
end












--endregion
