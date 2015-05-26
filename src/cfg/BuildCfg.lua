--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


BuildCfg = {

        [1] = {
                m_cfgId = 1,
                m_type = BuildType.Smith,
                m_name = "铁匠铺",
                m_bg = "res/build/Room_12-1.jpg",
                m_exp = 0,
                m_needExp = 0,          -- 开放这个建筑的需求
                m_funcList = { [1] = {FuncType.Buy, FuncType.Sell}, [2] = {3}, [3] = {4}, [4] = {5} },                -- 四个等级对应的开发功能列表
                m_sellList = { [1] = {1,2}, [2] = {3,4,5}, [3] = {6,7}, [4] = {8} }           -- 四个等级对应的开放出售列表
                
        },

        [2] = {
                m_cfgId = 2,
                m_type = BuildType.Prop,
                m_name = "道具店",
                m_bg = "res/build/Room_3-1.jpg",
                m_exp = 0,
                m_needExp = 0,          -- 开放这个建筑的需求
                m_funcList = { [1] = {FuncType.Buy, FuncType.Sell}, [2] = {3}, [3] = {4}, [4] = {5} },                -- 四个等级对应的开发功能列表
                m_sellList = { [1] = {1,2}, [2] = {3,4,5}, [3] = {6,7}, [4] = {8} }           -- 四个等级对应的开放出售列表

        },

        [3] = {
                m_cfgId = 3,
                m_type = BuildType.City,
                m_name = "城府",
                m_bg = "res/build/Room_30-1.jpg",
                m_exp = 0,
                m_needExp = 0,          -- 开放这个建筑的需求
                m_funcList = { [1] = {FuncType.Build}, [2] = {}, [3] = {}, [4] = {} },                -- 四个等级对应的开发功能列表
        },

        [4] = {
                m_cfgId = 4,
                m_type = BuildType.Army,
                m_name = "练兵场",
                m_bg = "res/build/Room_19-1.jpg",
                m_exp = 0,
                m_needExp = 0,          -- 开放这个建筑的需求
                m_funcList = { [1] = {FuncType.Build}, [2] = {}, [3] = {}, [4] = {} },                -- 四个等级对应的开发功能列表
        },

        [5] = {
                m_cfgId = 5,
                m_type = BuildType.Food,
                m_name = "军粮仓",
                m_bg = "res/build/Room_1-1.jpg",
                m_exp = 0,
                m_needExp = 0,          -- 开放这个建筑的需求
                m_funcList = { [1] = {FuncType.Build}, [2] = {}, [3] = {}, [4] = {} },                -- 四个等级对应的开发功能列表
        },

}





--endregion
