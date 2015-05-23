--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



CacheManager = {}

CacheManager.m_animationList = {}
CacheManager.m_plistList = {}

-- 创建动画
function CacheManager:createAnimation( aniName, frames, time )
    local animation = cc.Animation:createWithSpriteFrames( frames, time )
    self:addAnimamtion( animation, aniName )
    return animation
end
-- 加入动画
function CacheManager:addAnimamtion( animation, aniName )
    local originNum = self.m_animationList[aniName] or 0
    if animation then
        cc.AnimationCache:getInstance():addAnimation(animation,aniName)
        self.m_animationList[aniName] = originNum + 1
    end
end
-- 删除动画
function CacheManager:removeAnimation( aniName )
    local originNum = self.m_animationList[aniName] or 0
    if originNum > 0 then
        originNum = originNum - 1
        if originNum == 0 then
            self.m_animationList[aniName]  = 0
            cc.AnimationCache:getInstance():removeAnimation(aniName)
        end
    end
end
-- 加入plist
function CacheManager:addPlist( plistFile, pngFile  )
    local originNum = self.m_plistList[plistFile] or 0
    if originNum > 0 then
        originNum = originNum + 1
        self.m_plistList[plistFile] = originNum
    else
        cc.SpriteFrameCache:getInstance():addSpriteFrames( plistFile, pngFile )
        self.m_plistList[plistFile] = 1
    end
end
-- 删除plist
function CacheManager:removePlist( plistFile, pngFile )
    local originNum = self.m_plistList[plistFile] or 0
    if originNum > 0 then
        originNum = originNum - 1
        if originNum == 0 then
            cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile( plistFile )
            cc.Director:getInstance():getTextureCache():removeTextureForKey( pngFile )
            self.m_plistList[plistFile] = originNum
        end
    end
end









--endregion
