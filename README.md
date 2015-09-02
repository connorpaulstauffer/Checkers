# Checkers

## Description

Ruby implementation of checkers. Playable in the command line.


## Features

  * $stdin.getch method and [cursor logic][cursor] enables players to navigate
  the board with the w, a, s, and d keys
  * Highlights valid moves based on cursor position
  * [Display][display] class refactors interface logic out of the board class
  * Supports jumps of arbitrary length.
  * Highlights initial valid jumps and any additional valid jumps after each
  one.

[display]: ./display.rb


## Instructions

Clone this repository to a local directory. ```cd``` into the repository. Run
```ruby game.rb```. On your turn, navigate the board with the w, a, s, and d
keys. Select a piece with the enter key, navigate to where you would like to
move, confirm the move with two hits of the enter key. If you would like to
jump, hit the enter key once at the end position of the jump, again at the
end position of each following jump, and confirm the final position with an
extra hit of the enter key.
