# Minesweeper

An implementation of Minesweeper in Ruby. 

## Install

```
> https://github.com/chigginsiii/minesweeper.git
> bundle
```

## Play

to start:

```
bin/minesweeper
```

### Options:

```
Options:
  -r, --rows=<i>       Number of rows (default: 12)
  -c, --cols=<i>       Number of columns (default: 10)
  -m, --mines=<i>      Number of mines (default: 20)
  -i, --interactive    Set up games/board interactively
  -h, --help           Show this message
 ```

### Interactive setup:

```
/minesweeper[master *%=]:: bin/minesweeper -i
Number of rows [12]: 13
Number of cols [10]:
Number of mines [20]: 25
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

Running `benchsweeper` with the `--boards` option will show the result of each game, the running total of wins/games-played, and that game's time. Otherwise you get a progress bar and stats at the end.
