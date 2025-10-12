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
happyExpList = Happy_Data_Array.listArray (0,208) ([3072,16384,5184,256,0,0,0,0,0,0,0,0,0,0,0,65535,54751,49159,0,19460,1,0,0,0,0,0,0,0,8,0,0,8,0,0,0,12,24640,20,3,4112,49157,0,17412,12289,0,20737,3072,16384,5184,768,4096,1296,192,1024,324,48,256,81,12,16448,20,3,4112,49157,0,17412,12289,0,20737,3072,16384,5184,768,4096,1296,192,1024,324,48,256,81,12,16448,20,3,4112,49157,0,17412,1,0,1,0,16384,0,0,0,16,0,1024,0,48,256,81,12,16448,20,3,4112,49157,0,17412,1,0,2,0,32768,0,0,0,1024,0,0,4,0,8192,0,12,16448,20,0,16,4,0,4,12289,0,20737,0,32768,0,768,4096,1296,0,2048,0,0,512,0,0,128,0,0,32,0,0,8,0,0,2,0,32768,0,0,8192,0,0,2048,0,0,512,0,0,128,0,0,32,0,0,8,0,0,2,0,32768,0,0,8192,0,0,2048,0,48,256,81,0,0,0,3,4112,5,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,256,81,0,128,0,0,0,49156,0,17412,1,0,2,3072,16384,5184,768,4096,1296,0,0,0,0,512,0,0,0,16,0,0,0,0,0,0,0,2,0,0,0,0,0,0,192,1024,324,0,512,0,0,32768,0,3,4112,5,0,0,12288,0,20737,3072,16384,5184,0,8192,0,0,0,0,0,0,0,0,128,0,0,32,0,0,8,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,64,16,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","ASA","Listitems","ASAExprs","ASABindings","ASAC","ASACond","ListVar","int","bool","'+'","'-'","'*'","'/'","'add1'","'sub1'","'sqrt'","'expt'","'fst'","'snd'","'='","'<'","'>'","'<='","'>='","'!='","\"not\"","\"if\"","'('","')'","\"let\"","\"let*\"","\"cond\"","\"else\"","\"lambda\"","','","'['","']'","\"head\"","\"tail\"","\"nil\"","\"cons\"","var","%eof"]
        bit_start = st Prelude.* 46
        bit_end = (st Prelude.+ 1) Prelude.* 46
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..45]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (11) = happyShift action_2
action_0 (12) = happyShift action_4
action_0 (31) = happyShift action_5
action_0 (39) = happyShift action_6
action_0 (43) = happyShift action_7
action_0 (45) = happyShift action_8
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (11) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (46) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (11) = happyShift action_2
action_5 (12) = happyShift action_4
action_5 (13) = happyShift action_13
action_5 (14) = happyShift action_14
action_5 (15) = happyShift action_15
action_5 (16) = happyShift action_16
action_5 (17) = happyShift action_17
action_5 (18) = happyShift action_18
action_5 (19) = happyShift action_19
action_5 (20) = happyShift action_20
action_5 (21) = happyShift action_21
action_5 (22) = happyShift action_22
action_5 (23) = happyShift action_23
action_5 (24) = happyShift action_24
action_5 (25) = happyShift action_25
action_5 (26) = happyShift action_26
action_5 (27) = happyShift action_27
action_5 (28) = happyShift action_28
action_5 (29) = happyShift action_29
action_5 (30) = happyShift action_30
action_5 (31) = happyShift action_5
action_5 (33) = happyShift action_31
action_5 (34) = happyShift action_32
action_5 (35) = happyShift action_33
action_5 (37) = happyShift action_34
action_5 (39) = happyShift action_6
action_5 (41) = happyShift action_35
action_5 (42) = happyShift action_36
action_5 (43) = happyShift action_7
action_5 (44) = happyShift action_37
action_5 (45) = happyShift action_8
action_5 (4) = happyGoto action_12
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (11) = happyShift action_2
action_6 (12) = happyShift action_4
action_6 (31) = happyShift action_5
action_6 (39) = happyShift action_6
action_6 (40) = happyShift action_11
action_6 (43) = happyShift action_7
action_6 (45) = happyShift action_8
action_6 (4) = happyGoto action_9
action_6 (5) = happyGoto action_10
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_32

