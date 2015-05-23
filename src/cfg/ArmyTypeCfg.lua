--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

-- 兵种配置

require "src.global.Global"

ArmyTypeCfg = {

    [ArmyType.QiBing] = {   m_cfgId = ArmyType.QiBing,
                            m_aniCfgId = 10001,
                            m_name = "qibing",
                            m_halfWidth = 30,   -- 偏移量  一般是图片的一半
                            m_attack_base = 100, -- 攻击
                            m_speedAtk_base = 200, -- 2秒攻击一次
                            m_speedMov_base = 1, -- 移动速度

                            m_attack_add = 0.5, -- 攻击加成
                            m_intell_add = 0.1, -- 智力加成
                            m_speedAtk_add = 0.1,  -- 攻击速度加成
                            m_speedMov_add = 0.01,  -- 移动速度加成

                            m_range = 10,       -- 攻击距离
                            m_levelExp = 1000   -- 转职需要经验
    }



}






--endregion
