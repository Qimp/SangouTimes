--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


-- 常用
gg = {}

gg.midX = 480
gg.midY = 320
gg.midPos = cc.p(gg.midX,gg.midY)

gg.midPoint = cc.p(0.5,0.5)
gg.zeroPoint = cc.p(0,0)

gg.systemFont = ""

gg.color_white = cc.c3b(255,255,255)
gg.color_black = cc.c3b(0,0,0)
-- 状态
StateIndex = {}
StateIndex.Attack = 1
StateIndex.Move = 2
StateIndex.Wait = 3

-- 兵种
ArmyType = {}
ArmyType.QiBing = 1
ArmyType.BuBing = 2

-- 阵型
FormationType = {}
FormationType.SanKai = 1

-- 左右方向
LR = {}
LR.Left = 1
LR.Right = 2


-- 战役消息
MSG_BATTLE = {}
MSG_BATTLE.TOTAL = "msg_battle_total"
MSG_BATTLE.ATTACK_START = 1
MSG_BATTLE.ATTACK_FINISH = 2

-- 常用消息
gmsg = {}
gmsg.MSG_SEASON = "msg_season"

BuildType = {}
BuildType.Smith = 1
BuildType.Prop = 2
BuildType.City = 3
BuildType.Army = 4
BuildType.Food = 5

BuildExpLv = {}
BuildExpLv.Small = 0
BuildExpLv.Mid = 10000
BuildExpLv.Big = 100000
BuildExpLv.Huge = 1000000

CityExpLv = {}
CityExpLv.Small = 0
CityExpLv.Mid = 10000
CityExpLv.Big = 100000
CityExpLv.Huge = 1000000


FuncType = {}
FuncType.Buy = 1                    -- 购买
FuncType.Sell = 2                   -- 卖出
FuncType.Build = 3                  -- 建设
FuncType.Invest = 4                 -- 投资



SeasonType = {}
SeasonType.m_spring = 1             
SeasonType.m_summer = 2
SeasonType.m_autumn = 3
SeasonType.m_winter = 4


--endregion
