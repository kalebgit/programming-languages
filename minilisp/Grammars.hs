{-# OPTIONS_GHC -w #-}
module Grammars where
import Lex (Token(..), lexer)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,216) ([3072,0,8705,512,0,0,0,0,0,0,0,0,0,0,0,65504,61439,469,48,1024,152,0,0,0,0,0,1,0,0,2,0,0,32768,1,24608,49156,0,8208,24578,0,4104,12289,0,34820,6144,0,17410,3072,0,8705,1536,32768,4352,768,16384,2176,384,8192,1088,192,4096,544,96,2048,272,48,1024,136,24,512,68,12,256,34,6,128,17,3,32832,32776,1,16416,49156,0,8208,24578,0,4104,12289,0,34820,6144,0,17410,0,0,1,0,32768,0,0,16384,0,0,0,64,0,4096,0,96,2048,272,48,1024,136,0,1024,0,0,512,0,0,0,16,0,32768,0,0,2048,49152,0,8208,2,0,8,1,0,32772,0,0,16386,3072,0,8705,0,0,1,768,16384,2176,0,16384,0,0,8192,0,0,4096,0,0,2048,0,0,1024,0,0,512,0,0,256,0,0,128,0,0,64,49152,0,8208,2,0,16,0,0,8,0,0,4,0,0,2,0,0,1,0,32768,0,0,16384,0,192,4096,544,0,4096,0,48,1024,136,0,0,0,12,256,34,0,0,0,0,128,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3072,0,8705,0,0,1,0,0,2048,384,8192,1088,0,8192,0,0,4096,0,48,1024,136,24,512,68,0,0,0,0,256,0,0,0,8,0,0,0,0,0,0,0,0,12288,0,34820,0,0,4,0,0,1024,1536,32768,4352,768,16384,2176,0,0,0,192,4096,544,96,2048,272,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,32,0,0,16,0,0,8,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,2048,256,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","ASA","Listitems","ASAExprs","ASABindings","ASAC","ASACond","ListVar","int","bool","'++'","'+'","'-'","'*'","'/'","'add1'","'sub1'","'sqrt'","'expt'","'fst'","'snd'","'='","'<'","'>'","'<='","'>='","'!='","'and'","'not'","'if'","'('","')'","'let'","'let*'","'letrec'","\"cond\"","\"else\"","\"lambda\"","','","'['","']'","'head'","'tail'","var","%eof"]
        bit_start = st Prelude.* 47
        bit_end = (st Prelude.+ 1) Prelude.* 47
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..46]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (11) = happyShift action_2
action_0 (12) = happyShift action_4
action_0 (33) = happyShift action_5
action_0 (42) = happyShift action_6
action_0 (46) = happyShift action_7
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (11) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (47) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (11) = happyShift action_2
action_5 (12) = happyShift action_4
action_5 (13) = happyShift action_12
action_5 (14) = happyShift action_13
action_5 (15) = happyShift action_14
action_5 (16) = happyShift action_15
action_5 (17) = happyShift action_16
action_5 (18) = happyShift action_17
action_5 (19) = happyShift action_18
action_5 (20) = happyShift action_19
action_5 (21) = happyShift action_20
action_5 (22) = happyShift action_21
action_5 (23) = happyShift action_22
action_5 (24) = happyShift action_23
action_5 (25) = happyShift action_24
action_5 (26) = happyShift action_25
action_5 (27) = happyShift action_26
action_5 (28) = happyShift action_27
action_5 (29) = happyShift action_28
action_5 (30) = happyShift action_29
action_5 (31) = happyShift action_30
action_5 (32) = happyShift action_31
action_5 (33) = happyShift action_5
action_5 (35) = happyShift action_32
action_5 (36) = happyShift action_33
action_5 (37) = happyShift action_34
action_5 (38) = happyShift action_35
action_5 (40) = happyShift action_36
action_5 (42) = happyShift action_6
action_5 (44) = happyShift action_37
action_5 (45) = happyShift action_38
action_5 (46) = happyShift action_7
action_5 (4) = happyGoto action_11
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (11) = happyShift action_2
action_6 (12) = happyShift action_4
action_6 (33) = happyShift action_5
action_6 (42) = happyShift action_6
action_6 (43) = happyShift action_10
action_6 (46) = happyShift action_7
action_6 (4) = happyGoto action_8
action_6 (5) = happyGoto action_9
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_3

