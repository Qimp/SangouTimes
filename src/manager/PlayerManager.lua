--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

PlayerManager = {}



PlayerManager.m_gold = 0                -- 金钱
PlayerManager.m_food = 0                -- 军粮

PlayerManager.m_team = {}               -- 队伍
PlayerManager.m_heroList = {}           -- 拥有的英雄


function PlayerManager:addGold( num )
    num = num or 0
    self.m_gold = self.m_gold + num
end
function PlayerManager:delGold( num )
    num = num or 0
    self.m_gold = self.m_gold - num
end

function PlayerManager:addFood( num )
    num = num or 0
    self.m_food = self.m_food + num
end
function PlayerManager:delFood( num )
    num = num or 0
    self.m_food = self.m_food - num
end







--endregion
