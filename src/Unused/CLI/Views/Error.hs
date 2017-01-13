module Unused.CLI.Views.Error
    ( errorHeader
    ) where

import Unused.CLI.Util

errorHeader :: String -> IO ()
errorHeader s = do
    setSGR [SetColor Background Vivid Red]
    setSGR [SetColor Foreground Vivid White]
    setSGR [SetConsoleIntensity BoldIntensity]

    ePutStrLn $ "\n" ++ s ++ "\n"

    setSGR [Reset]
