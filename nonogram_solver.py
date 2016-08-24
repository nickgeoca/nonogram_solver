from __future__ import print_function

def is_input_valid_type(cols_rows):
    lCols, lRows = cols_rows

    # Validate columns
    for lCol in lCols:
        if type(lCol) != list: return False
        for intRun in lCol:
            if type(intRun) != int: return False

    # Validate rows
    for lRow in lRows:
        if type(lRow) != list: return False
        for intRun in lRow:
            if type(intRun) != int: return False
    
    return True


def solve_engine(cols_rows):
    assert is_input_valid_type(cols_rows), "Input is not a valid type!"

    cols, rows = cols_rows
    print(cols, rows)
    
    solution = [ [True, False, True, True, True]
               , [False, False, True, True, False]]
    
    return solution

def solve_repl():

    print("Repl solver. Input is JSON style. Example: {'cols': [[1]], 'rows': [[1], []]}")

    ## Parse input
    cr = input('Input: ')
    cols_rows = (cr['cols'], cr['rows'])

    ## Solve input to get solution
    solution = solve_engine(cols_rows)

    ## Print solution
    if solution == None: 
        print('No solution found!')
        return

    for row in solution:
        for pixel in row:
            if pixel == True: pixel = u'\u25A0' # Unicoode 'Black Square'
            else            : pixel = u'\u25A1' # Unicoode 'White Square'
            print(pixel, end="")

        # Print new line
        print('')
