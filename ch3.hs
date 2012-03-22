import Data.List (sortBy)
import Data.Ord

-- 1.  Write a function that computes the number of elements in a list. To
--     test it, ensure that it gives the same answers as the standard length
--     function.
-- 2.  Add a type signature for your function to your source file. To test it,
--     load the source file into ghci again.


myLength :: [a] -> Integer
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- 3.  Write a function that computes the mean of a list, i.e. the sum of all
--     elements in the list divided by its length. (You may need to use the
--     fromIntegral function to convert the length of the list from an integer
--     into a floating point number.)

mySum :: [Int] -> Int
mySum [] = 0
mySum (x:xs) = x + mySum xs

mean :: Fractional a => [Int] -> a
mean list = fromIntegral (mySum list) / fromIntegral (length list)

-- 4.  Turn a list into a palindrome, i.e. it should read the same both
--     backwards and forwards. For example, given the list [1,2,3], your
--     function should return [1,2,3,3,2,1].

consReverse list = list ++ reverse list

-- 5.  Write a function that determines whether its input list is a palindrome.

isPalendrome list = list == reverse list

-- 6.  Create a function that sorts a list of lists based on the length of each
--     sublist. (You may want to look at the sortBy function from the Data.List
--     module.)

compareLengths l1 l2
  | length l1 < length l2 = LT
  | length l1 > length l2 = GT
  | otherwise = EQ

sortLists listOfLists = sortBy compareLengths listOfLists

-- 7.  Define a function that joins a list of lists together using a separator
--     value.

intersperse :: a -> [[a]] -> [a]
intersperse s (x:y:xs) = x ++ (s : y) ++ (intersperse s xs)
intersperse _ (x:[]) = x
intersperse _ [] = []

--intersperse _ _ = error "not yet implemented"

--     ghci> :load Intersperse
--     [1 of 1] Compiling Main             ( Intersperse.hs, interpreted )
--     Ok, modules loaded: Main.
--     ghci> intersperse ',' []
--     ""
--     ghci> intersperse ',' ["foo"]
--     "foo"
--     ghci> intersperse ',' ["foo","bar","baz","quux"]
--     "foo,bar,baz,quux")


-- 8.  Using the binary tree type that we defined earlier in this chapter,
--     write a function that will determine the height of the tree. The height
--     is the largest number of hops from the root to an Empty. For example,
--     the tree Empty has height zero; Node "x" Empty Empty has height one;
--     Node "x" Empty (Node "y" Empty Empty) has height two; and so on.

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

height :: Tree a -> Int
height Empty = 0
height (Node a t1 t2)
       | height t1 >= height t2 = 1 + height t1
       | otherwise = 1 + height t2

-- 9.  Consider three two-dimensional points a, b, and c. If we look at the
--     angle formed by the line segment from a to b and the line segment from
--     b to c, it either turns left, turns right, or forms a straight line.
--     Define a Direction data type that lets you represent these
--     possibilities.

data Direction = Straight
               | Left
               | Right
                 deriving (Show, Eq)

-- 10.  Write a function that calculates the turn made by three 2D points and
--      returns a Direction.

data Point = Point Int Int
             deriving (Show,Eq)

slope :: Point -> Point -> Float
slope (Point x1 y1) (Point x2 y2) =
    fromIntegral (y1 - y2) / fromIntegral (x1 - x2)

turn :: Point -> Point -> Point -> Direction
turn p1 p2 p3 
  | 0 == crossproduct = Straight
  | 0 < crossproduct = Main.Left
  | otherwise = Main.Right
  where
    crossproduct = ((x2 - x1) * (y3 - y1)) - ((y2 - y1) * (x3 - x1))
    (Point x1 y1) = p1 
    (Point x2 y2) = p2 
    (Point x3 y3) = p3 
--             | m1 < m2 = Main.Left
--             | m1 > m2 = Main.Right
--            | otherwise = Straight
--             where
--               m1 = slope p1 p2
--               m2 = slope p2 p3

-- 11.  Define a function that takes a list of 2D points and computes the
--      direction of each successive triple. Given a list of points
--      [a,b,c,d,e], it should begin by computing the turn made by [a,b,c],
--      then the turn made by [b,c,d], then [c,d,e]. Your function should
--      return a list of Direction.

turns :: [Point] -> [Direction]
turns (p1:p2:p3:ps) = (turn p1 p2 p3) : turns (p2:p3:ps)
turns _ = []

-- 12.  Using the code from the preceding three exercises, implement Graham's
--      scan algorithm for the convex hull of a set of 2D points. You can find
--      good description of what a convex hull. is, and how the Graham scan
--      algorithm should work, on Wikipedia.
--  1. identify point with lowest y axis (P)
--  2. sort all points by cosine of point with P and x axis
--  3. navigate down the list, if is a right turn, discard points
--    a. at end, all points should have left turns to each other
--  4. This is the convex hull

lowestY :: Point -> Point -> Point
lowestY (Point x1 y1) (Point x2 y2)
  | y1 < y2 = (Point x1 y1)
  | otherwise = (Point x2 y2)

bottomOfHull :: [Point] -> Point
bottomOfHull (point:[]) = point
bottomOfHull (p1:p2:ps) = bottomOfHull' (lowestY p1 p2) ps
  where
    bottomOfHull' b [] = b
    bottomOfHull' b (p:ps) = bottomOfHull' (lowestY b p) ps

vectorCosine origin point = (fromIntegral adjacent ) / hypotenuse
  where
    (Point x2 y2) = point
    (Point x1 y1) = origin
    adjacent = x2 - x1
    hypotenuse = sqrt (fromIntegral (adjacent^2 + (y2 - y1)^2))

sortByCosine origin points = 
  sortBy (\p1 p2 -> compare (vcos p1) (vcos p2)) points
  where
    vcos = vectorCosine origin


onlyRightTurns :: [Point] -> [Point]
onlyRightTurns [] = []
onlyRightTurns (p:[]) = [p]
onlyRightTurns (p1:p2:[]) = [p1,p2]
onlyRightTurns (p1:p2:p3:ps) 
  | turn p1 p2 p3 == Main.Left = onlyRightTurns (p1:p3:ps) 
  | otherwise = p1 : onlyRightTurns (p2:p3:ps)


convexHull :: [Point] -> [Point]
convexHull points = origin : (onlyRightTurns (sortByCosine origin otherPoints))
  where
    origin = bottomOfHull points
    otherPoints = filter (\x -> x /= origin) points
    

tp1 = (Point 0 0)
tp2 = (Point 10 10)
tp3 = (Point 0 20)
tp4 = (Point (-10) 10)
tp5 = (Point 5 10)

testPoints = [tp1,tp2,tp3,tp4, tp5]

testOrigin = bottomOfHull testPoints == tp1
testOtherPoints = filter (\x ->x /= tp1) testPoints == [tp2,tp3,tp4]
testSortByCosine = sortByCosine tp1 [tp2,tp3,tp4]