action_8 (41) = happyShift action_72
action_8 _ = happyReduce_35

action_9 (43) = happyShift action_71
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_33

action_11 (11) = happyShift action_2
action_11 (12) = happyShift action_4
action_11 (33) = happyShift action_5
action_11 (41) = happyShift action_70
action_11 (42) = happyShift action_6
action_11 (46) = happyShift action_7
action_11 (4) = happyGoto action_50
action_11 (6) = happyGoto action_69
action_11 _ = happyReduce_37

action_12 (11) = happyShift action_2
action_12 (12) = happyShift action_4
action_12 (33) = happyShift action_5
action_12 (42) = happyShift action_6
action_12 (46) = happyShift action_7
action_12 (4) = happyGoto action_68
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (11) = happyShift action_2
action_13 (12) = happyShift action_4
action_13 (33) = happyShift action_5
action_13 (42) = happyShift action_6
action_13 (46) = happyShift action_7
action_13 (4) = happyGoto action_50
action_13 (6) = happyGoto action_67
action_13 _ = happyReduce_37

action_14 (11) = happyShift action_2
action_14 (12) = happyShift action_4
action_14 (33) = happyShift action_5
action_14 (42) = happyShift action_6
action_14 (46) = happyShift action_7
action_14 (4) = happyGoto action_50
action_14 (6) = happyGoto action_66
action_14 _ = happyReduce_37

action_15 (11) = happyShift action_2
action_15 (12) = happyShift action_4
action_15 (33) = happyShift action_5
action_15 (42) = happyShift action_6
action_15 (46) = happyShift action_7
action_15 (4) = happyGoto action_50
action_15 (6) = happyGoto action_65
action_15 _ = happyReduce_37

action_16 (11) = happyShift action_2
action_16 (12) = happyShift action_4
action_16 (33) = happyShift action_5
action_16 (42) = happyShift action_6
action_16 (46) = happyShift action_7
action_16 (4) = happyGoto action_50
action_16 (6) = happyGoto action_64
action_16 _ = happyReduce_37

action_17 (11) = happyShift action_2
action_17 (12) = happyShift action_4
action_17 (33) = happyShift action_5
action_17 (42) = happyShift action_6
action_17 (46) = happyShift action_7
action_17 (4) = happyGoto action_50
action_17 (6) = happyGoto action_63
action_17 _ = happyReduce_37

action_18 (11) = happyShift action_2
action_18 (12) = happyShift action_4
action_18 (33) = happyShift action_5
action_18 (42) = happyShift action_6
action_18 (46) = happyShift action_7
action_18 (4) = happyGoto action_50
action_18 (6) = happyGoto action_62
action_18 _ = happyReduce_37

action_19 (11) = happyShift action_2
action_19 (12) = happyShift action_4
action_19 (33) = happyShift action_5
action_19 (42) = happyShift action_6
action_19 (46) = happyShift action_7
action_19 (4) = happyGoto action_50
action_19 (6) = happyGoto action_61
action_19 _ = happyReduce_37

action_20 (11) = happyShift action_2
action_20 (12) = happyShift action_4
action_20 (33) = happyShift action_5
action_20 (42) = happyShift action_6
action_20 (46) = happyShift action_7
action_20 (4) = happyGoto action_60
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (11) = happyShift action_2
action_21 (12) = happyShift action_4
action_21 (33) = happyShift action_5
action_21 (42) = happyShift action_6
action_21 (46) = happyShift action_7
action_21 (4) = happyGoto action_59
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (11) = happyShift action_2
action_22 (12) = happyShift action_4
action_22 (33) = happyShift action_5
action_22 (42) = happyShift action_6
action_22 (46) = happyShift action_7
action_22 (4) = happyGoto action_58
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (11) = happyShift action_2
action_23 (12) = happyShift action_4
action_23 (33) = happyShift action_5
action_23 (42) = happyShift action_6
action_23 (46) = happyShift action_7
action_23 (4) = happyGoto action_50
action_23 (6) = happyGoto action_57
action_23 _ = happyReduce_37

