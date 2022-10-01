module ChunkServer where
import Shared


data ChunkServerConfig = ChunkServerConfig {
    id :: ChunkServerId,
    -- Number of replicas to store chunks on
    numReplicas :: Int
}

defaultChunkServerConfig :: ChunkServerConfig
defaultChunkServerConfig = ChunkServerConfig {
    numReplicas = 3
}

-- Store chunk as file
-- Also replicate to other chunkservers
-- TODO might need byterange
storeChunk :: [Chunk] -> IO ()
storeChunk = undefined

-- TODO might need byterange
readChunk :: ChunkHandle -> ByteRange -> IO [Chunk]
readChunk = undefined
