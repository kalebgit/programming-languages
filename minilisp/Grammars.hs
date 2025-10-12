{-# OPTIONS_GHC -w #-}
module Grammars where
import Lex (Token(..), lexer)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,169) ([192,33792,8232,0,0,0,0,0,0,0,0,0,65024,49151,500,3,42512,0,0,0,0,0,0,8192,0,0,64,0,0,3072,16384,652,6,17440,769,4096,32930,1,20744,192,33792,24616,0,5186,48,8448,6154,32768,1296,12,34880,1538,8192,324,3,41488,384,2048,49233,0,10372,96,16896,12308,0,2593,24,4224,3077,16384,648,6,17440,769,4096,162,0,8,192,33792,24616,0,5186,48,8448,6154,32768,1296,0,128,0,16384,0,3,41488,384,2048,81,0,8,96,16896,20,0,2,0,256,0,32768,0,0,64,0,8192,0,0,16,0,2048,0,0,4,0,512,0,0,1,0,128,0,16384,0,0,32,0,4096,0,0,8,0,1024,0,0,2,24,4224,5,0,0,6,17440,1,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6144,32768,1296,0,128,0,0,0,0,0,0,4096,0,0,0,96,16896,20,0,2,0,0,0,0,0,0,256,768,4096,162,0,16,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","ASA","Listitems","ASAExprs","int","bool","'+'","'-'","'*'","'/'","'add1'","'sub1'","'sqrt'","'expt'","'fst'","'snd'","'='","'<'","'>'","'<='","'>='","'!='","\"not\"","\"if\"","'('","')'","\"cond\"","\"else\"","','","'['","']'","\"head\"","\"tail\"","\"nil\"","\"cons\"","var","%eof"]
        bit_start = st Prelude.* 39
        bit_end = (st Prelude.+ 1) Prelude.* 39
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..38]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (7) = happyShift action_2
action_0 (8) = happyShift action_4
action_0 (27) = happyShift action_5
action_0 (32) = happyShift action_6
action_0 (36) = happyShift action_7
action_0 (38) = happyShift action_8
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (7) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (39) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (7) = happyShift action_2
action_5 (8) = happyShift action_4
action_5 (9) = happyShift action_13
action_5 (10) = happyShift action_14
action_5 (11) = happyShift action_15
action_5 (12) = happyShift action_16
action_5 (13) = happyShift action_17
action_5 (14) = happyShift action_18
action_5 (15) = happyShift action_19
action_5 (16) = happyShift action_20
action_5 (17) = happyShift action_21
action_5 (18) = happyShift action_22
action_5 (19) = happyShift action_23
action_5 (20) = happyShift action_24
action_5 (21) = happyShift action_25
action_5 (22) = happyShift action_26
action_5 (23) = happyShift action_27
action_5 (24) = happyShift action_28
action_5 (25) = happyShift action_29
action_5 (26) = happyShift action_30
action_5 (27) = happyShift action_5
action_5 (29) = happyShift action_31
action_5 (32) = happyShift action_6
action_5 (34) = happyShift action_32
action_5 (35) = happyShift action_33
action_5 (36) = happyShift action_7
action_5 (37) = happyShift action_34
action_5 (38) = happyShift action_8
action_5 (4) = happyGoto action_12
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (7) = happyShift action_2
action_6 (8) = happyShift action_4
action_6 (27) = happyShift action_5
action_6 (32) = happyShift action_6
action_6 (33) = happyShift action_11
action_6 (36) = happyShift action_7
action_6 (38) = happyShift action_8
action_6 (4) = happyGoto action_9
action_6 (5) = happyGoto action_10
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_29

action_8 _ = happyReduce_3

action_9 (31) = happyShift action_61
action_9 _ = happyReduce_31

action_10 (33) = happyShift action_60
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_27

action_12 (7) = happyShift action_2
action_12 (8) = happyShift action_4
action_12 (27) = happyShift action_5
action_12 (31) = happyShift action_59
action_12 (32) = happyShift action_6
action_12 (36) = happyShift action_7
action_12 (38) = happyShift action_8
action_12 (4) = happyGoto action_58
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (7) = happyShift action_2
action_13 (8) = happyShift action_4
action_13 (27) = happyShift action_5
action_13 (32) = happyShift action_6
action_13 (36) = happyShift action_7
action_13 (38) = happyShift action_8
action_13 (4) = happyGoto action_41
action_13 (6) = happyGoto action_57
action_13 _ = happyReduce_33

