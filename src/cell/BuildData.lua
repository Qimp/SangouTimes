--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


require "src.cfg.BuildCfg"

BuildData = class("BuildData")


-- 构造
function BuildData:ctor()
    self.m_cfgId = 0           -- 建筑id
    self.m_cfg = {}            -- 建筑配置
    self.m_city = 0            -- 所在城市

    self.m_exp = 0             -- 经验值
end
-- 创建
function BuildData.create( cityData, cfgId)
    local instance = BuildData.new()
    if instance then
        instance:init(cityData,cfgId)
    end
    return instance
end
-- 初始化
function BuildData:init(cityData,cfgId)
    self.m_city = cityData
    self.m_cfgId = cfgId

    local cfg = BuildCfg[cfgId]
    if not cfg then
        return
    end
    self.m_cfg = cfg
    -- 读取数据

end
-- 是否开放
function BuildData:isOpen()
    local cityData = self.m_city
    local cityExp = cityData["m_exp"] or 0
    local needExp = self.m_cfg ["m_needExp"] or 0
    if cityExp >= needExp then
        return true
    end
    return false
end
-- 增加经验值
function BuildData:addExp( num )
    num = num or 0
    self.m_exp = self.m_exp + num
end
-- 获取经验值
function BuildData:getExp()
    return self.m_exp
end
-- 获取名字
function BuildData:getBuildName()
    local cfg = self.m_cfg 
    return cfg["m_name"]
end
-- 获取配置id
function BuildData:getBuildCfgId()
    return self.m_cfgId
end
-- 获取已经开发的功能列表
function BuildData:getOpenFuncList()
    local exp = self.m_exp
    local cfg = self.m_cfg 
    local totalFuncList = cfg["m_funcList"]
    local funcList = {}
    local needList = {BuildExpLv.Small, BuildExpLv.Mid, BuildExpLv.Big, BuildExpLv.Huge}

    for k, needExp in ipairs(needList) do
        if exp >= needExp then
            local list = totalFuncList[k] or {}
            for k, funcType in ipairs(list) do
                table.insert(funcList, funcType )
            end
        else
            break
        end
    end
    return funcList
end


--endregion
