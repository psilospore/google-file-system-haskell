-- The master maintains all file system metadata. This includes the namespace, access control information, the mapping from files to chunks, and the current locations of chunks.
-- It also controls system-wide activities such as chunklease
-- management, garbage collection of orphaned chunks, and
-- chunkmigration between chunkservers. The master periodically communicates with each chunkserver in HeartBeat
-- messages to give it instructions and collect its state.

module Master where
import Shared

-- The master periodically communicates with each chUnkserver in HeartBeat
-- messages to give it instructions and collect its state
heartbeat :: IO [HeartbeatStatus]
heartbeat = undefined

getChunkHandleAndLocations' :: FileName -> ChunkIndex -> IO (ChunkHandle, [ChunkServerInfo])
getChunkHandleAndLocations' = undefined
