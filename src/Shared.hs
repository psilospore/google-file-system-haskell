{-# LANGUAGE DuplicateRecordFields #-}

-- Shared types, constants, utils
module Shared where
import Data.Int (Int64)
import Data.Coerce (coerce)

-- Chunk size is 64 MB
chunkSize = 64000000

-- file path e.g. /foo/bar
-- TODO ideally use prefix compression
newtype FileName = FileName [String]

data File = File {
    path :: FileName,
    contents :: String -- TODO use bytestring or whatever
}

-- immutable and globally unique 64 bit chunk handle assigned by the master at the time of chunkcreation
newtype ChunkHandle = ChunkHandle Int64

data Chunk = Chunk {
    handle :: Int64
}

newtype ChunkServerId = ChunkServerId Int

-- Assuming the paper means the file byte offset?
newtype ByteOffset = ByteOffset Int

data ByteRange = ByteRange {
    start :: Int,
    end :: Int
}


-- Locatation of node
data Location = USEast1 | USWest1 | AsiaEast1a  -- and so on

data ChunkServerInfo = ChunkServerInfo {
    location :: Location,
    chunkServerId :: ChunkServerId
}


newtype ChunkIndex = ChunkIndex Int


data HeartbeatStatus = HeartbeatStatus {
    id :: ChunkServerId,
    isUp :: Bool
}