import Data.Char

-- 1.  Write your own “safe” definitions of the standard partial list 
--     functions, but make sure that yours never fail. As a hint, you might 
--     want to consider using the following types.

safeHead :: [a] -> Maybe a
safeHead (x:xs) = Just x
safeHead _ = Nothing

safeTail :: [a] -> Maybe [a]
safeTail (x:xs) = Just xs
safeTail _ = Nothing

safeLast :: [a] -> Maybe a
safeLast (x:[]) = Just x
safeLast (x:xs) = safeLast xs
safeLast _ = Nothing

safeInit :: [a] -> Maybe [a]
safeInit (x:[]) = Just []
safeInit (x:xs) = Just (x:others)
  where
    (Just others) = safeInit xs
safeInit _ = Nothing

-- 2. Write a function splitWith that acts similarly to words, but takes a 
--    predicate and a list of any type, and splits its input list on every 
--    element for which the predicate returns False. 

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith pred ls = foldr f [[]] ls
  where
    f x []
      | pred x = [[x]]
      | otherwise = []
    f x (a:as) 
      | pred x = ((x:a):as)
      | null a = (a:as)
      | otherwise = ([]:a:as)


-- 3. Using the command framework from the section called “A simple command 
--    line framework”, write a program that prints the first word of each 
--    line of its input.

-- 4. Write a program that transposes the text in a file. For instance, it 
--    should convert "hello\nworld\n" to "hw\neo\nlr\nll\nod\n".

-- 5. Use a fold (choosing the appropriate fold will make your code much 
--    simpler) to rewrite and improve upon the asInt function from the section 
--    called “Explicit recursion”. 

asInt_fold :: String -> Int
asInt_fold ('-':s) = 0 - asInt_fold' s
asInt_fold s = asInt_fold' s
asInt_fold' s 
  | null s = error "bad input"
  | otherwise = t
  where
    (_,t) = foldr f (((length s) - 1) ,0) (reverse s)
    f digit (i,total) 
      | not (isDigit digit) = error "bad input"
      | otherwise = ((i - 1),((10^i)* (digitToInt digit)) + total )


-- Your function should behave as follows. 
-- ghci> asInt_fold "101"
-- 101
-- ghci> asInt_fold "-31337"
-- -31337
-- ghci> asInt_fold "1798"
-- 1798

-- Extend your function to handle the following kinds of exceptional conditions
-- by calling error.

-- ghci> asInt_fold "
-- 0
-- ghci> asInt_fold "-"
-- 0
-- ghci> asInt_fold "-3"
-- -3
-- ghci> asInt_fold "2.7"
-- *** Exception: Char.digitToInt: not a digit '.'
-- ghci> asInt_fold "314159265358979323846"
-- 564616105916946374

-- 6. The asInt_fold function uses error, so its callers cannot handle errors.
--    Rewrite it to fix this problem.

type ErrorMessage = String

asInt_either :: String -> Either ErrorMessage Int
asInt_either ('-':s) = Right (0 - asInt_either' s)
asInt_either s 
  | null s = Left "bad input"
  | not (all isDigit s) = Left "bad input, not a whole number"
  | otherwise = Right (asInt_either' s)
asInt_either' s = t
  where
    (_,t) = foldr f (((length s) - 1) ,0) (reverse s)
    f digit (i,total) 
      | not (isDigit digit) = error "bad input"
      | otherwise = ((i - 1),((10^i)* (digitToInt digit)) + total )

-- ghci> asInt_either "33"
-- Right 33
-- ghci> asInt_either "foo"
-- Left "non-digit 'o'"

-- 7. The Prelude function concat concatenates a list of lists into a single 
--    list, and has the following type:
--      concat :: [[a]] -> [a]
-- Write your own definition of concat using foldr. 

myConcat :: [[a]] -> [a]
myConcat l = foldr (++) [] l
-- 8. Write your own definition of the standard takeWhile function, first using
--    explicit recursion, then foldr.

-- 9. The Data.List module defines a function, groupBy, which has the following
--    type. 
--      groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
--   Use ghci to load the Data.List module and figure out what groupBy does,
--   then write your own implementation using a fold.
--
-- 10. How many of the following Prelude functions can you rewrite using list 
--     folds?
--       any 
--       cycle 
--       words 
--       unlines 
--     For those functions where you can use either foldl' or foldr, which is
--     more appropriate in each case?
