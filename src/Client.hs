-- The client it communicates with master to locate relevant ChunkServers, and reads/writes to ChunkServers.
module Client where

-- Find the best chunk server. Probably the cloest
findBestChunkServer :: [ChunkServerInfo] -> IO ChunkServerInfo
findBestChunkServer = pure . head -- Just choosing the first one in the list for now

-- First, using the fixed chunksize, the client
-- translates the file name and byte offset specified by the application into a chunkindex within the file. Then, it sends
-- the master a request containing the file name and chunk index. 
-- The master replies with the corresponding chunk handle and locations of the replicas. 
-- TODO can temporarily cache (file name, chunk index) -> (ChunkHandle, ChunkServerInfo)
getChunkHandleAndLocations :: FileName -> ByteOffset -> IO (ChunkHandle, [ChunkServerInfo])
getChunkHandleAndLocations filename (ByteOffset bytesOffset) = let chunkIndex = ChunkIndex $ div bytesOffset chunkSize in
    getChunkHandleAndLocations' filename chunkIndex -- TODO do this over the network instead

-- TODO return actual file
getFile :: FileName -> ByteOffset -> IO File
getFile filename byteoffset = do
    (chunkHandle, chunkServers) <- getChunkHandleAndLocations filename byteoffset
    bestChunkServer <- findBestChunkServer chunkServers
    -- TODO cache best server and to prevent extra calls to master node
    let byteRange = ByteRange {
        start = coerce byteoffset `mod` chunkSize, -- TODO not sure if I mod this think I do though
        end = undefined -- Not sure if this is an argument or not. Think it is
    }
    readChunk chunkHandle byteRange  -- This should be over network/socket/ipc (chunk server might be colocated)
    pure undefined