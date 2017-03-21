-- default desktop configuration for Fedora
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)

import System.IO

myWorkspaces = ["1:code", "2:web", "3:chat", "4:misc"] ++ map show [5 .. 10]

myTerminal :: [Char]
myBorderWidth :: Dimension
myNormalBorderColor :: [Char]
myFocusedBorderColor :: [Char]
myXmobarHlColor :: [Char]
myXmobarTitleColor :: [Char]
myFocusFollowsMouse :: Bool
myModMask :: KeyMask
myTerminal = "gnome-terminal"

myBorderWidth = 4

myNormalBorderColor = "#c7ae95"

myFocusedBorderColor = "#aec795"

myXmobarHlColor = "#aec795"

myXmobarUrgentColor = "#c79595"

myXmobarTitleColor = "#c7ccd1"

myFocusFollowsMouse = True

myModMask = mod4Mask

myStartupHook :: X ()
myStartupHook = do
  spawn "fbsetroot -solid \"#434c5e\""
  spawn "compton -b"

myLayout =
  spacing 5 $ gaps [(U, 20)] $ avoidStruts $ tiled ||| Mirror tiled ||| spiral (6 / 7) ||| Full
  where
    tiled = ResizableTall nmaster delta ratio slaves
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100
    slaves = []

myDefaults =
  defaultConfig
  { modMask = mod4Mask
  , terminal = myTerminal
  , manageHook = manageDocks <+> manageHook defaultConfig
  , layoutHook = myLayout
  , startupHook = myStartupHook
  , handleEventHook = handleEventHook def <+> fullscreenEventHook
  , workspaces = myWorkspaces
  }

myLogHook :: Handle -> X ()
myLogHook xmproc =
  dynamicLogWithPP
    xmobarPP
    { ppCurrent = xmobarColor myXmobarHlColor ""
    , ppUrgent = xmobarColor myXmobarUrgentColor ""
    , ppHidden =
        xmobarColor myXmobarTitleColor "" .
        (\ws ->
           if ws == "NSP"
             then ""
             else ws)
    , ppOutput = hPutStrLn xmproc
    , ppSep = xmobarColor myXmobarHlColor "" " / "
    , ppTitle = xmobarColor myXmobarTitleColor "" . shorten 50
    }

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/.xmobarrc"
  xmonad $ ewmh myDefaults {logHook = myLogHook xmproc}
