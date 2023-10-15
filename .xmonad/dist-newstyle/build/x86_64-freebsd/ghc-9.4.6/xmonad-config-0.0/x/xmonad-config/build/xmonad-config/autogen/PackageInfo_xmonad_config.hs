{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_xmonad_config (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "xmonad_config"
version :: Version
version = Version [0,0] []

synopsis :: String
synopsis = "XMonad Config File"
copyright :: String
copyright = "Copyright (c) 2016,2017 Peter J. Jones"
homepage :: String
homepage = "http://xmonad.org"
