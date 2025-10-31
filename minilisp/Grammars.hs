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
happyExpList = Happy_Data_Array.listArray (0,214) ([3072,32768,16640,1024,0,0,0,0,0,0,0,0,0,0,0,64512,65535,19806,3072,32768,17152,0,0,0,0,0,128,0,0,512,0,0,0,3072,32768,16768,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,3072,32768,16640,0,32768,0,0,32768,0,0,32768,0,0,0,256,0,32768,0,3072,32768,16640,3072,32768,16640,0,0,1,0,0,1,0,0,16384,0,0,256,0,0,32,3072,32768,16640,0,32768,16384,0,32768,16384,0,32768,16384,3072,32768,16640,0,0,1,3072,32768,16640,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,3072,32768,16640,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,3072,32768,16640,0,0,0,3072,32768,16640,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3072,32768,16640,0,0,1,0,0,16384,3072,32768,16640,0,0,1,0,0,1,3072,32768,16640,3072,32768,16640,0,0,0,0,0,1,0,0,16384,0,0,0,0,0,0,0,0,0,3072,32768,16640,0,0,1,0,0,512,3072,32768,16640,3072,32768,16640,0,0,0,3072,32768,16640,3072,32768,16640,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,32768,16384,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","ASA","Listitems","ASAExprs","ASABindings","ASAC","ASACond","ListVar","int","bool","'+'","'-'","'*'","'/'","'add1'","'sub1'","'sqrt'","'expt'","'fst'","'snd'","'='","'<'","'>'","'<='","'>='","'!='","'and'","'not'","'if'","'('","')'","'let'","'let*'","'letrec'","\"cond\"","\"else\"","\"lambda\"","','","'['","']'","'head'","'tail'","'nil'","'cons'","var","%eof"]
        bit_start = st Prelude.* 48
        bit_end = (st Prelude.+ 1) Prelude.* 48
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..47]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (11) = happyShift action_2
action_0 (12) = happyShift action_4
action_0 (32) = happyShift action_5
action_0 (41) = happyShift action_6
action_0 (47) = happyShift action_7
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (11) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (48) = happyAccept
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
action_5 (32) = happyShift action_5
action_5 (34) = happyShift action_31
action_5 (35) = happyShift action_32
action_5 (36) = happyShift action_33
action_5 (37) = happyShift action_34
action_5 (39) = happyShift action_35
action_5 (41) = happyShift action_6
action_5 (43) = happyShift action_36
action_5 (44) = happyShift action_37
action_5 (47) = happyShift action_7
action_5 (4) = happyGoto action_11
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (11) = happyShift action_2
action_6 (12) = happyShift action_4
action_6 (32) = happyShift action_5
action_6 (41) = happyShift action_6
action_6 (42) = happyShift action_10
action_6 (47) = happyShift action_7
action_6 (4) = happyGoto action_8
action_6 (5) = happyGoto action_9
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_3

action_8 (40) = happyShift action_70
action_8 _ = happyReduce_34

action_9 (42) = happyShift action_69
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_32

action_11 (11) = happyShift action_2
action_11 (12) = happyShift action_4
action_11 (32) = happyShift action_5
action_11 (40) = happyShift action_68
action_11 (41) = happyShift action_6
action_11 (47) = happyShift action_7
action_11 (4) = happyGoto action_49
action_11 (6) = happyGoto action_67
action_11 _ = happyReduce_36

action_12 (11) = happyShift action_2
action_12 (12) = happyShift action_4
action_12 (32) = happyShift action_5
action_12 (41) = happyShift action_6
action_12 (47) = happyShift action_7
action_12 (4) = happyGoto action_49
action_12 (6) = happyGoto action_66
action_12 _ = happyReduce_36

action_13 (11) = happyShift action_2
action_13 (12) = happyShift action_4
action_13 (32) = happyShift action_5
action_13 (41) = happyShift action_6
action_13 (47) = happyShift action_7
action_13 (4) = happyGoto action_49
action_13 (6) = happyGoto action_65
action_13 _ = happyReduce_36