action_14 (7) = happyShift action_2
action_14 (8) = happyShift action_4
action_14 (27) = happyShift action_5
action_14 (32) = happyShift action_6
action_14 (36) = happyShift action_7
action_14 (38) = happyShift action_8
action_14 (4) = happyGoto action_41
action_14 (6) = happyGoto action_56
action_14 _ = happyReduce_33

action_15 (7) = happyShift action_2
action_15 (8) = happyShift action_4
action_15 (27) = happyShift action_5
action_15 (32) = happyShift action_6
action_15 (36) = happyShift action_7
action_15 (38) = happyShift action_8
action_15 (4) = happyGoto action_41
action_15 (6) = happyGoto action_55
action_15 _ = happyReduce_33

action_16 (7) = happyShift action_2
action_16 (8) = happyShift action_4
action_16 (27) = happyShift action_5
action_16 (32) = happyShift action_6
action_16 (36) = happyShift action_7
action_16 (38) = happyShift action_8
action_16 (4) = happyGoto action_41
action_16 (6) = happyGoto action_54
action_16 _ = happyReduce_33

action_17 (7) = happyShift action_2
action_17 (8) = happyShift action_4
action_17 (27) = happyShift action_5
action_17 (32) = happyShift action_6
action_17 (36) = happyShift action_7
action_17 (38) = happyShift action_8
action_17 (4) = happyGoto action_41
action_17 (6) = happyGoto action_53
action_17 _ = happyReduce_33

action_18 (7) = happyShift action_2
action_18 (8) = happyShift action_4
action_18 (27) = happyShift action_5
action_18 (32) = happyShift action_6
action_18 (36) = happyShift action_7
action_18 (38) = happyShift action_8
action_18 (4) = happyGoto action_41
action_18 (6) = happyGoto action_52
action_18 _ = happyReduce_33

action_19 (7) = happyShift action_2
action_19 (8) = happyShift action_4
action_19 (27) = happyShift action_5
action_19 (32) = happyShift action_6
action_19 (36) = happyShift action_7
action_19 (38) = happyShift action_8
action_19 (4) = happyGoto action_41
action_19 (6) = happyGoto action_51
action_19 _ = happyReduce_33

action_20 (7) = happyShift action_2
action_20 (8) = happyShift action_4
action_20 (27) = happyShift action_5
action_20 (32) = happyShift action_6
action_20 (36) = happyShift action_7
action_20 (38) = happyShift action_8
action_20 (4) = happyGoto action_41
action_20 (6) = happyGoto action_50
action_20 _ = happyReduce_33

action_21 (7) = happyShift action_2
action_21 (8) = happyShift action_4
action_21 (27) = happyShift action_5
action_21 (32) = happyShift action_6
action_21 (36) = happyShift action_7
action_21 (38) = happyShift action_8
action_21 (4) = happyGoto action_49
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (7) = happyShift action_2
action_22 (8) = happyShift action_4
action_22 (27) = happyShift action_5
action_22 (32) = happyShift action_6
action_22 (36) = happyShift action_7
action_22 (38) = happyShift action_8
action_22 (4) = happyGoto action_48
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (7) = happyShift action_2
action_23 (8) = happyShift action_4
action_23 (27) = happyShift action_5
action_23 (32) = happyShift action_6
action_23 (36) = happyShift action_7
action_23 (38) = happyShift action_8
action_23 (4) = happyGoto action_41
action_23 (6) = happyGoto action_47
action_23 _ = happyReduce_33

action_24 (7) = happyShift action_2
action_24 (8) = happyShift action_4
action_24 (27) = happyShift action_5
action_24 (32) = happyShift action_6
action_24 (36) = happyShift action_7
action_24 (38) = happyShift action_8
action_24 (4) = happyGoto action_41
action_24 (6) = happyGoto action_46
action_24 _ = happyReduce_33

action_25 (7) = happyShift action_2
action_25 (8) = happyShift action_4
action_25 (27) = happyShift action_5
action_25 (32) = happyShift action_6
action_25 (36) = happyShift action_7
action_25 (38) = happyShift action_8
action_25 (4) = happyGoto action_41
action_25 (6) = happyGoto action_45
action_25 _ = happyReduce_33

action_26 (7) = happyShift action_2
action_26 (8) = happyShift action_4
action_26 (27) = happyShift action_5
action_26 (32) = happyShift action_6
action_26 (36) = happyShift action_7
action_26 (38) = happyShift action_8
action_26 (4) = happyGoto action_41
action_26 (6) = happyGoto action_44
action_26 _ = happyReduce_33

