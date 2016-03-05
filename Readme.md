# Minesweeper

An implementation of Minesweeper in Ruby. 

## install

- clone this repo
- bundle

## play

to start:

```
bin/minesweeper
```

Minesweeper will begin by asking for number of rows, columns, and mines.

```
1. rows
2. cols
3. mines
4. start
Setup board => rows: 10, cols: 12, mines: 20
```

After that, you can play that board over and over again.

```
(f)lag, (s)elect, arrow keys to move, (r)estart, (q)uit.
```

# Benchsweeper

Benchsweeper solves minesweeper games and provides metrics on timing, wins, and losses.

The solver's strategy is:

1. find revealed cells with a number equal to the number of hidden adjacent squares: flag those
2. find revealed cells with a number equal to the number of flagged adjacent squares: reveal those
3. if nothing changed from 1 and 2, find a revealed cell with the lowest adjacent-mines number and randomly pick a hidden adjacent cell
4. if nothing changed from 3, pick a random hidden

Tactics 1 and 2 are the most reliable, 3 is the least risky, and 4 is what it is. So if the board changes after any step, the loop starts over from the top.

## Use

```
bin/benchsweeper
```

### benchsweeper options:

```
Options:
  -g, --games=<i>      Number of games to run (default: 100)
  -r, --rows=<i>       Number of rows (default: 10)
  -c, --cols=<i>       Number of columns (default: 10)
  -m, --mines=<i>      Number of mines (default: 10)
  -b, --boards         output board results
  -i, --interactive    Set up games/board interactively
  -h, --help           Show this message
```