action_14 (11) = happyShift action_2
action_14 (12) = happyShift action_4
action_14 (32) = happyShift action_5
action_14 (41) = happyShift action_6
action_14 (47) = happyShift action_7
action_14 (4) = happyGoto action_49
action_14 (6) = happyGoto action_64
action_14 _ = happyReduce_36

action_15 (11) = happyShift action_2
action_15 (12) = happyShift action_4
action_15 (32) = happyShift action_5
action_15 (41) = happyShift action_6
action_15 (47) = happyShift action_7
action_15 (4) = happyGoto action_49
action_15 (6) = happyGoto action_63
action_15 _ = happyReduce_36

action_16 (11) = happyShift action_2
action_16 (12) = happyShift action_4
action_16 (32) = happyShift action_5
action_16 (41) = happyShift action_6
action_16 (47) = happyShift action_7
action_16 (4) = happyGoto action_49
action_16 (6) = happyGoto action_62
action_16 _ = happyReduce_36

action_17 (11) = happyShift action_2
action_17 (12) = happyShift action_4
action_17 (32) = happyShift action_5
action_17 (41) = happyShift action_6
action_17 (47) = happyShift action_7
action_17 (4) = happyGoto action_49
action_17 (6) = happyGoto action_61
action_17 _ = happyReduce_36

action_18 (11) = happyShift action_2
action_18 (12) = happyShift action_4
action_18 (32) = happyShift action_5
action_18 (41) = happyShift action_6
action_18 (47) = happyShift action_7
action_18 (4) = happyGoto action_49
action_18 (6) = happyGoto action_60
action_18 _ = happyReduce_36

action_19 (11) = happyShift action_2
action_19 (12) = happyShift action_4
action_19 (32) = happyShift action_5
action_19 (41) = happyShift action_6
action_19 (47) = happyShift action_7
action_19 (4) = happyGoto action_59
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (11) = happyShift action_2
action_20 (12) = happyShift action_4
action_20 (32) = happyShift action_5
action_20 (41) = happyShift action_6
action_20 (47) = happyShift action_7
action_20 (4) = happyGoto action_58
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (11) = happyShift action_2
action_21 (12) = happyShift action_4
action_21 (32) = happyShift action_5
action_21 (41) = happyShift action_6
action_21 (47) = happyShift action_7
action_21 (4) = happyGoto action_57
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (11) = happyShift action_2
action_22 (12) = happyShift action_4
action_22 (32) = happyShift action_5
action_22 (41) = happyShift action_6
action_22 (47) = happyShift action_7
action_22 (4) = happyGoto action_49
action_22 (6) = happyGoto action_56
action_22 _ = happyReduce_36

action_23 (11) = happyShift action_2
action_23 (12) = happyShift action_4
action_23 (32) = happyShift action_5
action_23 (41) = happyShift action_6
action_23 (47) = happyShift action_7
action_23 (4) = happyGoto action_49
action_23 (6) = happyGoto action_55
action_23 _ = happyReduce_36

action_24 (11) = happyShift action_2
action_24 (12) = happyShift action_4
action_24 (32) = happyShift action_5
action_24 (41) = happyShift action_6
action_24 (47) = happyShift action_7
action_24 (4) = happyGoto action_49
action_24 (6) = happyGoto action_54
action_24 _ = happyReduce_36

action_25 (11) = happyShift action_2
action_25 (12) = happyShift action_4
action_25 (32) = happyShift action_5
action_25 (41) = happyShift action_6
action_25 (47) = happyShift action_7
action_25 (4) = happyGoto action_49
action_25 (6) = happyGoto action_53
action_25 _ = happyReduce_36

action_26 (11) = happyShift action_2
action_26 (12) = happyShift action_4
action_26 (32) = happyShift action_5
action_26 (41) = happyShift action_6
action_26 (47) = happyShift action_7
action_26 (4) = happyGoto action_49
action_26 (6) = happyGoto action_52
action_26 _ = happyReduce_36