action_27 (7) = happyShift action_2
action_27 (8) = happyShift action_4
action_27 (27) = happyShift action_5
action_27 (32) = happyShift action_6
action_27 (36) = happyShift action_7
action_27 (38) = happyShift action_8
action_27 (4) = happyGoto action_41
action_27 (6) = happyGoto action_43
action_27 _ = happyReduce_33

action_28 (7) = happyShift action_2
action_28 (8) = happyShift action_4
action_28 (27) = happyShift action_5
action_28 (32) = happyShift action_6
action_28 (36) = happyShift action_7
action_28 (38) = happyShift action_8
action_28 (4) = happyGoto action_41
action_28 (6) = happyGoto action_42
action_28 _ = happyReduce_33

action_29 (7) = happyShift action_2
action_29 (8) = happyShift action_4
action_29 (27) = happyShift action_5
action_29 (32) = happyShift action_6
action_29 (36) = happyShift action_7
action_29 (38) = happyShift action_8
action_29 (4) = happyGoto action_40
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (7) = happyShift action_2
action_30 (8) = happyShift action_4
action_30 (27) = happyShift action_5
action_30 (32) = happyShift action_6
action_30 (36) = happyShift action_7
action_30 (38) = happyShift action_8
action_30 (4) = happyGoto action_39
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (27) = happyShift action_38
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (7) = happyShift action_2
action_32 (8) = happyShift action_4
action_32 (27) = happyShift action_5
action_32 (32) = happyShift action_6
action_32 (36) = happyShift action_7
action_32 (38) = happyShift action_8
action_32 (4) = happyGoto action_37
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (7) = happyShift action_2
action_33 (8) = happyShift action_4
action_33 (27) = happyShift action_5
action_33 (32) = happyShift action_6
action_33 (36) = happyShift action_7
action_33 (38) = happyShift action_8
action_33 (4) = happyGoto action_36
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (7) = happyShift action_2
action_34 (8) = happyShift action_4
action_34 (27) = happyShift action_5
action_34 (32) = happyShift action_6
action_34 (36) = happyShift action_7
action_34 (38) = happyShift action_8
action_34 (4) = happyGoto action_35
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (7) = happyShift action_2
action_35 (8) = happyShift action_4
action_35 (27) = happyShift action_5
action_35 (32) = happyShift action_6
action_35 (36) = happyShift action_7
action_35 (38) = happyShift action_8
action_35 (4) = happyGoto action_87
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (28) = happyShift action_86
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (28) = happyShift action_85
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (7) = happyShift action_2
action_38 (8) = happyShift action_4
action_38 (27) = happyShift action_5
action_38 (32) = happyShift action_6
action_38 (36) = happyShift action_7
action_38 (38) = happyShift action_8
action_38 (4) = happyGoto action_41
action_38 (6) = happyGoto action_84
action_38 _ = happyReduce_33

action_39 (7) = happyShift action_2
action_39 (8) = happyShift action_4
action_39 (27) = happyShift action_5
action_39 (32) = happyShift action_6
action_39 (36) = happyShift action_7
action_39 (38) = happyShift action_8
action_39 (4) = happyGoto action_83
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (28) = happyShift action_82
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (7) = happyShift action_2
action_41 (8) = happyShift action_4
action_41 (27) = happyShift action_5
action_41 (32) = happyShift action_6
action_41 (36) = happyShift action_7
action_41 (38) = happyShift action_8
action_41 (4) = happyGoto action_41
action_41 (6) = happyGoto action_81
action_41 _ = happyReduce_33

action_42 (28) = happyShift action_80
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (28) = happyShift action_79
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (28) = happyShift action_78
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (28) = happyShift action_77
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (28) = happyShift action_76
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (28) = happyShift action_75
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (28) = happyShift action_74
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (28) = happyShift action_73
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (28) = happyShift action_72
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (28) = happyShift action_71
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (28) = happyShift action_70
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (28) = happyShift action_69
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (28) = happyShift action_68
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (28) = happyShift action_67
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (28) = happyShift action_66
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (28) = happyShift action_65
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (28) = happyShift action_64
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (7) = happyShift action_2
action_59 (8) = happyShift action_4
action_59 (27) = happyShift action_5
action_59 (32) = happyShift action_6
action_59 (36) = happyShift action_7
action_59 (38) = happyShift action_8
action_59 (4) = happyGoto action_63
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_28

action_61 (7) = happyShift action_2
action_61 (8) = happyShift action_4
action_61 (27) = happyShift action_5
action_61 (32) = happyShift action_6
action_61 (36) = happyShift action_7
action_61 (38) = happyShift action_8
action_61 (4) = happyGoto action_9
action_61 (5) = happyGoto action_62
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_32

