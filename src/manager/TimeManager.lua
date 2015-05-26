--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


local s_maxSeasonTime = 300
local s_strSeason = {"春","夏","秋","冬"}

local s_runTime = 5

TimeManager = {}

TimeManager.m_node = nil

TimeManager.m_curSeason = SeasonType.m_spring
TimeManager.m_curTime = 0
-- 读取数据
function TimeManager:loadData()

end
-- 初始化
function TimeManager:init( parent )
    local node = cc.Node:create()
    schedule(node, function()
        self.m_curTime = self.m_curTime + s_runTime
        if self.m_curTime >= s_maxSeasonTime then
            self.m_curSeason = self.m_curSeason + 1
            self.m_curTime = 0
            if self.m_curSeason > SeasonType.m_winter then
                self.m_curSeason = SeasonType.m_spring
            end
        end
        gfun.sendEvent(node,gmsg.MSG_SEASON)
    end, s_runTime)
    gfun.addChild(parent,node)
end
-- 获得当前季节字符串
function TimeManager:getSeasonStr()
    return s_strSeason[self.m_curSeason]     
end














--endregion
