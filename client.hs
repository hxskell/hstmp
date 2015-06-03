import Control.Monad
import Control.Concurrent
import Network (connectTo, withSocketsDo, PortID(..), Socket)
import System.IO

main = withSocketsDo $ do
	handle <- connectTo "192.168.11.46" $ PortNumber 3333
	hSetBuffering handle LineBuffering
	forkIO $ getmsg handle
	loop handle 10

loop handle 0 =
	hClose handle
loop handle times = do
	msg <- getLine
	hPutStrLn handle msg
	loop handle (times - 1)

getmsg handle = do
	forever $ do
		msg <- hGetLine handle
		putStrLn $ "it say:" ++ msg