action_27 (11) = happyShift action_2
action_27 (12) = happyShift action_4
action_27 (32) = happyShift action_5
action_27 (41) = happyShift action_6
action_27 (47) = happyShift action_7
action_27 (4) = happyGoto action_49
action_27 (6) = happyGoto action_51
action_27 _ = happyReduce_36

action_28 (11) = happyShift action_2
action_28 (12) = happyShift action_4
action_28 (32) = happyShift action_5
action_28 (41) = happyShift action_6
action_28 (47) = happyShift action_7
action_28 (4) = happyGoto action_49
action_28 (6) = happyGoto action_50
action_28 _ = happyReduce_36

action_29 (11) = happyShift action_2
action_29 (12) = happyShift action_4
action_29 (32) = happyShift action_5
action_29 (41) = happyShift action_6
action_29 (47) = happyShift action_7
action_29 (4) = happyGoto action_48
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (11) = happyShift action_2
action_30 (12) = happyShift action_4
action_30 (32) = happyShift action_5
action_30 (41) = happyShift action_6
action_30 (47) = happyShift action_7
action_30 (4) = happyGoto action_47
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (32) = happyShift action_46
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (32) = happyShift action_45
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (32) = happyShift action_44
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (41) = happyShift action_43
action_34 (8) = happyGoto action_41
action_34 (9) = happyGoto action_42
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (32) = happyShift action_40
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (11) = happyShift action_2
action_36 (12) = happyShift action_4
action_36 (32) = happyShift action_5
action_36 (41) = happyShift action_6
action_36 (47) = happyShift action_7
action_36 (4) = happyGoto action_39
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (11) = happyShift action_2
action_37 (12) = happyShift action_4
action_37 (32) = happyShift action_5
action_37 (41) = happyShift action_6
action_37 (47) = happyShift action_7
action_37 (4) = happyGoto action_38
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (33) = happyShift action_105
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (33) = happyShift action_104
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (47) = happyShift action_103
action_40 (10) = happyGoto action_102
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (41) = happyShift action_43
action_41 (8) = happyGoto action_41
action_41 (9) = happyGoto action_101
action_41 _ = happyReduce_42

action_42 (38) = happyShift action_100
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (11) = happyShift action_2
action_43 (12) = happyShift action_4
action_43 (32) = happyShift action_5
action_43 (41) = happyShift action_6
action_43 (47) = happyShift action_7
action_43 (4) = happyGoto action_99
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (32) = happyShift action_95
action_44 (47) = happyShift action_96
action_44 (7) = happyGoto action_98
action_44 _ = happyReduce_38

action_45 (32) = happyShift action_95
action_45 (47) = happyShift action_96
action_45 (7) = happyGoto action_97
action_45 _ = happyReduce_38

action_46 (32) = happyShift action_95
action_46 (47) = happyShift action_96
action_46 (7) = happyGoto action_94
action_46 _ = happyReduce_38

action_47 (11) = happyShift action_2
action_47 (12) = happyShift action_4
action_47 (32) = happyShift action_5
action_47 (41) = happyShift action_6
action_47 (47) = happyShift action_7
action_47 (4) = happyGoto action_93
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (33) = happyShift action_92
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (11) = happyShift action_2
action_49 (12) = happyShift action_4
action_49 (32) = happyShift action_5
action_49 (41) = happyShift action_6
action_49 (47) = happyShift action_7
action_49 (4) = happyGoto action_49
action_49 (6) = happyGoto action_91
action_49 _ = happyReduce_36

action_50 (33) = happyShift action_90
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (33) = happyShift action_89
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (33) = happyShift action_88
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (33) = happyShift action_87
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (33) = happyShift action_86
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (33) = happyShift action_85
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (33) = happyShift action_84
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (33) = happyShift action_83
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (33) = happyShift action_82
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (11) = happyShift action_2
action_59 (12) = happyShift action_4
action_59 (32) = happyShift action_5
action_59 (41) = happyShift action_6
action_59 (47) = happyShift action_7
action_59 (4) = happyGoto action_49
action_59 (6) = happyGoto action_81
action_59 _ = happyReduce_36