action_8 _ = happyReduce_3

action_9 (38) = happyShift action_69
action_9 _ = happyReduce_34

action_10 (40) = happyShift action_68
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_30

action_12 (11) = happyShift action_2
action_12 (12) = happyShift action_4
action_12 (31) = happyShift action_5
action_12 (38) = happyShift action_67
action_12 (39) = happyShift action_6
action_12 (43) = happyShift action_7
action_12 (45) = happyShift action_8
action_12 (4) = happyGoto action_49
action_12 (6) = happyGoto action_66
action_12 _ = happyReduce_36

action_13 (11) = happyShift action_2
action_13 (12) = happyShift action_4
action_13 (31) = happyShift action_5
action_13 (39) = happyShift action_6
action_13 (43) = happyShift action_7
action_13 (45) = happyShift action_8
action_13 (4) = happyGoto action_49
action_13 (6) = happyGoto action_65
action_13 _ = happyReduce_36

action_14 (11) = happyShift action_2
action_14 (12) = happyShift action_4
action_14 (31) = happyShift action_5
action_14 (39) = happyShift action_6
action_14 (43) = happyShift action_7
action_14 (45) = happyShift action_8
action_14 (4) = happyGoto action_49
action_14 (6) = happyGoto action_64
action_14 _ = happyReduce_36

action_15 (11) = happyShift action_2
action_15 (12) = happyShift action_4
action_15 (31) = happyShift action_5
action_15 (39) = happyShift action_6
action_15 (43) = happyShift action_7
action_15 (45) = happyShift action_8
action_15 (4) = happyGoto action_49
action_15 (6) = happyGoto action_63
action_15 _ = happyReduce_36

action_16 (11) = happyShift action_2
action_16 (12) = happyShift action_4
action_16 (31) = happyShift action_5
action_16 (39) = happyShift action_6
action_16 (43) = happyShift action_7
action_16 (45) = happyShift action_8
action_16 (4) = happyGoto action_49
action_16 (6) = happyGoto action_62
action_16 _ = happyReduce_36

action_17 (11) = happyShift action_2
action_17 (12) = happyShift action_4
action_17 (31) = happyShift action_5
action_17 (39) = happyShift action_6
action_17 (43) = happyShift action_7
action_17 (45) = happyShift action_8
action_17 (4) = happyGoto action_49
action_17 (6) = happyGoto action_61
action_17 _ = happyReduce_36

action_18 (11) = happyShift action_2
action_18 (12) = happyShift action_4
action_18 (31) = happyShift action_5
action_18 (39) = happyShift action_6
action_18 (43) = happyShift action_7
action_18 (45) = happyShift action_8
action_18 (4) = happyGoto action_49
action_18 (6) = happyGoto action_60
action_18 _ = happyReduce_36

action_19 (11) = happyShift action_2
action_19 (12) = happyShift action_4
action_19 (31) = happyShift action_5
action_19 (39) = happyShift action_6
action_19 (43) = happyShift action_7
action_19 (45) = happyShift action_8
action_19 (4) = happyGoto action_49
action_19 (6) = happyGoto action_59
action_19 _ = happyReduce_36

action_20 (11) = happyShift action_2
action_20 (12) = happyShift action_4
action_20 (31) = happyShift action_5
action_20 (39) = happyShift action_6
action_20 (43) = happyShift action_7
action_20 (45) = happyShift action_8
action_20 (4) = happyGoto action_49
action_20 (6) = happyGoto action_58
action_20 _ = happyReduce_36

action_21 (11) = happyShift action_2
action_21 (12) = happyShift action_4
action_21 (31) = happyShift action_5
action_21 (39) = happyShift action_6
action_21 (43) = happyShift action_7
action_21 (45) = happyShift action_8
action_21 (4) = happyGoto action_57
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (11) = happyShift action_2
action_22 (12) = happyShift action_4
action_22 (31) = happyShift action_5
action_22 (39) = happyShift action_6
action_22 (43) = happyShift action_7
action_22 (45) = happyShift action_8
action_22 (4) = happyGoto action_56
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (11) = happyShift action_2
action_23 (12) = happyShift action_4
action_23 (31) = happyShift action_5
action_23 (39) = happyShift action_6
action_23 (43) = happyShift action_7
action_23 (45) = happyShift action_8
action_23 (4) = happyGoto action_49
action_23 (6) = happyGoto action_55
action_23 _ = happyReduce_36

