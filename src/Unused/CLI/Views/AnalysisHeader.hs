module Unused.CLI.Views.AnalysisHeader
    ( analysisHeader
    ) where

import Unused.CLI.Util

analysisHeader :: [a] -> IO ()
analysisHeader terms = do
    setSGR [SetConsoleIntensity BoldIntensity]
    ePutStr "Unused: "
    setSGR [Reset]

    ePutStr "analyzing "

    setSGR [SetColor Foreground Dull Green]
    ePutStr $ show $ length terms
    setSGR [Reset]
    ePutStr " terms"
