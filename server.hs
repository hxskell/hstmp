import Control.Monad
import Control.Concurrent
import Network (listenOn, withSocketsDo, accept, PortID(..), Socket)
import System.IO


main = withSocketsDo $ do
		socket <- listenOn $ PortNumber 3333
		forever $ do
			(handle, host, portno) <- accept socket
			putStrLn $ "newconnect" ++ (show host)
			forkIO $ loop handle 10

loop handle 0 =
		hClose handle
loop handle times = do
		hSetBuffering handle LineBuffering
		msg <- hGetLine handle
		putStrLn $ "it say:" ++ msg
		hPutStrLn handle $ "server get" ++ msg
		loop handle (times - 1)