action_24 (11) = happyShift action_2
action_24 (12) = happyShift action_4
action_24 (33) = happyShift action_5
action_24 (42) = happyShift action_6
action_24 (46) = happyShift action_7
action_24 (4) = happyGoto action_50
action_24 (6) = happyGoto action_56
action_24 _ = happyReduce_37

action_25 (11) = happyShift action_2
action_25 (12) = happyShift action_4
action_25 (33) = happyShift action_5
action_25 (42) = happyShift action_6
action_25 (46) = happyShift action_7
action_25 (4) = happyGoto action_50
action_25 (6) = happyGoto action_55
action_25 _ = happyReduce_37

action_26 (11) = happyShift action_2
action_26 (12) = happyShift action_4
action_26 (33) = happyShift action_5
action_26 (42) = happyShift action_6
action_26 (46) = happyShift action_7
action_26 (4) = happyGoto action_50
action_26 (6) = happyGoto action_54
action_26 _ = happyReduce_37

action_27 (11) = happyShift action_2
action_27 (12) = happyShift action_4
action_27 (33) = happyShift action_5
action_27 (42) = happyShift action_6
action_27 (46) = happyShift action_7
action_27 (4) = happyGoto action_50
action_27 (6) = happyGoto action_53
action_27 _ = happyReduce_37

action_28 (11) = happyShift action_2
action_28 (12) = happyShift action_4
action_28 (33) = happyShift action_5
action_28 (42) = happyShift action_6
action_28 (46) = happyShift action_7
action_28 (4) = happyGoto action_50
action_28 (6) = happyGoto action_52
action_28 _ = happyReduce_37

action_29 (11) = happyShift action_2
action_29 (12) = happyShift action_4
action_29 (33) = happyShift action_5
action_29 (42) = happyShift action_6
action_29 (46) = happyShift action_7
action_29 (4) = happyGoto action_50
action_29 (6) = happyGoto action_51
action_29 _ = happyReduce_37

action_30 (11) = happyShift action_2
action_30 (12) = happyShift action_4
action_30 (33) = happyShift action_5
action_30 (42) = happyShift action_6
action_30 (46) = happyShift action_7
action_30 (4) = happyGoto action_49
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (11) = happyShift action_2
action_31 (12) = happyShift action_4
action_31 (33) = happyShift action_5
action_31 (42) = happyShift action_6
action_31 (46) = happyShift action_7
action_31 (4) = happyGoto action_48
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (33) = happyShift action_47
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (33) = happyShift action_46
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (33) = happyShift action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (42) = happyShift action_44
action_35 (8) = happyGoto action_42
action_35 (9) = happyGoto action_43
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (33) = happyShift action_41
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (11) = happyShift action_2
action_37 (12) = happyShift action_4
action_37 (33) = happyShift action_5
action_37 (42) = happyShift action_6
action_37 (46) = happyShift action_7
action_37 (4) = happyGoto action_40
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (11) = happyShift action_2
action_38 (12) = happyShift action_4
action_38 (33) = happyShift action_5
action_38 (42) = happyShift action_6
action_38 (46) = happyShift action_7
action_38 (4) = happyGoto action_39
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (34) = happyShift action_108
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (34) = happyShift action_107
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (46) = happyShift action_106
action_41 (10) = happyGoto action_105
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (42) = happyShift action_44
action_42 (8) = happyGoto action_42
action_42 (9) = happyGoto action_104
action_42 _ = happyReduce_43

action_43 (39) = happyShift action_103
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (11) = happyShift action_2
action_44 (12) = happyShift action_4
action_44 (33) = happyShift action_5
action_44 (42) = happyShift action_6
action_44 (46) = happyShift action_7
action_44 (4) = happyGoto action_102
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (33) = happyShift action_98
action_45 (46) = happyShift action_99
action_45 (7) = happyGoto action_101
action_45 _ = happyReduce_39

