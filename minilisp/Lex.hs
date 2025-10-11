{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
{-# OPTIONS_GHC -fno-warn-tabs #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE CPP #-}
{-# LINE 1 "Lex.x" #-}
module Lex (Token(..), lexer) where
import Data.Char (isSpace)
#include "ghcconfig.h"
import qualified Data.Array
import qualified Data.Char
#define ALEX_BASIC 1
-- -----------------------------------------------------------------------------
-- Alex wrapper code.
--
-- This code is in the PUBLIC DOMAIN; you may copy it freely and use
-- it for any purpose whatsoever.

#if defined(ALEX_MONAD) || defined(ALEX_MONAD_BYTESTRING) || defined(ALEX_MONAD_STRICT_TEXT)
import Control.Applicative as App (Applicative (..))
#endif

#if defined(ALEX_STRICT_TEXT) || defined (ALEX_POSN_STRICT_TEXT) || defined(ALEX_MONAD_STRICT_TEXT)
import qualified Data.Text
#endif

import Data.Word (Word8)

#if defined(ALEX_BASIC_BYTESTRING) || defined(ALEX_POSN_BYTESTRING) || defined(ALEX_MONAD_BYTESTRING)

import Data.Int (Int64)
import qualified Data.ByteString.Lazy     as ByteString
import qualified Data.ByteString.Internal as ByteString (w2c)

#elif defined(ALEX_STRICT_BYTESTRING)

import qualified Data.ByteString          as ByteString
import qualified Data.ByteString.Internal as ByteString hiding (ByteString)
import qualified Data.ByteString.Unsafe   as ByteString

#else

import qualified Data.Bits

-- | Encode a Haskell String to a list of Word8 values, in UTF8 format.
utf8Encode :: Char -> [Word8]
utf8Encode = uncurry (:) . utf8Encode'

utf8Encode' :: Char -> (Word8, [Word8])
utf8Encode' c = case go (Data.Char.ord c) of
                  (x, xs) -> (fromIntegral x, map fromIntegral xs)
 where
  go oc
   | oc <= 0x7f       = ( oc
                        , [
                        ])

   | oc <= 0x7ff      = ( 0xc0 + (oc `Data.Bits.shiftR` 6)
                        , [0x80 + oc Data.Bits..&. 0x3f
                        ])

   | oc <= 0xffff     = ( 0xe0 + (oc `Data.Bits.shiftR` 12)
                        , [0x80 + ((oc `Data.Bits.shiftR` 6) Data.Bits..&. 0x3f)
                        , 0x80 + oc Data.Bits..&. 0x3f
                        ])
   | otherwise        = ( 0xf0 + (oc `Data.Bits.shiftR` 18)
                        , [0x80 + ((oc `Data.Bits.shiftR` 12) Data.Bits..&. 0x3f)
                        , 0x80 + ((oc `Data.Bits.shiftR` 6) Data.Bits..&. 0x3f)
                        , 0x80 + oc Data.Bits..&. 0x3f
                        ])

#endif

type Byte = Word8

-- -----------------------------------------------------------------------------
-- The input type

#if defined(ALEX_POSN) || defined(ALEX_MONAD) || defined(ALEX_GSCAN)
type AlexInput = (AlexPosn,     -- current position,
                  Char,         -- previous char
                  [Byte],       -- pending bytes on current char
                  String)       -- current input string

ignorePendingBytes :: AlexInput -> AlexInput
ignorePendingBytes (p,c,_ps,s) = (p,c,[],s)

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (_p,c,_bs,_s) = c

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (p,c,(b:bs),s) = Just (b,(p,c,bs,s))
alexGetByte (_,_,[],[]) = Nothing
alexGetByte (p,_,[],(c:s))  = let p' = alexMove p c
                              in case utf8Encode' c of
                                   (b, bs) -> p' `seq`  Just (b, (p', c, bs, s))
#endif

#if defined (ALEX_STRICT_TEXT)
type AlexInput = (Char,           -- previous char
                  [Byte],         -- pending bytes on current char
                  Data.Text.Text) -- current input string

ignorePendingBytes :: AlexInput -> AlexInput
ignorePendingBytes (c,_ps,s) = (c,[],s)

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (c,_bs,_s) = c

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (c,(b:bs),s) = Just (b,(c,bs,s))
alexGetByte (_,[],s) = case Data.Text.uncons s of
                            Just (c, cs) ->
                              case utf8Encode' c of
                                (b, bs) -> Just (b, (c, bs, cs))
                            Nothing ->
                              Nothing
#endif

#if defined (ALEX_POSN_STRICT_TEXT) || defined(ALEX_MONAD_STRICT_TEXT)
type AlexInput = (AlexPosn,       -- current position,
                  Char,           -- previous char
                  [Byte],         -- pending bytes on current char
                  Data.Text.Text) -- current input string

ignorePendingBytes :: AlexInput -> AlexInput
ignorePendingBytes (p,c,_ps,s) = (p,c,[],s)

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (_p,c,_bs,_s) = c

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (p,c,(b:bs),s) = Just (b,(p,c,bs,s))
alexGetByte (p,_,[],s) = case Data.Text.uncons s of
                            Just (c, cs) ->
                              let p' = alexMove p c
                              in case utf8Encode' c of
                                   (b, bs) -> p' `seq`  Just (b, (p', c, bs, cs))
                            Nothing ->
                              Nothing
#endif

#if defined(ALEX_POSN_BYTESTRING) || defined(ALEX_MONAD_BYTESTRING)
type AlexInput = (AlexPosn,     -- current position,
                  Char,         -- previous char
                  ByteString.ByteString,        -- current input string
                  Int64)           -- bytes consumed so far

ignorePendingBytes :: AlexInput -> AlexInput
ignorePendingBytes i = i   -- no pending bytes when lexing bytestrings

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (_,c,_,_) = c

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (p,_,cs,n) =
    case ByteString.uncons cs of
        Nothing -> Nothing
        Just (b, cs') ->
            let c   = ByteString.w2c b
                p'  = alexMove p c
                n'  = n+1
            in p' `seq` cs' `seq` n' `seq` Just (b, (p', c, cs',n'))
