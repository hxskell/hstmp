main = do
	putStrLn "hello, world"
	name <- getLine
	putStrLn ("hey" ++ name ++ ", haha")

