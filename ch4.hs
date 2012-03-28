-- 1.  Write your own “safe” definitions of the standard partial list 
--     functions, but make sure that yours never fail. As a hint, you might 
--     want to consider using the following types.

safeHead :: [a] -> Maybe a
safeHead = error "not implemented"

safeTail :: [a] -> Maybe [a]
safeTail = error "not implemented"

safeLast :: [a] -> Maybe a
safeLast = error "not implemented"

safeInit :: [a] -> Maybe [a]
safeInit  = error "not implemented"


-- 2. Write a function splitWith that acts similarly to words, but takes a 
--    predicate and a list of any type, and splits its input list on every 
--    element for which the predicate returns False. 

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith = error "not implemented"

-- 3. Using the command framework from the section called “A simple command 
--    line framework”, write a program that prints the first word of each 
--    line of its input.

-- 4. Write a program that transposes the text in a file. For instance, it 
--    should convert "hello\nworld\n" to "hw\neo\nlr\nll\nod\n".

-- 5. Use a fold (choosing the appropriate fold will make your code much 
--    simpler) to rewrite and improve upon the asInt function from the section 
--    called “Explicit recursion”. 

asInt_fold :: String -> Int
asInt_fold = error "not implemented"

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
asInt_either = error "not implemented"

-- ghci> asInt_either "33"
-- Right 33
-- ghci> asInt_either "foo"
-- Left "non-digit 'o'"

-- 7. The Prelude function concat concatenates a list of lists into a single 
--    list, and has the following type:
--      concat :: [[a]] -> [a]
-- Write your own definition of concat using foldr. 

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
