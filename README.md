This is a project from the curriculum of The Odin Project.

In this project, we are testing our ability to code via test-driven development (TDD). We will be using RSpec in this project.

I just recently read '99 Bottles of OOP' by Sandi Metz, so I am also hoping to apply the principles from that book in this project as well. These include working horizontally, reaching Shameless green, refactoring under green, SOLID principles, and many more concepts.

2022-08-26 Day One Night
I realized I fucked up and at the very start already forgot the proper steps.

Sandi Metz recommended reaching Shameless Green incrementally. I tried to find abstractions quickly and wrote a bunch of tests before writing any code. Instead, I should have written a test, written code, then written another test, and refactored or added code.

At least I got to practice Git a bit instead of just scrapping the file.

I will still start with Board, but this time incrementally use TDD to reach Shameless Green.

2022-08-26 Day One
Ideas:
- Board#columns, Board#display, #Board#drop, #Board#win?
- Process:
  - Board displays rows as | |x|o| | | | | with spaces indicating empty space and 'x' and 'o' indicating player discs
  - Players input the column label to drop a disc into that column.
  - Game checks for Board.win?
  - Game ends when there is a win. If not, continues players making moves. 
- Can make a blind mode where the players cannot see the board while making moves. This board could hide the moves made as well or display which column the move was made in and it is up to the player to remember where each move was made.

Questions:
- Should Shameless Green start with one class or is it okay to have some abstraction at the start?

I have decided to work on the board first. I think having a stable working board will allow for an easier time testing and coding the rest of the game.

The board should respond to #columns with a hash that includes the values of the discs on the board. The hash shall contain keys that represent the columns of the board with a value of an array with 6 values that represents the filled values (with the beginning of the array being the bottom of the board).

The board should respond to #display with a visual of the #columns hash to show to the players in the game.

The board should have #drop which will record a move into the #columns hash.

The board should have #win? which will check if the board contains any winning combos. 

This begs the question, how should the game check for a win condition? Should it contain a copy of every single possible winning state of the board, and check if the board is present in that collection? That seems inefficient. 

Is there an algorithm we could use to check if there are any 4-in-a-row combos? I almost wonder if it could work like a binary search tree. 

**A move is only possible if the game has not already been won. Therefore, a win needs to only be checked for the new disc. Check the disc for a win in each direction. The algorithm can have a counter and for each traverse it makes to a disc of the same player, it adds to the counter. If the counter reaches 4, the move was a winning move.**

How will the board know what the last move was? Will there be a log moves, a cache of the last made move? Will the win be checked as the move is made?

I realized after working for about an hour that I had already begun finding many abstractions in the game. I had immediately started with the idea that there is a game and in the game there is a board and players. Does Sandi Metz's Shameless Green suggest that I should have not started with these and had simply one class trying to complete all of the tasks at the start, and then refactor these abstractions later?