action_60 (33) = happyShift action_80
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (33) = happyShift action_79
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (33) = happyShift action_78
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (33) = happyShift action_77
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (33) = happyShift action_76
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (33) = happyShift action_75
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (33) = happyShift action_74
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (33) = happyShift action_73
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (11) = happyShift action_2
action_68 (12) = happyShift action_4
action_68 (32) = happyShift action_5
action_68 (41) = happyShift action_6
action_68 (47) = happyShift action_7
action_68 (4) = happyGoto action_72
action_68 _ = happyFail (happyExpListPerState 68)

action_69 _ = happyReduce_33

action_70 (11) = happyShift action_2
action_70 (12) = happyShift action_4
action_70 (32) = happyShift action_5
action_70 (41) = happyShift action_6
action_70 (47) = happyShift action_7
action_70 (4) = happyGoto action_8
action_70 (5) = happyGoto action_71
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_35

action_72 (33) = happyShift action_117
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_29

action_74 _ = happyReduce_4

action_75 _ = happyReduce_5

action_76 _ = happyReduce_6

action_77 _ = happyReduce_7

action_78 _ = happyReduce_8

action_79 _ = happyReduce_9

action_80 _ = happyReduce_10

action_81 (33) = happyShift action_116
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_13

action_83 _ = happyReduce_14

action_84 _ = happyReduce_15

action_85 _ = happyReduce_16

action_86 _ = happyReduce_17

action_87 _ = happyReduce_18

action_88 _ = happyReduce_19

action_89 _ = happyReduce_20

action_90 _ = happyReduce_21

action_91 _ = happyReduce_37

action_92 _ = happyReduce_22

action_93 (11) = happyShift action_2
action_93 (12) = happyShift action_4
action_93 (32) = happyShift action_5
action_93 (41) = happyShift action_6
action_93 (47) = happyShift action_7
action_93 (4) = happyGoto action_115
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (33) = happyShift action_114
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (47) = happyShift action_113
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (11) = happyShift action_2
action_96 (12) = happyShift action_4
action_96 (32) = happyShift action_5
action_96 (41) = happyShift action_6
action_96 (47) = happyShift action_7
action_96 (4) = happyGoto action_112
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (33) = happyShift action_111
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (33) = happyShift action_110
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (11) = happyShift action_2
action_99 (12) = happyShift action_4
action_99 (32) = happyShift action_5
action_99 (41) = happyShift action_6
action_99 (47) = happyShift action_7
action_99 (4) = happyGoto action_109
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (11) = happyShift action_2
action_100 (12) = happyShift action_4
action_100 (32) = happyShift action_5
action_100 (41) = happyShift action_6
action_100 (47) = happyShift action_7
action_100 (4) = happyGoto action_108
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_43

action_102 (33) = happyShift action_107
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (47) = happyShift action_103
action_103 (10) = happyGoto action_106
action_103 _ = happyReduce_45

action_104 _ = happyReduce_30

action_105 _ = happyReduce_31

action_106 _ = happyReduce_44

action_107 (11) = happyShift action_2
action_107 (12) = happyShift action_4
action_107 (32) = happyShift action_5
action_107 (41) = happyShift action_6
action_107 (47) = happyShift action_7
action_107 (4) = happyGoto action_125
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (33) = happyShift action_124
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (42) = happyShift action_123
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (11) = happyShift action_2
action_110 (12) = happyShift action_4
action_110 (32) = happyShift action_5
action_110 (41) = happyShift action_6
action_110 (47) = happyShift action_7
action_110 (4) = happyGoto action_122
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (11) = happyShift action_2
action_111 (12) = happyShift action_4
action_111 (32) = happyShift action_5
action_111 (41) = happyShift action_6
action_111 (47) = happyShift action_7
action_111 (4) = happyGoto action_121
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_40