action_24 (11) = happyShift action_2
action_24 (12) = happyShift action_4
action_24 (31) = happyShift action_5
action_24 (39) = happyShift action_6
action_24 (43) = happyShift action_7
action_24 (45) = happyShift action_8
action_24 (4) = happyGoto action_49
action_24 (6) = happyGoto action_54
action_24 _ = happyReduce_36

action_25 (11) = happyShift action_2
action_25 (12) = happyShift action_4
action_25 (31) = happyShift action_5
action_25 (39) = happyShift action_6
action_25 (43) = happyShift action_7
action_25 (45) = happyShift action_8
action_25 (4) = happyGoto action_49
action_25 (6) = happyGoto action_53
action_25 _ = happyReduce_36

action_26 (11) = happyShift action_2
action_26 (12) = happyShift action_4
action_26 (31) = happyShift action_5
action_26 (39) = happyShift action_6
action_26 (43) = happyShift action_7
action_26 (45) = happyShift action_8
action_26 (4) = happyGoto action_49
action_26 (6) = happyGoto action_52
action_26 _ = happyReduce_36

action_27 (11) = happyShift action_2
action_27 (12) = happyShift action_4
action_27 (31) = happyShift action_5
action_27 (39) = happyShift action_6
action_27 (43) = happyShift action_7
action_27 (45) = happyShift action_8
action_27 (4) = happyGoto action_49
action_27 (6) = happyGoto action_51
action_27 _ = happyReduce_36

action_28 (11) = happyShift action_2
action_28 (12) = happyShift action_4
action_28 (31) = happyShift action_5
action_28 (39) = happyShift action_6
action_28 (43) = happyShift action_7
action_28 (45) = happyShift action_8
action_28 (4) = happyGoto action_49
action_28 (6) = happyGoto action_50
action_28 _ = happyReduce_36

action_29 (11) = happyShift action_2
action_29 (12) = happyShift action_4
action_29 (31) = happyShift action_5
action_29 (39) = happyShift action_6
action_29 (43) = happyShift action_7
action_29 (45) = happyShift action_8
action_29 (4) = happyGoto action_48
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (11) = happyShift action_2
action_30 (12) = happyShift action_4
action_30 (31) = happyShift action_5
action_30 (39) = happyShift action_6
action_30 (43) = happyShift action_7
action_30 (45) = happyShift action_8
action_30 (4) = happyGoto action_47
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (31) = happyShift action_46
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (31) = happyShift action_45
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (39) = happyShift action_44
action_33 (8) = happyGoto action_42
action_33 (9) = happyGoto action_43
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (31) = happyShift action_41
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (11) = happyShift action_2
action_35 (12) = happyShift action_4
action_35 (31) = happyShift action_5
action_35 (39) = happyShift action_6
action_35 (43) = happyShift action_7
action_35 (45) = happyShift action_8
action_35 (4) = happyGoto action_40
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (11) = happyShift action_2
action_36 (12) = happyShift action_4
action_36 (31) = happyShift action_5
action_36 (39) = happyShift action_6
action_36 (43) = happyShift action_7
action_36 (45) = happyShift action_8
action_36 (4) = happyGoto action_39
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (11) = happyShift action_2
action_37 (12) = happyShift action_4
action_37 (31) = happyShift action_5
action_37 (39) = happyShift action_6
action_37 (43) = happyShift action_7
action_37 (45) = happyShift action_8
action_37 (4) = happyGoto action_38
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (11) = happyShift action_2
action_38 (12) = happyShift action_4
action_38 (31) = happyShift action_5
action_38 (39) = happyShift action_6
action_38 (43) = happyShift action_7
action_38 (45) = happyShift action_8
action_38 (4) = happyGoto action_103
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (32) = happyShift action_102
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (32) = happyShift action_101
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (45) = happyShift action_100
action_41 (10) = happyGoto action_99
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (39) = happyShift action_44
action_42 (8) = happyGoto action_42
action_42 (9) = happyGoto action_98
action_42 _ = happyReduce_42