#endif

#ifdef ALEX_BASIC_BYTESTRING
data AlexInput = AlexInput { alexChar :: {-# UNPACK #-} !Char,      -- previous char
                             alexStr ::  !ByteString.ByteString,    -- current input string
                             alexBytePos :: {-# UNPACK #-} !Int64}  -- bytes consumed so far

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar = alexChar

alexGetByte (AlexInput {alexStr=cs,alexBytePos=n}) =
    case ByteString.uncons cs of
        Nothing -> Nothing
        Just (c, rest) ->
            Just (c, AlexInput {
                alexChar = ByteString.w2c c,
                alexStr =  rest,
                alexBytePos = n+1})
#endif

#ifdef ALEX_STRICT_BYTESTRING
data AlexInput = AlexInput { alexChar :: {-# UNPACK #-} !Char,
                             alexStr :: {-# UNPACK #-} !ByteString.ByteString,
                             alexBytePos :: {-# UNPACK #-} !Int}

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar = alexChar

alexGetByte (AlexInput {alexStr=cs,alexBytePos=n}) =
    case ByteString.uncons cs of
        Nothing -> Nothing
        Just (c, rest) ->
            Just (c, AlexInput {
                alexChar = ByteString.w2c c,
                alexStr =  rest,
                alexBytePos = n+1})
#endif

-- -----------------------------------------------------------------------------
-- Token positions

-- `Posn' records the location of a token in the input text.  It has three
-- fields: the address (number of characters preceding the token), line number
-- and column of a token within the file. `start_pos' gives the position of the
-- start of the file and `eof_pos' a standard encoding for the end of file.
-- `move_pos' calculates the new position after traversing a given character,
-- assuming the usual eight character tab stops.

#if defined(ALEX_POSN) || defined(ALEX_MONAD) || defined(ALEX_POSN_BYTESTRING) || defined(ALEX_MONAD_BYTESTRING) || defined(ALEX_GSCAN) || defined (ALEX_POSN_STRICT_TEXT) || defined(ALEX_MONAD_STRICT_TEXT)
data AlexPosn = AlexPn !Int !Int !Int
        deriving (Eq, Show, Ord)

alexStartPos :: AlexPosn
alexStartPos = AlexPn 0 1 1

alexMove :: AlexPosn -> Char -> AlexPosn
alexMove (AlexPn a l c) '\t' = AlexPn (a+1)  l     (c+alex_tab_size-((c-1) `mod` alex_tab_size))
alexMove (AlexPn a l _) '\n' = AlexPn (a+1) (l+1)   1
alexMove (AlexPn a l c) _    = AlexPn (a+1)  l     (c+1)
#endif

-- -----------------------------------------------------------------------------
-- Monad (default and with ByteString input)

#if defined(ALEX_MONAD) || defined(ALEX_MONAD_BYTESTRING) || defined(ALEX_MONAD_STRICT_TEXT)
data AlexState = AlexState {
        alex_pos :: !AlexPosn,  -- position at current input location
#ifdef ALEX_MONAD_STRICT_TEXT
        alex_inp :: Data.Text.Text,
        alex_chr :: !Char,
        alex_bytes :: [Byte],
#endif /* ALEX_MONAD_STRICT_TEXT */
#ifdef ALEX_MONAD
        alex_inp :: String,     -- the current input
        alex_chr :: !Char,      -- the character before the input
        alex_bytes :: [Byte],
#endif /* ALEX_MONAD */
#ifdef ALEX_MONAD_BYTESTRING
        alex_bpos:: !Int64,     -- bytes consumed so far
        alex_inp :: ByteString.ByteString,      -- the current input
        alex_chr :: !Char,      -- the character before the input
#endif /* ALEX_MONAD_BYTESTRING */
        alex_scd :: !Int        -- the current startcode
#ifdef ALEX_MONAD_USER_STATE
      , alex_ust :: AlexUserState -- AlexUserState will be defined in the user program
#endif
    }

-- Compile with -funbox-strict-fields for best results!

#ifdef ALEX_MONAD
runAlex :: String -> Alex a -> Either String a
runAlex input__ (Alex f)
   = case f (AlexState {alex_bytes = [],
                        alex_pos = alexStartPos,
                        alex_inp = input__,
                        alex_chr = '\n',
#ifdef ALEX_MONAD_USER_STATE
                        alex_ust = alexInitUserState,
#endif
                        alex_scd = 0}) of Left msg -> Left msg
                                          Right ( _, a ) -> Right a
#endif

#ifdef ALEX_MONAD_BYTESTRING
runAlex :: ByteString.ByteString -> Alex a -> Either String a
runAlex input__ (Alex f)
   = case f (AlexState {alex_bpos = 0,
                        alex_pos = alexStartPos,
                        alex_inp = input__,
                        alex_chr = '\n',
#ifdef ALEX_MONAD_USER_STATE
                        alex_ust = alexInitUserState,
#endif
                        alex_scd = 0}) of Left msg -> Left msg
                                          Right ( _, a ) -> Right a
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
runAlex :: Data.Text.Text -> Alex a -> Either String a
runAlex input__ (Alex f)
   = case f (AlexState {alex_bytes = [],
                        alex_pos = alexStartPos,
                        alex_inp = input__,
                        alex_chr = '\n',
#ifdef ALEX_MONAD_USER_STATE
                        alex_ust = alexInitUserState,
#endif
                        alex_scd = 0}) of Left msg -> Left msg
                                          Right ( _, a ) -> Right a
#endif

newtype Alex a = Alex { unAlex :: AlexState -> Either String (AlexState, a) }

instance Functor Alex where
  fmap f a = Alex $ \s -> case unAlex a s of
                            Left msg -> Left msg
                            Right (s', a') -> Right (s', f a')

instance Applicative Alex where
  pure a   = Alex $ \s -> Right (s, a)
  fa <*> a = Alex $ \s -> case unAlex fa s of
                            Left msg -> Left msg
                            Right (s', f) -> case unAlex a s' of
                                               Left msg -> Left msg
                                               Right (s'', b) -> Right (s'', f b)

instance Monad Alex where
  m >>= k  = Alex $ \s -> case unAlex m s of
                                Left msg -> Left msg
                                Right (s',a) -> unAlex (k a) s'
  return = App.pure


#ifdef ALEX_MONAD
alexGetInput :: Alex AlexInput
alexGetInput
 = Alex $ \s@AlexState{alex_pos=pos,alex_chr=c,alex_bytes=bs,alex_inp=inp__} ->
        Right (s, (pos,c,bs,inp__))
#endif

#ifdef ALEX_MONAD_BYTESTRING
alexGetInput :: Alex AlexInput
alexGetInput
 = Alex $ \s@AlexState{alex_pos=pos,alex_bpos=bpos,alex_chr=c,alex_inp=inp__} ->
        Right (s, (pos,c,inp__,bpos))
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
alexGetInput :: Alex AlexInput
alexGetInput
 = Alex $ \s@AlexState{alex_pos=pos,alex_chr=c,alex_bytes=bs,alex_inp=inp__} ->
        Right (s, (pos,c,bs,inp__))
#endif

#ifdef ALEX_MONAD
alexSetInput :: AlexInput -> Alex ()
alexSetInput (pos,c,bs,inp__)
 = Alex $ \s -> case s{alex_pos=pos,alex_chr=c,alex_bytes=bs,alex_inp=inp__} of
                    state__@(AlexState{}) -> Right (state__, ())
#endif

#ifdef ALEX_MONAD_BYTESTRING
alexSetInput :: AlexInput -> Alex ()
alexSetInput (pos,c,inp__,bpos)
 = Alex $ \s -> case s{alex_pos=pos,
                       alex_bpos=bpos,
                       alex_chr=c,
                       alex_inp=inp__} of
                    state__@(AlexState{}) -> Right (state__, ())
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
alexSetInput :: AlexInput -> Alex ()
alexSetInput (pos,c,bs,inp__)
 = Alex $ \s -> case s{alex_pos=pos,alex_chr=c,alex_bytes=bs,alex_inp=inp__} of
                    state__@(AlexState{}) -> Right (state__, ())
#endif

alexError :: String -> Alex a
alexError message = Alex $ const $ Left message

alexGetStartCode :: Alex Int
alexGetStartCode = Alex $ \s@AlexState{alex_scd=sc} -> Right (s, sc)

alexSetStartCode :: Int -> Alex ()
alexSetStartCode sc = Alex $ \s -> Right (s{alex_scd=sc}, ())

#if defined(ALEX_MONAD_USER_STATE)
alexGetUserState :: Alex AlexUserState
alexGetUserState = Alex $ \s@AlexState{alex_ust=ust} -> Right (s,ust)

alexSetUserState :: AlexUserState -> Alex ()
alexSetUserState ss = Alex $ \s -> Right (s{alex_ust=ss}, ())
#endif /* defined(ALEX_MONAD_USER_STATE) */

#ifdef ALEX_MONAD
alexMonadScan = do
  inp__ <- alexGetInput
  sc <- alexGetStartCode
  case alexScan inp__ sc of
    AlexEOF -> alexEOF
    AlexError ((AlexPn _ line column),_,_,_) -> alexError $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
    AlexSkip  inp__' _len -> do
        alexSetInput inp__'
        alexMonadScan
    AlexToken inp__' len action -> do
        alexSetInput inp__'
        action (ignorePendingBytes inp__) len
#endif

#ifdef ALEX_MONAD_BYTESTRING
alexMonadScan = do
  inp__@(_,_,_,n) <- alexGetInput
  sc <- alexGetStartCode
  case alexScan inp__ sc of
    AlexEOF -> alexEOF
    AlexError ((AlexPn _ line column),_,_,_) -> alexError $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
    AlexSkip  inp__' _len -> do
        alexSetInput inp__'
        alexMonadScan
    AlexToken inp__'@(_,_,_,n') _ action -> let len = n'-n in do
        alexSetInput inp__'
        action (ignorePendingBytes inp__) len
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
alexMonadScan = do
  inp__ <- alexGetInput
  sc <- alexGetStartCode
  case alexScan inp__ sc of
    AlexEOF -> alexEOF
    AlexError ((AlexPn _ line column),_,_,_) -> alexError $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
    AlexSkip  inp__' _len -> do
        alexSetInput inp__'
        alexMonadScan
    AlexToken inp__' len action -> do
        alexSetInput inp__'
        action (ignorePendingBytes inp__) len
#endif

-- -----------------------------------------------------------------------------
-- Useful token actions

#ifdef ALEX_MONAD
type AlexAction result = AlexInput -> Int -> Alex result
#endif

#ifdef ALEX_MONAD_BYTESTRING
type AlexAction result = AlexInput -> Int64 -> Alex result
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
type AlexAction result = AlexInput -> Int -> Alex result
#endif

-- just ignore this token and scan another one
-- skip :: AlexAction result
skip _input _len = alexMonadScan

-- ignore this token, but set the start code to a new value
-- begin :: Int -> AlexAction result
begin code _input _len = do alexSetStartCode code; alexMonadScan

-- perform an action for this token, and set the start code to a new value
andBegin :: AlexAction result -> Int -> AlexAction result
(action `andBegin` code) input__ len = do
  alexSetStartCode code
  action input__ len

#ifdef ALEX_MONAD
token :: (AlexInput -> Int -> token) -> AlexAction token
token t input__ len = return (t input__ len)
#endif

#ifdef ALEX_MONAD_BYTESTRING
token :: (AlexInput -> Int64 -> token) -> AlexAction token
token t input__ len = return (t input__ len)
#endif

#ifdef ALEX_MONAD_STRICT_TEXT
token :: (AlexInput -> Int -> token) -> AlexAction token
token t input__ len = return (t input__ len)
#endif

#endif /* defined(ALEX_MONAD) || defined(ALEX_MONAD_BYTESTRING) || defined(ALEX_MONAD_STRICT_TEXT) */

-- -----------------------------------------------------------------------------
-- Basic wrapper

#ifdef ALEX_BASIC
type AlexInput = (Char,[Byte],String)

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (c,_,_) = c

-- alexScanTokens :: String -> [token]
alexScanTokens str = go ('\n',[],str)
  where go inp__@(_,_bs,s) =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError _ -> error "lexical error"
                AlexSkip  inp__' _ln     -> go inp__'
                AlexToken inp__' len act -> act (take len s) : go inp__'

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (c,(b:bs),s) = Just (b,(c,bs,s))
alexGetByte (_,[],[])    = Nothing
alexGetByte (_,[],(c:s)) = case utf8Encode' c of
                             (b, bs) -> Just (b, (c, bs, s))
#endif


-- -----------------------------------------------------------------------------
-- Basic wrapper, ByteString version

#ifdef ALEX_BASIC_BYTESTRING

-- alexScanTokens :: ByteString.ByteString -> [token]
alexScanTokens str = go (AlexInput '\n' str 0)
  where go inp__ =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError _ -> error "lexical error"
                AlexSkip  inp__' _len  -> go inp__'
                AlexToken inp__' _ act ->
                  let len = alexBytePos inp__' - alexBytePos inp__ in
                  act (ByteString.take len (alexStr inp__)) : go inp__'

#endif

#ifdef ALEX_STRICT_BYTESTRING

-- alexScanTokens :: ByteString.ByteString -> [token]
alexScanTokens str = go (AlexInput '\n' str 0)
  where go inp__ =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError _ -> error "lexical error"
                AlexSkip  inp__' _len  -> go inp__'
                AlexToken inp__' _ act ->
                  let len = alexBytePos inp__' - alexBytePos inp__ in
                  act (ByteString.take len (alexStr inp__)) : go inp__'

#endif

#ifdef ALEX_STRICT_TEXT
-- alexScanTokens :: Data.Text.Text -> [token]
alexScanTokens str = go ('\n',[],str)
  where go inp__@(_,_bs,s) =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError _ -> error "lexical error"
                AlexSkip  inp__' _len  -> go inp__'
                AlexToken inp__' len act -> act (Data.Text.take len s) : go inp__'
#endif

#ifdef ALEX_POSN_STRICT_TEXT
-- alexScanTokens :: Data.Text.Text -> [token]
alexScanTokens str = go (alexStartPos,'\n',[],str)
  where go inp__@(pos,_,_bs,s) =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError ((AlexPn _ line column),_,_,_) -> error $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
                AlexSkip  inp__' _len  -> go inp__'
                AlexToken inp__' len act -> act pos (Data.Text.take len s) : go inp__'
#endif


-- -----------------------------------------------------------------------------
-- Posn wrapper

-- Adds text positions to the basic model.

#ifdef ALEX_POSN
--alexScanTokens :: String -> [token]
alexScanTokens str0 = go (alexStartPos,'\n',[],str0)
  where go inp__@(pos,_,_,str) =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError ((AlexPn _ line column),_,_,_) -> error $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
                AlexSkip  inp__' _ln     -> go inp__'
                AlexToken inp__' len act -> act pos (take len str) : go inp__'
#endif


-- -----------------------------------------------------------------------------
-- Posn wrapper, ByteString version

#ifdef ALEX_POSN_BYTESTRING
--alexScanTokens :: ByteString.ByteString -> [token]
alexScanTokens str0 = go (alexStartPos,'\n',str0,0)
  where go inp__@(pos,_,str,n) =
          case alexScan inp__ 0 of
                AlexEOF -> []
                AlexError ((AlexPn _ line column),_,_,_) -> error $ "lexical error at line " ++ (show line) ++ ", column " ++ (show column)
                AlexSkip  inp__' _len       -> go inp__'
                AlexToken inp__'@(_,_,_,n') _ act ->
                  act pos (ByteString.take (n'-n) str) : go inp__'
#endif


-- -----------------------------------------------------------------------------
-- GScan wrapper

-- For compatibility with previous versions of Alex, and because we can.

#ifdef ALEX_GSCAN
alexGScan stop__ state__ inp__ =
  alex_gscan stop__ alexStartPos '\n' [] inp__ (0,state__)

alex_gscan stop__ p c bs inp__ (sc,state__) =
  case alexScan (p,c,bs,inp__) sc of
        AlexEOF     -> stop__ p c inp__ (sc,state__)
        AlexError _ -> stop__ p c inp__ (sc,state__)
        AlexSkip (p',c',bs',inp__') _len ->
          alex_gscan stop__ p' c' bs' inp__' (sc,state__)
        AlexToken (p',c',bs',inp__') len k ->
           k p c inp__ len (\scs -> alex_gscan stop__ p' c' bs' inp__' scs)                  (sc,state__)
#endif
alex_tab_size :: Int
alex_tab_size = 8
alex_base :: Data.Array.Array Int Int
alex_base = Data.Array.listArray (0 :: Int, 56)
  [ 1
  , 81
  , 198
  , 273
  , 348
  , 78
  , 0
  , 0
  , 0
  , 0
  , 79
  , 80
  , 423
  , 498
  , 573
  , 648
  , 0
  , 723
  , 798
  , 873
  , 40
  , 0
  , 948
  , 1023
  , 0
  , 1146
  , 1082
  , 0
  , 0
  , 1210
  , 1338
  , 1546
  , 1621
  , 1696
  , 1771
  , 1846
  , 1921
  , 1996
  , 2071
  , 2146
  , 2126
  , 2191
  , 0
  , 0
  , 134
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 2399
  , 2474
  , 2549
  , 2624
  , 2699
  , 2774
  ]

alex_table :: Data.Array.Array Int Int
alex_table = Data.Array.listArray (0 :: Int, 3029)
  [ 0
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 44
  , 44
  , 44
  , 44
  , 44
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 27
  , 44
  , 5
  , 27
  , 20
  , 27
  , 27
  , 27
  , 27
  , 45
  , 46
  , 49
  , 47
  , 24
  , 48
  , 27
  , 50
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 27
  , 27
  , 10
  , 9
  , 11
  , 27
  , 27
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 14
  , 23
  , 23
  , 23
  , 17
  , 19
  , 23
  , 23
  , 23
  , 23
  , 23
  , 32
  , 23
  , 36
  , 23
  , 23
  , 23
  , 23
  , 35
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 27
  , 27
  , 27
  , 27
  , 27
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 1
  , 6
  , 7
  , 8
  , 21
  , 44
  , 44
  , 44
  , 44
  , 44
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 16
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 44
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 25
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 26
  , 29
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 41
  , 30
  , 43
  , 43
  , 43
  , 40
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 3
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 13
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 15
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 52
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 18
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 33
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 2
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 25
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 28
  , 29
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 42
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 22
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 31
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 56
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 55
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 37
  , 23
  , 23
  , 34
  , 23
  , 23
  , 23
  , 39
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 12
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 4
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 53
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 38
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 41
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 26
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 51
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 54
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 23
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  , 0
  ]

alex_check :: Data.Array.Array Int Int
alex_check = Data.Array.listArray (0 :: Int, 3029)
  [ -1
  , 0
  , 1
  , 2
  , 3
  , 4
  , 5
  , 6
  , 7
  , 8
  , 9
  , 10
  , 11
  , 12
  , 13
  , 14
  , 15
  , 16
  , 17
  , 18
  , 19
  , 20
  , 21
  , 22
  , 23
  , 24
  , 25
  , 26
  , 27
  , 28
  , 29
  , 30
  , 31
  , 32
  , 33
  , 34
  , 35
  , 36
  , 37
  , 38
  , 39
  , 40
  , 41
  , 42
  , 43
  , 44
  , 45
  , 46
  , 47
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , 58
  , 59
  , 60
  , 61
  , 62
  , 63
  , 64
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , 91
  , 92
  , 93
  , 94
  , 95
  , 96
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 123
  , 124
  , 125
  , 126
  , 127
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , 61
  , 61
  , 61
  , 102
  , 9
  , 10
  , 11
  , 12
  , 13
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 116
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 32
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 0
  , 1
  , 2
  , 3
  , 4
  , 5
  , 6
  , 7
  , 8
  , 9
  , 10
  , 11
  , 12
  , 13
  , 14
  , 15
  , 16
  , 17
  , 18
  , 19
  , 20
  , 21
  , 22
  , 23
  , 24
  , 25
  , 26
  , 27
  , 28
  , 29
  , 30
  , 31
  , 32
  , 33
  , 34
  , 35
  , 36
  , 37
  , 38
  , 39
  , 40
  , 41
  , 42
  , 43
  , 44
  , 45
  , 46
  , 47
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , 58
  , 59
  , 60
  , 61
  , 62
  , 63
  , 64
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , 91
  , 92
  , 93
  , 94
  , 95
  , 96
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 123
  , 124
  , 125
  , 126
  , 127
  , 192
  , 193
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 245
  , 246
  , 247
  , 248
  , 249
  , 250
  , 251
  , 252
  , 253
  , 254
  , 255
  , 128
  , 129
  , 130
  , 131
  , 132
  , 133
  , 134
  , 135
  , 136
  , 137
  , 138
  , 139
  , 140
  , 141
  , 142
  , 143
  , 144
  , 145
  , 146
  , 147
  , 148
  , 149
  , 150
  , 151
  , 152
  , 153
  , 154
  , 155
  , 156
  , 157
  , 158
  , 159
  , 160
  , 161
  , 162
  , 163
  , 164
  , 165
  , 166
  , 167
  , 168
  , 169
  , 170
  , 171
  , 172
  , 173
  , 174
  , 175
  , 176
  , 177
  , 178
  , 179
  , 180
  , 181
  , 182
  , 183
  , 184
  , 185
  , 186
  , 187
  , 188
  , 189
  , 190
  , 191
  , 192
  , 193
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 245
  , 246
  , 247
  , 248
  , 249
  , 250
  , 251
  , 252
  , 253
  , 254
  , 255
  , 128
  , 129
  , 130
  , 131
  , 132
  , 133
  , 134
  , 135
  , 136
  , 137
  , 138
  , 139
  , 140
  , 141
  , 142
  , 143
  , 144
  , 145
  , 146
  , 147
  , 148
  , 149
  , 150
  , 151
  , 152
  , 153
  , 154
  , 155
  , 156
  , 157
  , 158
  , 159
  , 160
  , 161
  , 162
  , 163
  , 164
  , 165
  , 166
  , 167
  , 168
  , 169
  , 170
  , 171
  , 172
  , 173
  , 174
  , 175
  , 176
  , 177
  , 178
  , 179
  , 180
  , 181
  , 182
  , 183
  , 184
  , 185
  , 186
  , 187
  , 188
  , 189
  , 190
  , 191
  , 192
  , 193
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 245
  , 246
  , 247
  , 248
  , 249
  , 250
  , 251
  , 252
  , 253
  , 254
  , 255
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 143
  , 144
  , 145
  , 146
  , 147
  , 148
  , 149
  , 150
  , 151
  , 152
  , 153
  , 154
  , 155
  , 156
  , 157
  , 158
  , 159
  , 160
  , 161
  , 162
  , 163
  , 164
  , 165
  , 166
  , 167
  , 168
  , 169
  , 170
  , 171
  , 172
  , 173
  , 174
  , 175
  , 176
  , 177
  , 178
  , 179
  , 180
  , 181
  , 182
  , 183
  , 184
  , 185
  , 186
  , 187
  , 188
  , 189
  , 190
  , 191
  , 192
  , 193
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 245
  , 246
  , 247
  , 248
  , 249
  , 250
  , 251
  , 252
  , 253
  , 254
  , 255
  , 191
  , 192
  , 193
  , 194
  , 195
  , 196
  , 197
  , 198
  , 199
  , 200
  , 201
  , 202
  , 203
  , 204
  , 205
  , 206
  , 207
  , 208
  , 209
  , 210
  , 211
  , 212
  , 213
  , 214
  , 215
  , 216
  , 217
  , 218
  , 219
  , 220
  , 221
  , 222
  , 223
  , 224
  , 225
  , 226
  , 227
  , 228
  , 229
  , 230
  , 231
  , 232
  , 233
  , 234
  , 235
  , 236
  , 237
  , 238
  , 239
  , 240
  , 241
  , 242
  , 243
  , 244
  , 245
  , 246
  , 247
  , 248
  , 249
  , 250
  , 251
  , 252
  , 253
  , 254
  , 255
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , 48
  , 49
  , 50
  , 51
  , 52
  , 53
  , 54
  , 55
  , 56
  , 57
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 65
  , 66
  , 67
  , 68
  , 69
  , 70
  , 71
  , 72
  , 73
  , 74
  , 75
  , 76
  , 77
  , 78
  , 79
  , 80
  , 81
  , 82
  , 83
  , 84
  , 85
  , 86
  , 87
  , 88
  , 89
  , 90
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 97
  , 98
  , 99
  , 100
  , 101
  , 102
  , 103
  , 104
  , 105
  , 106
  , 107
  , 108
  , 109
  , 110
  , 111
  , 112
  , 113
  , 114
  , 115
  , 116
  , 117
  , 118
  , 119
  , 120
  , 121
  , 122
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  ]

alex_deflt :: Data.Array.Array Int Int
alex_deflt = Data.Array.listArray (0 :: Int, 56)
  [ -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 27
  , 27
  , -1
  , 27
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , 42
  , 28
  , 28
  , 42
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  , -1
  ]

alex_accept = Data.Array.listArray (0 :: Int, 56)
  [ AlexAccNone
  , AlexAcc 45
  , AlexAcc 44
  , AlexAcc 43
  , AlexAcc 42
  , AlexAcc 41
  , AlexAcc 40
  , AlexAcc 39
  , AlexAcc 38
  , AlexAcc 37
  , AlexAcc 36
  , AlexAcc 35
  , AlexAcc 34
  , AlexAcc 33
  , AlexAcc 32
  , AlexAcc 31
  , AlexAcc 30
  , AlexAcc 29
  , AlexAcc 28
  , AlexAcc 27
  , AlexAcc 26
  , AlexAcc 25
  , AlexAcc 24
  , AlexAcc 23
  , AlexAcc 22
  , AlexAccNone
  , AlexAccNone
  , AlexAcc 21
  , AlexAccNone
  , AlexAccNone
  , AlexAccNone
  , AlexAcc 20
  , AlexAcc 19
  , AlexAcc 18
  , AlexAcc 17
  , AlexAcc 16
  , AlexAcc 15
  , AlexAcc 14
  , AlexAcc 13
  , AlexAcc 12
  , AlexAccNone
  , AlexAccNone
  , AlexAccNone
  , AlexAccNone
  , AlexAccSkip
  , AlexAcc 11
  , AlexAcc 10
  , AlexAcc 9
  , AlexAcc 8
  , AlexAcc 7
  , AlexAcc 6
  , AlexAcc 5
  , AlexAcc 4
  , AlexAcc 3
  , AlexAcc 2
  , AlexAcc 1
  , AlexAcc 0
  ]

alex_actions = Data.Array.array (0 :: Int, 46)
  [ (45,alex_action_11)
  , (44,alex_action_24)
  , (43,alex_action_12)
  , (42,alex_action_13)
  , (41,alex_action_26)
  , (40,alex_action_14)
  , (39,alex_action_15)
  , (38,alex_action_16)
  , (37,alex_action_17)
  , (36,alex_action_18)
  , (35,alex_action_19)
  , (34,alex_action_24)
  , (33,alex_action_20)
  , (32,alex_action_24)
  , (31,alex_action_24)
  , (30,alex_action_21)
  , (29,alex_action_24)
  , (28,alex_action_24)
  , (27,alex_action_24)
  , (26,alex_action_26)
  , (25,alex_action_22)
  , (24,alex_action_23)
  , (23,alex_action_24)
  , (22,alex_action_25)
  , (21,alex_action_26)
  , (20,alex_action_24)
  , (19,alex_action_24)
  , (18,alex_action_24)
  , (17,alex_action_24)
  , (16,alex_action_24)
  , (15,alex_action_24)
  , (14,alex_action_24)
  , (13,alex_action_24)
  , (12,alex_action_24)
  , (11,alex_action_1)
  , (10,alex_action_2)
  , (9,alex_action_3)
  , (8,alex_action_4)
  , (7,alex_action_5)
  , (6,alex_action_6)
  , (5,alex_action_7)
  , (4,alex_action_24)
  , (3,alex_action_8)
  , (2,alex_action_9)
  , (1,alex_action_24)
  , (0,alex_action_10)
  ]

alex_action_1 = \_ -> TokenPA
alex_action_2 = \_ -> TokenPC
alex_action_3 = \_ -> TokenSum
alex_action_4 = \_ -> TokenSub
alex_action_5 = \_ -> TokenMult
alex_action_6 = \_ -> TokenDiv
alex_action_7 = \_ -> TokenAdd1
alex_action_8 = \_ -> TokenSub1
alex_action_9 = \_ -> TokenSqrt
alex_action_10 = \_ -> TokenExpt
alex_action_11 = \s -> TokenNum (read s)
alex_action_12 = \_ -> TokenFst
alex_action_13 = \_ -> TokenSnd
alex_action_14 = \_ -> TokenNeq
alex_action_15 = \_ -> TokenLeq
alex_action_16 = \_ -> TokenGeq
alex_action_17 = \_ -> TokenEq
alex_action_18 = \_ -> TokenLt
alex_action_19 = \_ -> TokenGt
alex_action_20 = \_ -> TokenNot
alex_action_21 = \_ -> TokenBool True
alex_action_22 = \_ -> TokenBool False
alex_action_23 = \_ -> TokenLet
alex_action_24 = \s -> TokenVar s
alex_action_25 = \_ -> TokenComma
alex_action_26 = \s -> error ("Lexical error: caracter no reconocido = "
                                    ++ show s
                                    ++ " | codepoints = "
                                    ++ show (map fromEnum s))

#define ALEX_NOPRED 1
-- -----------------------------------------------------------------------------
-- ALEX TEMPLATE
--
-- This code is in the PUBLIC DOMAIN; you may copy it freely and use
-- it for any purpose whatsoever.

-- -----------------------------------------------------------------------------
-- INTERNALS and main scanner engine

#ifdef ALEX_GHC
#  define ILIT(n) n#
#  define IBOX(n) (I# (n))
#  define FAST_INT Int#
-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#  if __GLASGOW_HASKELL__ > 706
#    define CMP_GEQ(n,m) (((n) >=# (m)) :: Int#)
#    define CMP_EQ(n,m) (((n) ==# (m)) :: Int#)
#    define CMP_MKBOOL(x) ((GHC.Exts.tagToEnum# (x)) :: Bool)
#  else
#    define CMP_GEQ(n,m) (((n) >= (m)) :: Bool)
#    define CMP_EQ(n,m) (((n) == (m)) :: Bool)
#    define CMP_MKBOOL(x) ((x) :: Bool)
#  endif
#  define GTE(n,m) CMP_MKBOOL(CMP_GEQ(n,m))
#  define EQ(n,m) CMP_MKBOOL(CMP_EQ(n,m))
#  define PLUS(n,m) (n +# m)
#  define MINUS(n,m) (n -# m)
#  define TIMES(n,m) (n *# m)
#  define NEGATE(n) (negateInt# (n))
#  define IF_GHC(x) (x)
#else
#  define ILIT(n) (n)
#  define IBOX(n) (n)
#  define FAST_INT Int
#  define GTE(n,m) (n >= m)
#  define EQ(n,m) (n == m)
#  define PLUS(n,m) (n + m)
#  define MINUS(n,m) (n - m)
#  define TIMES(n,m) (n * m)
#  define NEGATE(n) (negate (n))
#  define IF_GHC(x)
#endif

#ifdef ALEX_GHC
data AlexAddr = AlexA# Addr#
-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.

{-# INLINE alexIndexInt16OffAddr #-}
alexIndexInt16OffAddr :: AlexAddr -> Int# -> Int#
alexIndexInt16OffAddr (AlexA# arr) off =
#if __GLASGOW_HASKELL__ >= 901
  GHC.Exts.int16ToInt# -- qualified import because it doesn't exist on older GHC's
#endif
#ifdef WORDS_BIGENDIAN
  (GHC.Exts.word16ToInt16# (GHC.Exts.wordToWord16# (GHC.Exts.byteSwap16# (GHC.Exts.word16ToWord# (GHC.Exts.int16ToWord16#
#endif
  (indexInt16OffAddr# arr off)
#ifdef WORDS_BIGENDIAN
  )))))
#endif
#else
alexIndexInt16OffAddr = (Data.Array.!)
#endif

#ifdef ALEX_GHC
{-# INLINE alexIndexInt32OffAddr #-}
alexIndexInt32OffAddr :: AlexAddr -> Int# -> Int#
alexIndexInt32OffAddr (AlexA# arr) off =
#if __GLASGOW_HASKELL__ >= 901
  GHC.Exts.int32ToInt# -- qualified import because it doesn't exist on older GHC's
#endif
#ifdef WORDS_BIGENDIAN
  (GHC.Exts.word32ToInt32# (GHC.Exts.wordToWord32# (GHC.Exts.byteSwap32# (GHC.Exts.word32ToWord# (GHC.Exts.int32ToWord32#
#endif
  (indexInt32OffAddr# arr off)
#ifdef WORDS_BIGENDIAN
  )))))
#endif
#else
alexIndexInt32OffAddr = (Data.Array.!)
#endif

#ifdef ALEX_GHC
-- GHC >= 503, unsafeAt is available from Data.Array.Base.
quickIndex = unsafeAt
#else
quickIndex = (Data.Array.!)
#endif

-- -----------------------------------------------------------------------------
-- Main lexing routines

data AlexReturn a
  = AlexEOF
  | AlexError  !AlexInput
  | AlexSkip   !AlexInput !Int
  | AlexToken  !AlexInput !Int a

-- alexScan :: AlexInput -> StartCode -> AlexReturn a
alexScan input__ IBOX(sc)
  = alexScanUser (error "alex rule requiring context was invoked by alexScan; use alexScanUser instead?") input__ IBOX(sc)

-- If the generated alexScan/alexScanUser functions are called multiple times
-- in the same file, alexScanUser gets broken out into a separate function and
-- increases memory usage. Make sure GHC inlines this function and optimizes it.
{-# INLINE alexScanUser #-}

alexScanUser user__ input__ IBOX(sc)
  = case alex_scan_tkn user__ input__ ILIT(0) input__ sc AlexNone of
  (AlexNone, input__') ->
    case alexGetByte input__ of
      Nothing ->
#ifdef ALEX_DEBUG
                                   Debug.Trace.trace ("End of input.") $
#endif
                                   AlexEOF
      Just _ ->
#ifdef ALEX_DEBUG
                                   Debug.Trace.trace ("Error.") $
#endif
                                   AlexError input__'

  (AlexLastSkip input__'' len, _) ->
#ifdef ALEX_DEBUG
    Debug.Trace.trace ("Skipping.") $
#endif
    AlexSkip input__'' len

  (AlexLastAcc k input__''' len, _) ->
#ifdef ALEX_DEBUG
    Debug.Trace.trace ("Accept.") $
#endif
    AlexToken input__''' len ((Data.Array.!) alex_actions k)


-- Push the input through the DFA, remembering the most recent accepting
-- state it encountered.

alex_scan_tkn user__ orig_input len input__ s last_acc =
  input__ `seq` -- strict in the input
  let
  new_acc = (check_accs (alex_accept `quickIndex` IBOX(s)))
  in
  new_acc `seq`
  case alexGetByte input__ of
     Nothing -> (new_acc, input__)
     Just (c, new_input) ->
#ifdef ALEX_DEBUG
      Debug.Trace.trace ("State: " ++ show IBOX(s) ++ ", char: " ++ show c ++ " " ++ (show . Data.Char.chr . fromIntegral) c) $
#endif
      case fromIntegral c of { IBOX(ord_c) ->
        let
                base   = alexIndexInt32OffAddr alex_base s
                offset = PLUS(base,ord_c)

                new_s = if GTE(offset,ILIT(0))
                          && let check  = alexIndexInt16OffAddr alex_check offset
                             in  EQ(check,ord_c)
                          then alexIndexInt16OffAddr alex_table offset
                          else alexIndexInt16OffAddr alex_deflt s
        in
        case new_s of
            ILIT(-1) -> (new_acc, input__)
                -- on an error, we want to keep the input *before* the
                -- character that failed, not after.
            _ -> alex_scan_tkn user__ orig_input
#ifdef ALEX_LATIN1
                   PLUS(len,ILIT(1))
                   -- issue 119: in the latin1 encoding, *each* byte is one character
#else
                   (if c < 0x80 || c >= 0xC0 then PLUS(len,ILIT(1)) else len)
                   -- note that the length is increased ONLY if this is the 1st byte in a char encoding)
#endif
                   new_input new_s new_acc
      }
  where
        check_accs (AlexAccNone) = last_acc
        check_accs (AlexAcc a  ) = AlexLastAcc a input__ IBOX(len)
        check_accs (AlexAccSkip) = AlexLastSkip  input__ IBOX(len)
#ifndef ALEX_NOPRED
        check_accs (AlexAccPred a predx rest)
           | predx user__ orig_input IBOX(len) input__
           = AlexLastAcc a input__ IBOX(len)
           | otherwise
           = check_accs rest
        check_accs (AlexAccSkipPred predx rest)
           | predx user__ orig_input IBOX(len) input__
           = AlexLastSkip input__ IBOX(len)
           | otherwise
           = check_accs rest
#endif

data AlexLastAcc
  = AlexNone
  | AlexLastAcc !Int !AlexInput !Int
  | AlexLastSkip     !AlexInput !Int

data AlexAcc user
  = AlexAccNone
  | AlexAcc Int
  | AlexAccSkip
#ifndef ALEX_NOPRED
  | AlexAccPred Int (AlexAccPred user) (AlexAcc user)
  | AlexAccSkipPred (AlexAccPred user) (AlexAcc user)

type AlexAccPred user = user -> AlexInput -> Int -> AlexInput -> Bool

-- -----------------------------------------------------------------------------
-- Predicates on a rule

alexAndPred p1 p2 user__ in1 len in2
  = p1 user__ in1 len in2 && p2 user__ in1 len in2

--alexPrevCharIsPred :: Char -> AlexAccPred _
alexPrevCharIs c _ input__ _ _ = c == alexInputPrevChar input__

alexPrevCharMatches f _ input__ _ _ = f (alexInputPrevChar input__)

--alexPrevCharIsOneOfPred :: Array Char Bool -> AlexAccPred _
alexPrevCharIsOneOf arr _ input__ _ _ = arr Data.Array.! alexInputPrevChar input__

--alexRightContext :: Int -> AlexAccPred _
alexRightContext IBOX(sc) user__ _ _ input__ =
     case alex_scan_tkn user__ input__ ILIT(0) input__ sc AlexNone of
          (AlexNone, _) -> False
          _ -> True
        -- TODO: there's no need to find the longest
        -- match when checking the right context, just
        -- the first match will do.
#endif
{-# LINE 78 "Lex.x" #-}
data Token 
    = TokenNum Int
    | TokenBool Bool
    -- ==================
    -- aritmeticos
    -- ==================
    | TokenSum
    | TokenSub
    | TokenMult
    | TokenDiv
    | TokenAdd1
    | TokenSub1
    | TokenSqrt
    | TokenExpt

    -- ==================
    -- pares ordenados
    -- ==================
    | TokenFst
    | TokenSnd

    -- ==================
    -- comparadores
    -- ==================
    | TokenEq   -- =
    | TokenLt   -- <
    | TokenGt   -- >
    | TokenLeq  -- <=
    | TokenGeq  -- >=
    | TokenNeq  -- !=

    -- ==================
    -- logicos
    -- ==================
    | TokenNot          
    | TokenPA          
    | TokenPC         



    -- ==================
    -- funciones
    -- ==================
    -- relacionado con let
    | TokenLet
    | TokenVar String
    -- ==================
    -- otros 
    -- ==================
    | TokenComma

    deriving (Show)

normalizeSpaces :: String -> String
normalizeSpaces = map (\c -> if isSpace c then '\x20' else c)

-- usamos la funcion de Alex: alexScanTokens que es la que usa nuestros tokens
-- y cuando recibe un string recorre el string y va creando los tokens

-- Nota: esta funcion se obtiene gracias a %wrapper
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
