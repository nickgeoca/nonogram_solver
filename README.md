# Nonogram Solver

What is a [Nonogram](https://en.wikipedia.org/wiki/Nonogram)?

This is a Nonogram solver written in Haskell. Explanations on how to run the program and the data format are explained here.

### Data Format

#### Input
The input data are column constraints followed by row constraints. These are each a list of the number of runs of 1s in the nonogram for a given row/column.
* The column constraints type is [[Int]]
* The row constraints type is [[Int]]

**Library Code**  
In the library, the solve function solves the nonogram. The type is seen below.
```haskell
solve :: [[Int]] -> [[Int]] -> Maybe [[Int]]
solve columnConstraints rowConstraints = ...

-- Example
solve [[1],[1],[1],[1]] [[1],[1],[1],[1]] 
```

**Executable**  
An exe version can be run too. The inputs are the same as the haskell type above. This is demonstrated in the example below. Be sure to type each constraint on a single line.  

Column constraints: [[1],[1],[1],[1]]  
Row constraints: [[1],[1],[1],[1]]  
X---  
-X--  
--X-  
---X  


#### Output
**Library Code**
The output in the library function is a Maybe [[Int]]. It returns Nothing if there is no solution, otherwise it returns the first solution it found wrapped in Just.
* Ex: Just [[1,0],[0,0]]
* Ex: Nothing

**Executable**
The output of the exe is text. The 'X' is an active pixels and the '-' is an inactive pixel. For example:
```js
X---
-X--
--X-
---X
```

### How to Run the Program
_step 6 runs the executable_  
_The executable code in app/Main.hs_  
1. Clone this repo: git clone https://github.com/nickgeoca/nonogram_solver.git
2. Install [stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)
3. $ cd nonogram_solver
4. $ stack setup
5. $ stack build # Build exe
6. $ stack exec nonogram-solver-exe # run exe

#### Running Tests
_The test code is in test/NonogramSolverSpec.hs_
1. cd into the project directory
2. $ stack test
..* This is what should report after running: "7 examples, 0 failures"

#### Running in the REPL
1. $ stack ghci
2. > :l src/NonogramSolver.hs
3. > solve [] [] -- repl example

### Programming Assignment Miscallaneous

* Can I reference Nonogram solver algorithms?  
Yes 

### Dev Checklist
* Documentation
* Polishing: eg tests, ..