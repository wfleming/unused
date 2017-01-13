module Unused.CLI.Views.MissingTagsFileError
    ( missingTagsFileError
    ) where

import           Unused.CLI.Util
import qualified Unused.CLI.Views.Error as V
import           Unused.TagsSource (TagSearchOutcome(..))

missingTagsFileError :: TagSearchOutcome -> IO ()
missingTagsFileError e = do
    V.errorHeader "There was a problem finding a tags file."
    printOutcomeMessage e

    ePutStr "\n"

    setSGR [SetConsoleIntensity BoldIntensity]
    ePutStr "If you're generating a ctags file to a custom location, "
    ePutStrLn "you can pipe it into unused:"
    setSGR [Reset]

    ePutStrLn "    cat custom/ctags | unused --stdin"

    ePutStr "\n"

    setSGR [SetConsoleIntensity BoldIntensity]
    ePutStrLn "You can find out more about Exuberant Ctags here:"
    setSGR [Reset]
    ePutStrLn "    http://ctags.sourceforge.net/"

    ePutStr "\n"

    setSGR [SetConsoleIntensity BoldIntensity]
    ePutStrLn "You can read about a good git-based Ctags workflow here:"
    setSGR [Reset]
    ePutStrLn "    http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html"

    ePutStr "\n"

printOutcomeMessage :: TagSearchOutcome -> IO ()
printOutcomeMessage (TagsFileNotFound directoriesSearched) = do
    ePutStrLn "Looked for a 'tags' file in the following directories:\n"
    mapM_ (\d -> putStrLn $ "* " ++ d) directoriesSearched
printOutcomeMessage (IOError e) = do
    ePutStrLn "Received error when loading tags file:\n"
    ePutStrLn $ "    " ++ show e