action_46 (33) = happyShift action_98
action_46 (46) = happyShift action_99
action_46 (7) = happyGoto action_100
action_46 _ = happyReduce_39

action_47 (33) = happyShift action_98
action_47 (46) = happyShift action_99
action_47 (7) = happyGoto action_97
action_47 _ = happyReduce_39

action_48 (11) = happyShift action_2
action_48 (12) = happyShift action_4
action_48 (33) = happyShift action_5
action_48 (42) = happyShift action_6
action_48 (46) = happyShift action_7
action_48 (4) = happyGoto action_96
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (34) = happyShift action_95
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (11) = happyShift action_2
action_50 (12) = happyShift action_4
action_50 (33) = happyShift action_5
action_50 (42) = happyShift action_6
action_50 (46) = happyShift action_7
action_50 (4) = happyGoto action_50
action_50 (6) = happyGoto action_94
action_50 _ = happyReduce_37

action_51 (34) = happyShift action_93
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (34) = happyShift action_92
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (34) = happyShift action_91
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (34) = happyShift action_90
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (34) = happyShift action_89
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (34) = happyShift action_88
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (34) = happyShift action_87
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (34) = happyShift action_86
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (34) = happyShift action_85
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (11) = happyShift action_2
action_60 (12) = happyShift action_4
action_60 (33) = happyShift action_5
action_60 (42) = happyShift action_6
action_60 (46) = happyShift action_7
action_60 (4) = happyGoto action_50
action_60 (6) = happyGoto action_84
action_60 _ = happyReduce_37

action_61 (34) = happyShift action_83
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (34) = happyShift action_82
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (34) = happyShift action_81
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (34) = happyShift action_80
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (34) = happyShift action_79
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (34) = happyShift action_78
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (34) = happyShift action_77
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (11) = happyShift action_2
action_68 (12) = happyShift action_4
action_68 (33) = happyShift action_5
action_68 (42) = happyShift action_6
action_68 (46) = happyShift action_7
action_68 (4) = happyGoto action_76
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (34) = happyShift action_75
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (11) = happyShift action_2
action_70 (12) = happyShift action_4
action_70 (33) = happyShift action_5
action_70 (42) = happyShift action_6
action_70 (46) = happyShift action_7
action_70 (4) = happyGoto action_74
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_34

action_72 (11) = happyShift action_2
action_72 (12) = happyShift action_4
action_72 (33) = happyShift action_5
action_72 (42) = happyShift action_6
action_72 (46) = happyShift action_7
action_72 (4) = happyGoto action_8
action_72 (5) = happyGoto action_73
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_36

action_74 (34) = happyShift action_121
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_29

action_76 (34) = happyShift action_120
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_4

action_78 _ = happyReduce_5

action_79 _ = happyReduce_6

action_80 _ = happyReduce_7

action_81 _ = happyReduce_8

action_82 _ = happyReduce_9

action_83 _ = happyReduce_10

action_84 (34) = happyShift action_119
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_13

action_86 _ = happyReduce_14

action_87 _ = happyReduce_15

action_88 _ = happyReduce_16

action_89 _ = happyReduce_17

action_90 _ = happyReduce_18

action_91 _ = happyReduce_19

action_92 _ = happyReduce_20

action_93 _ = happyReduce_21

action_94 _ = happyReduce_38

action_95 _ = happyReduce_22

action_96 (11) = happyShift action_2
action_96 (12) = happyShift action_4
action_96 (33) = happyShift action_5
action_96 (42) = happyShift action_6
action_96 (46) = happyShift action_7
action_96 (4) = happyGoto action_118
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (34) = happyShift action_117
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (46) = happyShift action_116
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (11) = happyShift action_2
action_99 (12) = happyShift action_4
action_99 (33) = happyShift action_5
action_99 (42) = happyShift action_6
action_99 (46) = happyShift action_7
action_99 (4) = happyGoto action_115
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (34) = happyShift action_114
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (34) = happyShift action_113
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (11) = happyShift action_2
action_102 (12) = happyShift action_4
action_102 (33) = happyShift action_5
action_102 (42) = happyShift action_6
action_102 (46) = happyShift action_7
action_102 (4) = happyGoto action_112
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (11) = happyShift action_2
action_103 (12) = happyShift action_4
action_103 (33) = happyShift action_5
action_103 (42) = happyShift action_6
action_103 (46) = happyShift action_7
action_103 (4) = happyGoto action_111
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_44

