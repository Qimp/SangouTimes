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

gg.color_withe = cc.c3b(255,255,255)
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


BuildType = {}
BuildType.Smith = 1
BuildType.Prop = 2


BuildExpLv = {}
BuildExpLv.Small = 0
BuildExpLv.Mid = 10000
BuildExpLv.Big = 100000
BuildExpLv.Huge = 1000000



--endregion
