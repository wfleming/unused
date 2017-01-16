{-# LANGUAGE OverloadedStrings #-}
module Unused.CLI.Views.SearchResult.CodeClimateResult
    ( printCodeClimateJSON
    ) where

import qualified Control.Monad as M
import           Data.Aeson (ToJSON(..), (.=), encode, object)
import qualified Data.Aeson as JSON
import qualified Data.ByteString.Lazy as BL
{-import           Unused.CLI.Util-}
{-import qualified Unused.CLI.Views.SearchResult.Internal as SR-}
import qualified Unused.CLI.Views.SearchResult.Types as SR
import           Unused.Types (TermResults(..), TermMatch(..), tmDisplayTerm, {-totalFileCount, totalOccurrenceCount -})

data TermIssue = TermIssue TermResults TermMatch

printCodeClimateJSON :: TermResults -> [TermMatch] -> SR.ResultsPrinter ()
printCodeClimateJSON r ms = SR.liftIO $
    M.forM_ ms $ \m -> do
        printIssue $ TermIssue r m
        putStr "\0"

printIssue :: TermIssue -> IO ()
printIssue i = BL.putStr $ encode i

instance ToJSON TermIssue where
    toJSON i = object
        [ "categories" .= categories
        , "check_name" .= checkName
        , "content" .= content i
        , "description" .= description i
        , "location" .= location i
        , "remediation_points" .= remediationPoints
        , "severity" .= severity
        , "type" .= issueType
        ]

issueType :: String
issueType = "issue"

checkName :: String
checkName = "UnusedTerm"

remediationPoints :: Int
remediationPoints = 50000

categories :: [String]
categories = ["Clarity"]

severity :: String
severity = "normal"

description :: TermIssue -> String
description (TermIssue _ m) =
    -- TODO: change copy based on whether it appears in tests?
    (tmDisplayTerm m) ++ " is defined, but may be unused"

content :: TermIssue -> String
content _ = "TODO: write content for this"

location :: TermIssue -> JSON.Value
location (TermIssue _ m) = object
    [ "path" .= tmPath m
    , "lines" .= object
          [ "begin" .= (1 :: Int)
          , "end" .= (1 :: Int)
          ]
          -- TODO: get real line numbers from the tags file
    ]

{-printSHAs :: TermResults -> IO ()-}
{-printSHAs r =-}
    {-case mshas of-}
        {-Nothing -> M.void $ putStr ""-}
        {-Just shas' -> do-}
            {-printHeader "    Recent SHAs: "-}
            {-putStrLn $ L.intercalate ", " shas'-}
  {-where-}
    {-mshas = (map gcSha . gcCommits) <$> trGitContext r-}

{-printRemovalReason :: TermResults -> IO ()-}
{-printRemovalReason r = do-}
    {-printHeader "    Reason: "-}
    {-putStrLn $ SR.removalReason r-}

{-pluralize :: Int -> String -> String -> String-}
{-pluralize i@1 singular _ = show i ++ " " ++ singular-}
{-pluralize i _ plural = show i ++ " " ++ plural-}
