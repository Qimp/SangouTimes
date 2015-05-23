--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "src.cfg.HeroCfg"
require "src.cfg.ArmyTypeCfg"


HeroData = class("HeroData")

-- 构造
function HeroData:ctor()
    -- 配置共有
    self.m_cfgId = 0            -- 配置id
    self.m_name = ""
    self.m_lv = 1
    self.m_exp = 0
    self.m_attack_base = 0   -- 攻击
    self.m_intell_base = 0   -- 智力
    self.m_speedAtk_base = 0 -- 1秒攻击一次
    self.m_speedMov_base = 0 -- 移动速度
    self.m_attack_add = 0    -- 升级攻击成长
    self.m_intell_add = 0    -- 升级智力成长
    self.m_speedAtk_add = 0  -- 攻击速度成长
    self.m_speedMov_add = 0  -- 移动速度成长
    self.m_armyList = {}     -- key 是兵种配置id  value为兵种经验

    -- 私有
    self.m_soldierNum = 9000                    -- 士兵数量
    self.m_curArmyId = ArmyType.QiBing          -- 当前兵种
    self.m_formationRow = 0                     -- 在阵上第几行
end
-- 创建
function HeroData.create( cfgId )
    local instance = HeroData.new()
    if instance then
        instance:init(cfgId)
    end
    return instance
end
-- 初始化
function HeroData:init(cfgId)
    self.m_cfgId = cfgId
    local cfg = HeroCfg[cfgId]
    if cfg then
        -- 复制一份配置里面的
        for key, data in pairs(cfg) do
            if type(data) == "table" then
                self[key] = clone(data)
            else
                self[key] = data
            end
        end
    end
end
-- 获取士兵数量
function HeroData:getSoldierNum()
    return self.m_soldierNum
end
-- 增加士兵数量
function HeroData:addSoldierNum( num )
    self["m_soldierNum"] = self["m_soldierNum"]  + num
end
-- 减少士兵数量
function HeroData:delSoldierNum( num )
    self["m_soldierNum"] = self["m_soldierNum"]  - num
end
-- 获取移动距离
function HeroData:getMoveSpeed()
    local base = self.m_speedMov_base
    local armyTypeCfg = ArmyTypeCfg[ self.m_curArmyId ] or {}
    local armyMove = armyTypeCfg["m_speedMov_base"] or 0
    local addTimes = armyTypeCfg["m_speedMov_add"] or 0

    return base*addTimes + armyMove
end
-- 获取攻击距离
function HeroData:getAttackRange()
    local armyTypeCfg = ArmyTypeCfg[ self.m_curArmyId ] or {}
    return armyTypeCfg["m_range"] or 0
end
-- 获取攻击力
function HeroData:getAttack()
    local base = self.m_attack_base
    local armyTypeCfg = ArmyTypeCfg[ self.m_curArmyId ] or {}

    local armyAtk = armyTypeCfg["m_attack_base"] or 0
    local addTimes = armyTypeCfg["m_attack_add"] or 0

    return base*addTimes + armyAtk
end
-- 更新属性












--endregion