action_113 (11) = happyShift action_2
action_113 (12) = happyShift action_4
action_113 (32) = happyShift action_5
action_113 (41) = happyShift action_6
action_113 (47) = happyShift action_7
action_113 (4) = happyGoto action_120
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (11) = happyShift action_2
action_114 (12) = happyShift action_4
action_114 (32) = happyShift action_5
action_114 (41) = happyShift action_6
action_114 (47) = happyShift action_7
action_114 (4) = happyGoto action_119
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (33) = happyShift action_118
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_11

action_117 _ = happyReduce_12

action_118 _ = happyReduce_23

action_119 (33) = happyShift action_130
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (33) = happyShift action_129
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (33) = happyShift action_128
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (33) = happyShift action_127
action_122 _ = happyFail (happyExpListPerState 122)

action_123 _ = happyReduce_41

action_124 _ = happyReduce_27

action_125 (33) = happyShift action_126
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_28

action_127 _ = happyReduce_26

action_128 _ = happyReduce_25

action_129 (32) = happyShift action_95
action_129 (47) = happyShift action_96
action_129 (7) = happyGoto action_131
action_129 _ = happyReduce_38

action_130 _ = happyReduce_24

action_131 _ = happyReduce_39

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

happyReduce_30 = happyReduce 4 4 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Head happy_var_3
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 4 4 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Tail happy_var_3
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_2  4 happyReduction_32
happyReduction_32 _
	_
	 =  HappyAbsSyn4
		 (List []
	)

happyReduce_33 = happySpecReduce_3  4 happyReduction_33
happyReduction_33 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (List happy_var_2
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  5 happyReduction_34
happyReduction_34 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  5 happyReduction_35
happyReduction_35 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_0  6 happyReduction_36
happyReduction_36  =  HappyAbsSyn6
		 ([]
	)

happyReduce_37 = happySpecReduce_2  6 happyReduction_37
happyReduction_37 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_0  7 happyReduction_38
happyReduction_38  =  HappyAbsSyn7
		 ([]
	)

happyReduce_39 = happyReduce 5 7 happyReduction_39
happyReduction_39 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 ((happy_var_2 , happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_2  7 happyReduction_40
happyReduction_40 (HappyAbsSyn4  happy_var_2)
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn7
		 ([(happy_var_1, happy_var_2)]
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 4 8 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ((happy_var_2, happy_var_3)
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_1  9 happyReduction_42
happyReduction_42 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  9 happyReduction_43
happyReduction_43 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  10 happyReduction_44
happyReduction_44 (HappyAbsSyn10  happy_var_2)
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  10 happyReduction_45
happyReduction_45 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 48 48 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenNum happy_dollar_dollar -> cont 11;
	TokenBool happy_dollar_dollar -> cont 12;
	TokenSum -> cont 13;
	TokenSub -> cont 14;
	TokenMult -> cont 15;
	TokenDiv -> cont 16;
	TokenAdd1 -> cont 17;
	TokenSub1 -> cont 18;
	TokenSqrt -> cont 19;
	TokenExpt -> cont 20;
	TokenFst -> cont 21;
	TokenSnd -> cont 22;
	TokenEq -> cont 23;
	TokenLt -> cont 24;
	TokenGt -> cont 25;
	TokenLeq -> cont 26;
	TokenGeq -> cont 27;
	TokenNeq -> cont 28;
	TokenAnd -> cont 29;
	TokenNot -> cont 30;
	TokenIf -> cont 31;
	TokenPA -> cont 32;
	TokenPC -> cont 33;
	TokenLet -> cont 34;
	TokenLetStar -> cont 35;
	TokenLetRec -> cont 36;
	TokenCond -> cont 37;
	TokenElse -> cont 38;
	TokenLambda -> cont 39;
	TokenComma -> cont 40;
	TokenCA -> cont 41;
	TokenCC -> cont 42;
	TokenHead -> cont 43;
	TokenTail -> cont 44;
	TokenNil -> cont 45;
	TokenCons -> cont 46;
	TokenVar happy_dollar_dollar -> cont 47;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 48 tk tks = happyError' (tks, explist)
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
