-- 1. What are the types of the following Expressions?
-- False :: Bool
-- (["foo", "bar"], 'a') :: ([[Char]], Char)
-- [(True, []), (False, [['a']])] :: [(Bool, [[Char]])

-- 1.  What are valid behaviors of type [a] -> a
--   Retrieve the first element of the list.
--   Retrieve the last element of the list
--   Retrieve an arbitrary element acording to some predefined criteria
--
-- 2. Write a function lastButOne, that returns the element before the last

lastButOne :: [a] -> a
lastButOne (x:_:[]) = x
lastButOne (_:xs) = lastButOne xs

-- 3. What happens when you pass it a list that's too short?
-- *Main> lastButOne [3]
-- *** Exception: ch2.hs:(9,1)-(10,33): Non-exhaustive patterns in function lastButOne]
