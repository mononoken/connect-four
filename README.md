This is a project from the curriculum of The Odin Project.

In this project, we are testing our ability to code via test-driven development (TDD). We will be using RSpec in this project.

I just recently read '99 Bottles of OOP' by Sandi Metz, so I am also hoping to apply the principles from that book in this project as well. These include working horizontally, reaching Shameless green, refactoring under green, SOLID principles, and many more concepts.

2022-08-31
I was happy to make my diagonal methods cleaner, and I was able to make horizontal methods fairly quickly.

Extracting methods is fun. I still worry that I am doing things incorrectly, but I keep reminding myself:
- This is not a test that I must get 100% on.
- If I do something incorrectly, the poor solution will reflect it and teach it.

2022-08-29
I may be forgetting parts of '99BOOP', but I feel like I am making progress. I enjoy having green to lean on. 

I am making a bunch of changes to get the game to be able to check for diagonal wins. I am not refactoring one change at a time like '99BOOP' did, but I am making changes such that the tests stay green.

2022-08-28
Decided to stop worrying so much and just do.

I have also been thinking that maybe instead of trying to force Shameless Green in some direction, maybe the point is to focus on writing good tests and shamelessly writing the easiest code to make those tests green. Don't worry too much about conditionals, duplication, or any other opinionated code. Just write what is easy to pass your tests.

2022-08-27
I think I started last night at a bad spot again. Starting with the board visual made sense at the time since I could already visualize the expected behavior, but the visual relies on pieces that are not built yet. How am I supposed to return a visual without a place to store previous moves and to inject new moves?

I just now considered, what if the abstract board was simply the argument for the method? I'll see how that path leads. 

An important re-read from 99BOOP:
"“Despite its apparent import, the choice you make here hardly matters. In the beginning, you have ideas about the problem but actually know very little. Your ideas may turn out to be correct, but it’s just as possible that time will prove them wrong. You can’t figure out what’s right until you write some tests, at which time you may realize that the best course of action is to throw everything away and start over. Therefore, the purpose of some of your tests might very well be to prove that they represent bad ideas. Learning which ideas won’t work is forward progress, however disappointing it may be in the moment.”
Excerpt From
99 Bottles of OOP
Metz, Sandi


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