action_63 (28) = happyShift action_91
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_23

action_65 _ = happyReduce_4

action_66 _ = happyReduce_5

action_67 _ = happyReduce_6

action_68 _ = happyReduce_7

action_69 _ = happyReduce_8

action_70 _ = happyReduce_9

action_71 _ = happyReduce_10

action_72 _ = happyReduce_11

action_73 _ = happyReduce_13

action_74 _ = happyReduce_14

action_75 _ = happyReduce_15

action_76 _ = happyReduce_16

action_77 _ = happyReduce_17

action_78 _ = happyReduce_18

action_79 _ = happyReduce_19

action_80 _ = happyReduce_20

action_81 _ = happyReduce_34

action_82 _ = happyReduce_21

action_83 (7) = happyShift action_2
action_83 (8) = happyShift action_4
action_83 (27) = happyShift action_5
action_83 (32) = happyShift action_6
action_83 (36) = happyShift action_7
action_83 (38) = happyShift action_8
action_83 (4) = happyGoto action_90
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (28) = happyShift action_89
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_25

action_86 _ = happyReduce_26

action_87 (28) = happyShift action_88
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_30

action_89 (7) = happyShift action_2
action_89 (8) = happyShift action_4
action_89 (27) = happyShift action_5
action_89 (32) = happyShift action_6
action_89 (36) = happyShift action_7
action_89 (38) = happyShift action_8
action_89 (4) = happyGoto action_93
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (28) = happyShift action_92
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_12

action_92 _ = happyReduce_22

action_93 (30) = happyShift action_94
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (7) = happyShift action_2
action_94 (8) = happyShift action_4
action_94 (27) = happyShift action_5
action_94 (32) = happyShift action_6
action_94 (36) = happyShift action_7
action_94 (38) = happyShift action_8
action_94 (4) = happyGoto action_95
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (28) = happyShift action_96
action_95 _ = happyFail (happyExpListPerState 95)

action_96 _ = happyReduce_24

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

happyReduce_23 = happyReduce 4 4 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (App happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 9 4 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (CondElse happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 4 4 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Head happy_var_3
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 4 4 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Tail happy_var_3
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_2  4 happyReduction_27
happyReduction_27 _
	_
	 =  HappyAbsSyn4
		 (List []
	)

happyReduce_28 = happySpecReduce_3  4 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (List happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  4 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn4
		 (Nil
	)

happyReduce_30 = happyReduce 5 4 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Cons happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_1  5 happyReduction_31
happyReduction_31 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  5 happyReduction_32
happyReduction_32 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_0  6 happyReduction_33
happyReduction_33  =  HappyAbsSyn6
		 ([]
	)

happyReduce_34 = happySpecReduce_2  6 happyReduction_34
happyReduction_34 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 39 39 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenNum happy_dollar_dollar -> cont 7;
	TokenBool happy_dollar_dollar -> cont 8;
	TokenSum -> cont 9;
	TokenSub -> cont 10;
	TokenMult -> cont 11;
	TokenDiv -> cont 12;
	TokenAdd1 -> cont 13;
	TokenSub1 -> cont 14;
	TokenSqrt -> cont 15;
	TokenExpt -> cont 16;
	TokenFst -> cont 17;
	TokenSnd -> cont 18;
	TokenEq -> cont 19;
	TokenLt -> cont 20;
	TokenGt -> cont 21;
	TokenLeq -> cont 22;
	TokenGeq -> cont 23;
	TokenNeq -> cont 24;
	TokenNot -> cont 25;
	TokenIf -> cont 26;
	TokenPA -> cont 27;
	TokenPC -> cont 28;
	TokenCond -> cont 29;
	TokenElse -> cont 30;
	TokenComma -> cont 31;
	TokenCA -> cont 32;
	TokenCC -> cont 33;
	TokenHead -> cont 34;
	TokenTail -> cont 35;
	TokenNil -> cont 36;
	TokenCons -> cont 37;
	TokenVar happy_dollar_dollar -> cont 38;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 39 tk tks = happyError' (tks, explist)
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
    | Not ASA
    | If ASA ASA ASA



    --cosas con let
   -- | Let [(String, ASA)] ASA 
   -- | LetStar [(String, ASA)] ASA 
    | Var String
    -- app y cond
    | App ASA ASA 
    | CondElse [ASA] ASA ASA

    -- ==================
    -- listas
    -- ==================
    | List [ASA]
    | Tail ASA
    | Head ASA

    --nucleo
    | Nil
    | Cons ASA ASA
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