action_43 (36) = happyShift action_97
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (11) = happyShift action_2
action_44 (12) = happyShift action_4
action_44 (31) = happyShift action_5
action_44 (39) = happyShift action_6
action_44 (43) = happyShift action_7
action_44 (45) = happyShift action_8
action_44 (4) = happyGoto action_96
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (31) = happyShift action_93
action_45 (45) = happyShift action_94
action_45 (7) = happyGoto action_95
action_45 _ = happyReduce_38

action_46 (31) = happyShift action_93
action_46 (45) = happyShift action_94
action_46 (7) = happyGoto action_92
action_46 _ = happyReduce_38

action_47 (11) = happyShift action_2
action_47 (12) = happyShift action_4
action_47 (31) = happyShift action_5
action_47 (39) = happyShift action_6
action_47 (43) = happyShift action_7
action_47 (45) = happyShift action_8
action_47 (4) = happyGoto action_91
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (32) = happyShift action_90
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (11) = happyShift action_2
action_49 (12) = happyShift action_4
action_49 (31) = happyShift action_5
action_49 (39) = happyShift action_6
action_49 (43) = happyShift action_7
action_49 (45) = happyShift action_8
action_49 (4) = happyGoto action_49
action_49 (6) = happyGoto action_89
action_49 _ = happyReduce_36

action_50 (32) = happyShift action_88
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (32) = happyShift action_87
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (32) = happyShift action_86
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (32) = happyShift action_85
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (32) = happyShift action_84
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (32) = happyShift action_83
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (32) = happyShift action_82
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (32) = happyShift action_81
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (32) = happyShift action_80
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (32) = happyShift action_79
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (32) = happyShift action_78
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (32) = happyShift action_77
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (32) = happyShift action_76
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (32) = happyShift action_75
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (32) = happyShift action_74
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (32) = happyShift action_73
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (32) = happyShift action_72
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (11) = happyShift action_2
action_67 (12) = happyShift action_4
action_67 (31) = happyShift action_5
action_67 (39) = happyShift action_6
action_67 (43) = happyShift action_7
action_67 (45) = happyShift action_8
action_67 (4) = happyGoto action_71
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_31

action_69 (11) = happyShift action_2
action_69 (12) = happyShift action_4
action_69 (31) = happyShift action_5
action_69 (39) = happyShift action_6
action_69 (43) = happyShift action_7
action_69 (45) = happyShift action_8
action_69 (4) = happyGoto action_9
action_69 (5) = happyGoto action_70
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_35

action_71 (32) = happyShift action_114
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_27

action_73 _ = happyReduce_4

action_74 _ = happyReduce_5

action_75 _ = happyReduce_6

action_76 _ = happyReduce_7

action_77 _ = happyReduce_8

action_78 _ = happyReduce_9

action_79 _ = happyReduce_10

action_80 _ = happyReduce_11

action_81 _ = happyReduce_13

action_82 _ = happyReduce_14

action_83 _ = happyReduce_15

action_84 _ = happyReduce_16

action_85 _ = happyReduce_17

action_86 _ = happyReduce_18

action_87 _ = happyReduce_19

action_88 _ = happyReduce_20

action_89 _ = happyReduce_37

action_90 _ = happyReduce_21

action_91 (11) = happyShift action_2
action_91 (12) = happyShift action_4
action_91 (31) = happyShift action_5
action_91 (39) = happyShift action_6
action_91 (43) = happyShift action_7
action_91 (45) = happyShift action_8
action_91 (4) = happyGoto action_113
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (32) = happyShift action_112
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (45) = happyShift action_111
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (11) = happyShift action_2
action_94 (12) = happyShift action_4
action_94 (31) = happyShift action_5
action_94 (39) = happyShift action_6
action_94 (43) = happyShift action_7
action_94 (45) = happyShift action_8
action_94 (4) = happyGoto action_110
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (32) = happyShift action_109
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (11) = happyShift action_2
action_96 (12) = happyShift action_4
action_96 (31) = happyShift action_5
action_96 (39) = happyShift action_6
action_96 (43) = happyShift action_7
action_96 (45) = happyShift action_8
action_96 (4) = happyGoto action_108
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (11) = happyShift action_2
action_97 (12) = happyShift action_4
action_97 (31) = happyShift action_5
action_97 (39) = happyShift action_6
action_97 (43) = happyShift action_7
action_97 (45) = happyShift action_8
action_97 (4) = happyGoto action_107
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_43

