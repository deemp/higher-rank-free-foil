-- File generated by the BNF Converter (bnfc 2.9.6).

{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PatternSynonyms #-}

-- | The abstract syntax of language Syntax.

module Language.ModularSTLC.Syntax.Abs where

import Prelude (Integer, String)
import qualified Prelude as C
  ( Eq, Ord, Show, Read
  , Functor, Foldable, Traversable
  , Int, Maybe(..)
  )
import qualified Data.String

import qualified Data.Data    as C (Data, Typeable)
import qualified GHC.Generics as C (Generic)

type Program = Program' BNFC'Position
data Program' a = Program a [Statement' a]
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type ImportItem = ImportItem' BNFC'Position
data ImportItem' a
    = ImportItemGlob a
    | ImportItemGlobAs a ModuleName
    | ImportItemNames a [ImportItemName' a]
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type ImportItemName = ImportItemName' BNFC'Position
data ImportItemName' a
    = ImportItemNameModule a ModuleName | ImportItemNameVar a Var
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Location = Location' BNFC'Position
data Location' a
    = LocationLocal a ModuleName | LocationPath a String
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Statement = Statement' BNFC'Position
data Statement' a
    = StatementModule a ModuleName [Statement' a]
    | StatementImportLocal a (ImportItem' a) (Location' a)
    | StatementFunSig a Var (Type' a)
    | StatementFun a Var (Exp' a)
    | StatementFunWhere a Var (Exp' a) [Statement' a]
    | StatementExport a [ExportItem' a]
    | StatementCommandTypeCheck a (ExpUnderCtx' a) (Type' a)
    | StatementCommandTypeSynth a (ExpUnderCtx' a) (SynthResult' a)
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type ExportItem = ExportItem' BNFC'Position
data ExportItem' a
    = ExportItemModuleName a ModuleName | ExportItemVar a Var
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type SynthResult = SynthResult' BNFC'Position
data SynthResult' a
    = SynthResultType a (Type' a) | SynthResultUnknown a
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Exp = Exp' BNFC'Position
data Exp' a
    = ExpApp a (Exp' a) (Exp' a)
    | ExpAbs a Var (Exp' a)
    | ExpPlus a (Exp' a) (Exp' a)
    | ExpVar a Var
    | ExpNumber a Integer
    | ExpAccessor a [Accessor' a]
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Accessor = Accessor' BNFC'Position
data Accessor' a
    = AccessorModuleName a ModuleName | AccessorVar a Var
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Type = Type' BNFC'Position
data Type' a = TypeUnit a | TypeFunc a (Type' a) (Type' a)
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type CtxVar = CtxVar' BNFC'Position
data CtxVar' a = CtxVar a Var (Type' a)
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type Ctx = Ctx' BNFC'Position
data Ctx' a = Ctx a [CtxVar' a]
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

type ExpUnderCtx = ExpUnderCtx' BNFC'Position
data ExpUnderCtx' a = ExpUnderCtx a (Ctx' a) (Exp' a)
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Functor, C.Foldable, C.Traversable, C.Data, C.Typeable, C.Generic)

newtype Var = Var String
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Data, C.Typeable, C.Generic, Data.String.IsString)

newtype ModuleName = ModuleName String
  deriving (C.Eq, C.Ord, C.Show, C.Read, C.Data, C.Typeable, C.Generic, Data.String.IsString)

-- | Start position (line, column) of something.

type BNFC'Position = C.Maybe (C.Int, C.Int)

pattern BNFC'NoPosition :: BNFC'Position
pattern BNFC'NoPosition = C.Nothing

pattern BNFC'Position :: C.Int -> C.Int -> BNFC'Position
pattern BNFC'Position line col = C.Just (line, col)

-- | Get the start position of something.

class HasPosition a where
  hasPosition :: a -> BNFC'Position

instance HasPosition Program where
  hasPosition = \case
    Program p _ -> p

instance HasPosition ImportItem where
  hasPosition = \case
    ImportItemGlob p -> p
    ImportItemGlobAs p _ -> p
    ImportItemNames p _ -> p

instance HasPosition ImportItemName where
  hasPosition = \case
    ImportItemNameModule p _ -> p
    ImportItemNameVar p _ -> p

instance HasPosition Location where
  hasPosition = \case
    LocationLocal p _ -> p
    LocationPath p _ -> p

instance HasPosition Statement where
  hasPosition = \case
    StatementModule p _ _ -> p
    StatementImportLocal p _ _ -> p
    StatementFunSig p _ _ -> p
    StatementFun p _ _ -> p
    StatementFunWhere p _ _ _ -> p
    StatementExport p _ -> p
    StatementCommandTypeCheck p _ _ -> p
    StatementCommandTypeSynth p _ _ -> p

instance HasPosition ExportItem where
  hasPosition = \case
    ExportItemModuleName p _ -> p
    ExportItemVar p _ -> p

instance HasPosition SynthResult where
  hasPosition = \case
    SynthResultType p _ -> p
    SynthResultUnknown p -> p

instance HasPosition Exp where
  hasPosition = \case
    ExpApp p _ _ -> p
    ExpAbs p _ _ -> p
    ExpPlus p _ _ -> p
    ExpVar p _ -> p
    ExpNumber p _ -> p
    ExpAccessor p _ -> p

instance HasPosition Accessor where
  hasPosition = \case
    AccessorModuleName p _ -> p
    AccessorVar p _ -> p

instance HasPosition Type where
  hasPosition = \case
    TypeUnit p -> p
    TypeFunc p _ _ -> p

instance HasPosition CtxVar where
  hasPosition = \case
    CtxVar p _ _ -> p

instance HasPosition Ctx where
  hasPosition = \case
    Ctx p _ -> p

instance HasPosition ExpUnderCtx where
  hasPosition = \case
    ExpUnderCtx p _ _ -> p