action_105 (34) = happyShift action_110
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (46) = happyShift action_106
action_106 (10) = happyGoto action_109
action_106 _ = happyReduce_46

action_107 _ = happyReduce_31

action_108 _ = happyReduce_32

action_109 _ = happyReduce_45

action_110 (11) = happyShift action_2
action_110 (12) = happyShift action_4
action_110 (33) = happyShift action_5
action_110 (42) = happyShift action_6
action_110 (46) = happyShift action_7
action_110 (4) = happyGoto action_129
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (34) = happyShift action_128
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (43) = happyShift action_127
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (11) = happyShift action_2
action_113 (12) = happyShift action_4
action_113 (33) = happyShift action_5
action_113 (42) = happyShift action_6
action_113 (46) = happyShift action_7
action_113 (4) = happyGoto action_126
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (11) = happyShift action_2
action_114 (12) = happyShift action_4
action_114 (33) = happyShift action_5
action_114 (42) = happyShift action_6
action_114 (46) = happyShift action_7
action_114 (4) = happyGoto action_125
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_41

action_116 (11) = happyShift action_2
action_116 (12) = happyShift action_4
action_116 (33) = happyShift action_5
action_116 (42) = happyShift action_6
action_116 (46) = happyShift action_7
action_116 (4) = happyGoto action_124
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (11) = happyShift action_2
action_117 (12) = happyShift action_4
action_117 (33) = happyShift action_5
action_117 (42) = happyShift action_6
action_117 (46) = happyShift action_7
action_117 (4) = happyGoto action_123
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (34) = happyShift action_122
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_11

action_120 _ = happyReduce_30

action_121 _ = happyReduce_12

action_122 _ = happyReduce_23

action_123 (34) = happyShift action_134
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (34) = happyShift action_133
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (34) = happyShift action_132
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (34) = happyShift action_131
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_42

action_128 _ = happyReduce_27

action_129 (34) = happyShift action_130
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_28

action_131 _ = happyReduce_26

action_132 _ = happyReduce_25

action_133 (33) = happyShift action_98
action_133 (46) = happyShift action_99
action_133 (7) = happyGoto action_135
action_133 _ = happyReduce_39

action_134 _ = happyReduce_24