action_99 (32) = happyShift action_106
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (45) = happyShift action_100
action_100 (10) = happyGoto action_105
action_100 _ = happyReduce_45

action_101 _ = happyReduce_28

action_102 _ = happyReduce_29

action_103 (32) = happyShift action_104
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_33

action_105 _ = happyReduce_44

action_106 (11) = happyShift action_2
action_106 (12) = happyShift action_4
action_106 (31) = happyShift action_5
action_106 (39) = happyShift action_6
action_106 (43) = happyShift action_7
action_106 (45) = happyShift action_8
action_106 (4) = happyGoto action_121
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (32) = happyShift action_120
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (40) = happyShift action_119
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (11) = happyShift action_2
action_109 (12) = happyShift action_4
action_109 (31) = happyShift action_5
action_109 (39) = happyShift action_6
action_109 (43) = happyShift action_7
action_109 (45) = happyShift action_8
action_109 (4) = happyGoto action_118
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_40

action_111 (11) = happyShift action_2
action_111 (12) = happyShift action_4
action_111 (31) = happyShift action_5
action_111 (39) = happyShift action_6
action_111 (43) = happyShift action_7
action_111 (45) = happyShift action_8
action_111 (4) = happyGoto action_117
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (11) = happyShift action_2
action_112 (12) = happyShift action_4
action_112 (31) = happyShift action_5
action_112 (39) = happyShift action_6
action_112 (43) = happyShift action_7
action_112 (45) = happyShift action_8
action_112 (4) = happyGoto action_116
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (32) = happyShift action_115
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_12

action_115 _ = happyReduce_22

action_116 (32) = happyShift action_125
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (32) = happyShift action_124
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (32) = happyShift action_123
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_41

action_120 _ = happyReduce_25

action_121 (32) = happyShift action_122
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_26

action_123 _ = happyReduce_24

action_124 (31) = happyShift action_93
action_124 (45) = happyShift action_94
action_124 (7) = happyGoto action_126
action_124 _ = happyReduce_38

action_125 _ = happyReduce_23

action_126 _ = happyReduce_39

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

happyReduce_11 = happyReduce 4 4 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Expt happy_var_3
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
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Not happy_var_3
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 6 4 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 7 4 happyReduction_23
happyReduction_23 (_ `HappyStk`
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
		 (LetStar happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 6 4 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (CondElse happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 7 4 happyReduction_26
happyReduction_26 (_ `HappyStk`
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

happyReduce_27 = happyReduce 4 4 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (App happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 4 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Head happy_var_3
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 4 4 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Tail happy_var_3
	) `HappyStk` happyRest

happyReduce_30 = happySpecReduce_2  4 happyReduction_30
happyReduction_30 _
	_
	 =  HappyAbsSyn4
		 (List []
	)

happyReduce_31 = happySpecReduce_3  4 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (List happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  4 happyReduction_32
happyReduction_32 _
	 =  HappyAbsSyn4
		 (Nil
	)

happyReduce_33 = happyReduce 5 4 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Cons happy_var_3 happy_var_4
	) `HappyStk` happyRest

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
	action 46 46 notHappyAtAll (HappyState action) sts stk []

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
	TokenNot -> cont 29;
	TokenIf -> cont 30;
	TokenPA -> cont 31;
	TokenPC -> cont 32;
	TokenLet -> cont 33;
	TokenLetStar -> cont 34;
	TokenCond -> cont 35;
	TokenElse -> cont 36;
	TokenLambda -> cont 37;
	TokenComma -> cont 38;
	TokenCA -> cont 39;
	TokenCC -> cont 40;
	TokenHead -> cont 41;
	TokenTail -> cont 42;
	TokenNil -> cont 43;
	TokenCons -> cont 44;
	TokenVar happy_dollar_dollar -> cont 45;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 46 tk tks = happyError' (tks, explist)
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
    | Expt [ASA]
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
