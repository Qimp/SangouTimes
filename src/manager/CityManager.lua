--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.cell.CityData"


CityManager = {}

CityManager.m_cityDataList = {}


-- 增加一个城市
function CityManager:addCity( cityData )
    local cfgId = cityData:getCityCfgId()
    if cfgId ~= 0 then
        self.m_cityDataList[cfgId] = cityData
    end
end
-- 初始化城市
function CityManager:initCity()
    
    for cfgId, cfg in ipairs( CityCfg ) do
        local cityData = CityData.create( cfgId ) -- 创建城市数据
        self:addCity( cityData )
        -- 从文件中读取城市数据
    end

end









--endregion
