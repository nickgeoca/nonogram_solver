import pytest

import os
import sys

from fibo import solver


# Ways to test.
#  1. Randomly generate problems. Validate solutions
#  2. Set of problems. Validate solutions.
#  3. Set of problems. Known solutions == solver solutions?


## Null case
i0 = ( [ [] ] 
     , [ [] ])

s0 = [[]]

## Misc case
i1 = ( [ []
       , []
       , [1]]
     , [ []
       , [1]])

s1 = [ [False, False, False]
     , [False, False, True] ]

## Checkered (multi-solution) case
i2 = ( [ [2]
       , [2]
       , [2]
       , [2]]
     , [ [2]
       , [2]
       , [2]
       , [2]])

s2a = [ [False, True,  False, True]
      , [True,  False, True,  False] 
      , [False, True,  False, True]
      , [True,  False, True,  False] ]

s2b = [ [True,  False, True,  False] 
      , [False, True,  False, True]
      , [True,  False, True,  False] 
      , [False, True,  False, True] ]

## No solution case
i3 = ( [ [3] ] 
     , [ [3] ])

s3 = None

## Tests
def solve_engine(x): return solver.solve_engine(x)
def test_1():
    assert s0 == solve_engine(i0)
    assert s1 == solve_engine(i1)
    assert ( s2a == solve_engine(i2)
           | s2b == solve_engine(i2))
    assert s3 == solve_engine(i3)
