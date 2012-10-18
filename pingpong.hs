{-# LANGUAGE DeriveDataTypeable #-}
module Main where
import Control.Monad ( forever )
import Control.Concurrent ( threadDelay )
import Data.Binary
import Data.Typeable
import Control.Distributed.Process
import Control.Distributed.Process.Node
import Network.Transport.TCP
-- Serializable (= Binary + Typeable)
data Ping = Ping (SendPort Pong) deriving (Typeable)

data Pong = Pong deriving (Typeable)

instance Binary Ping where
    put (Ping sPong) = do put (0 :: Word8)
                          put sPong 
    get	     = do t <- get :: Get Word8
                  case t of
                       0 -> do sPong <- get
                               return (Ping sPong)

instance Binary Pong where
    put Pong = putWord8 1
    get      = do { getWord8; return Pong }

server :: ReceivePort Ping -> Process ()
server rPing = do
    Ping sPong <- receiveChan rPing
    liftIO $ putStrLn "Got a ping!"
    sendChan sPong Pong
    liftIO $ putStrLn "Sent a pong!"
    server rPing

client :: SendPort Ping -> Process ()
client sPing = do
    (sPong, rPong) <- newChan
    sendChan sPing (Ping sPong)
    liftIO $ putStrLn "Sent a ping!"
    Pong <- receiveChan rPong
    liftIO $ putStrLn "Got a pong!"
    client sPing

ignition :: Process ()
ignition = do
    -- start the server
    sPing <- spawnChannelLocal server
    -- start the client
    spawnLocal $ client sPing
    liftIO $ threadDelay 100000 -- wait a while

main :: IO ()
main = do
    Right transport <- createTransport "127.0.0.1" "8080"
			    defaultTCPParameters
    node <- newLocalNode transport initRemoteTable
    runProcess node ignition