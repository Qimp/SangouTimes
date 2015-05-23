--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.cfg.CityCfg"
require "src.cell.BuildData"



CityData = class("CityData")


-- 构造
function CityData:ctor()
    self.m_cfgId = 0           -- 城市配置id
    self.m_cfg = {}            -- 城市配置

    self.m_exp = 0             -- 城市的发展值

    self.m_buildDataList = {}  -- 建筑物列表
end
-- 创建
function CityData.create(cfgId)
    local instance = CityData.new()
    if instance then
        instance:init(cfgId)
    end
    return instance
end
-- 初始化
function CityData:init(cfgId)
    self.m_cfgId = cfgId

    local cfg = CityCfg[cfgId]
    if not cfg then
        return
    end
    self.m_cfg = cfg
    -- 读取数据

    -- 创建建筑
    for k, cfgId in ipairs( cfg["m_bulid"] ) do
        local data = BuildData.create( self, cfgId)
        if data then
            table.insert( self.m_buildDataList, data )
        end
    end
end
-- 获取城市名字
function CityData:getCityCfg()
    return self.m_cfg
end
-- 获取城市配置id
function CityData:getCityCfgId()
    return self.m_cfgId
end
-- 获取城市的建筑列表
function CityData:getBuildList()
    return self.m_buildDataList
end
-- 增加经验值
function CityData:addExp( num )
    num = num or 0
    self.m_exp = self.m_exp + num
end

--endregion
