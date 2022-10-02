-- The master maintains all file system metadata. This includes the namespace, access control information, the mapping from files to chunks, and the current locations of chunks.
-- It also controls system-wide activities such as chunklease
-- management, garbage collection of orphaned chunks, and
-- chunkmigration between chunkservers. The master periodically communicates with each chunkserver in HeartBeat
-- messages to give it instructions and collect its state.

module Master where
import Shared

-- MetaData stored in memory (Section 2.6)
-- Is periodically scanned
data MetaData = MetaData {
    -- TODO file and chunk namespaces
    chunkFromFile :: Map File' [Chunk],
    -- Where a given chunk is replicated
    chunkLocation :: Map Chunk [ChunkServerId]
}

-- Representation of file from the Master's POV
data File' = File' {
    path :: FileName,
    chunks :: [Chunk],
    -- | Edge case discussed in Section 2.5
    -- |Is this particular file suspectable to hotspotting? If so we need to replicate this more than the default
    hotspoting :: Bool
}

-- The master periodically communicates with each chUnkserver in HeartBeat
-- messages to give it instructions and collect its state
heartbeat :: IO [HeartbeatStatus]
heartbeat = undefined

getChunkHandleAndLocations' :: FileName -> ChunkIndex -> IO (ChunkHandle, [ChunkServerInfo])
getChunkHandleAndLocations' = undefined

-- A ChunkServer is joining
-- TODO update chunk location
chunkServerJoin :: MetaData -> IO MetaData
chunkServerJoin = undefined

-- A ChunkServer has left
-- TODO update chunk location
-- TODO this is discovered during the heartbeat process I think
chunkServerJoin :: MetaData -> IO MetaData
chunkServerJoin = undefined

-- Poll chunkservers for which servers have which chunks
-- Along with heartbeats this should allow Master to always have up to date information about chunks
startup :: IO ()
startup = undefined

-- Chunk migration to balance lead and disk scpace across chunkservers
migrateChunks = undefined