action_135 _ = happyReduce_40

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (TokenNum happy_var_1))
	 =  HappyAbsSyn4
		 (Num happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyTerminal (TokenBool happy_var_1))
	 =  HappyAbsSyn4
		 (Boolean happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn4
		 (Var happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happyReduce 4 4 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Add happy_var_3
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 4 4 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Sub happy_var_3
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 4 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Mult happy_var_3
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 4 4 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Div happy_var_3
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 4 4 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Add1 happy_var_3
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 4 4 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Sub1 happy_var_3
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 4 4 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Sqrt happy_var_3
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 5 4 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Expt happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 4 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Pair happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 4 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Fst happy_var_3
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 4 4 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Snd happy_var_3
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 4 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Eq happy_var_3
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 4 4 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Lt happy_var_3
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 4 4 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Gt happy_var_3
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 4 4 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Leq happy_var_3
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 4 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Geq happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 4 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Neq happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 4 4 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (And happy_var_3
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 4 4 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Not happy_var_3
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 6 4 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 7 4 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Let happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 7 4 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LetStar happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 7 4 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LetRec happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 6 4 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (CondElse happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 7 4 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Lambda happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 4 4 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (App happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 5 4 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Conc happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 4 4 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Head happy_var_3
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 4 4 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Tail happy_var_3
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_2  4 happyReduction_33
happyReduction_33 _
	_
	 =  HappyAbsSyn4
		 (List []
	)

happyReduce_34 = happySpecReduce_3  4 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (List happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  5 happyReduction_35
happyReduction_35 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  5 happyReduction_36
happyReduction_36 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_0  6 happyReduction_37
happyReduction_37  =  HappyAbsSyn6
		 ([]
	)

happyReduce_38 = happySpecReduce_2  6 happyReduction_38
happyReduction_38 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  7 happyReduction_39
happyReduction_39  =  HappyAbsSyn7
		 ([]
	)

happyReduce_40 = happyReduce 5 7 happyReduction_40
happyReduction_40 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 ((happy_var_2 , happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_41 = happySpecReduce_2  7 happyReduction_41
happyReduction_41 (HappyAbsSyn4  happy_var_2)
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn7
		 ([(happy_var_1, happy_var_2)]
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 4 8 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ((happy_var_2, happy_var_3)
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  9 happyReduction_43
happyReduction_43 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  9 happyReduction_44
happyReduction_44 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  10 happyReduction_45
happyReduction_45 (HappyAbsSyn10  happy_var_2)
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  10 happyReduction_46
happyReduction_46 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_46 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 47 47 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenNum happy_dollar_dollar -> cont 11;
	TokenBool happy_dollar_dollar -> cont 12;
	TokenConc -> cont 13;
	TokenSum -> cont 14;
	TokenSub -> cont 15;
	TokenMult -> cont 16;
	TokenDiv -> cont 17;
	TokenAdd1 -> cont 18;
	TokenSub1 -> cont 19;
	TokenSqrt -> cont 20;
	TokenExpt -> cont 21;
	TokenFst -> cont 22;
	TokenSnd -> cont 23;
	TokenEq -> cont 24;
	TokenLt -> cont 25;
	TokenGt -> cont 26;
	TokenLeq -> cont 27;
	TokenGeq -> cont 28;
	TokenNeq -> cont 29;
	TokenAnd -> cont 30;
	TokenNot -> cont 31;
	TokenIf -> cont 32;
	TokenPA -> cont 33;
	TokenPC -> cont 34;
	TokenLet -> cont 35;
	TokenLetStar -> cont 36;
	TokenLetRec -> cont 37;
	TokenCond -> cont 38;
	TokenElse -> cont 39;
	TokenLambda -> cont 40;
	TokenComma -> cont 41;
	TokenCA -> cont 42;
	TokenCC -> cont 43;
	TokenHead -> cont 44;
	TokenTail -> cont 45;
	TokenVar happy_dollar_dollar -> cont 46;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 47 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parser tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"

data ASA 
    = Num Int
    | Boolean Bool
    -- ==================
    -- aritmeticos
    -- ==================
    | Add [ASA]
    | Sub [ASA]
    | Mult [ASA]
    | Div [ASA]
    | Add1 [ASA]
    | Sub1 [ASA]
    | Sqrt [ASA]
    | Expt ASA [ASA]
    -- ==================
    -- pares ordenados
    -- ==================
    | Pair ASA ASA
    | Fst ASA
    | Snd ASA
    -- ==================
    -- comparadores 
    --  ponemos que significa cada uno para que no haya confusiones
    -- ==================
    | Eq [ASA]   -- =
    | Lt [ASA]   -- 
    | Gt [ASA]   -- >
    | Leq [ASA]  -- <=
    | Geq [ASA]  -- >=
    | Neq [ASA]  -- !=

    -- ==================
    -- logicos
    -- ==================
    | And [ASA] -- es el and de todos los de la lista por ejemplo AND [True, False, True] ->  False
    | Not ASA
    | If ASA ASA ASA



    --cosas con let
    | Let [(String, ASA)] ASA 
    | LetStar [(String, ASA)] ASA
    | LetRec [(String, ASA)] ASA  
    | Var String
    -- cond
    | CondElse [(ASA, ASA)] ASA  
    -- app y lambda
    | Lambda [String] ASA   
    | App ASA [ASA]   

    -- ==================
    -- listas
    -- ==================
    | Conc ASA ASA
    | List [ASA]
    | Tail ASA
    | Head ASA
    deriving (Show)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
