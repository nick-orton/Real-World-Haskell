-- 1.  What are valid behaviors of type [a] -> a
--   Retrieve the first element of the list.
--   Retrieve the last element of the list
--   Retrieve an arbitrary element acording to some predefined criteria
--
-- 2. Write a function lastButOne, that returns the element before the last

lastButOne :: [a] -> a
lastButOne (x:_:[]) = x
lastButOne (_:xs) = lastButOne xs

