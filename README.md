This is a project from the curriculum of The Odin Project.

In this project, we are testing our ability to code via test-driven development (TDD). We will be using RSpec in this project.

I just recently read '99 Bottles of OOP' by Sandi Metz, so I am also hoping to apply the principles from that book in this project as well. These include working horizontally, reaching Shameless green, refactoring under green, SOLID principles, and many more concepts.

I decided to make a log of my thoughts below as well. They ascend to the most recent date.

TO DO:
- Player set own name
- Player set own disc
- Better BoardVisualizer
- Visualize where the winning combo is located
- Replay function

2022-09-27
Been busy in the rainforest. I decided to stop trying to refactor my game. I see plenty of things I could work on, but I think my time is better off moving forward.

One of the big mistakes I think I made was going too ham on tests. After finishing the game and having it in working condition, I went back to add tests to some of my private methods and moved them above the private keyword.

I think I may be misunderstanding how private and public methods are meant to work. As I understand it now, this was actually a bad move because now my tests further tie the program down to its current iteration. The public methods are the ones visible to the rest of my classes and to the functioning of the program as a whole. Some of these private methods should have stayed private because they are the inner workings. They were the how and not the what.

If I care about this project in the future, I can come back and try to fix these mistakes. I learned a lot in this project.

2022-09-19
Decided not to add replay function and to focus on adding tests for methods that I missed and cleaning things up.

2022-09-16
There is a bug where game will sometimes not switch players. I had some difficulty figuring it out, but eventually I realized that the problem was with #random_order. It should have been obvious that it had to do with something involving random selection (since it did not happen consistently), but it took me a little time to figure out.

The problem was that I was treating #random_player in #random_order as if it was caching the random_player. It was not, so it would sometimes randomly select the same player in the same order. Easy fix by caching the first random_player so that #other_player could work.

2022-09-13
Ran game and realized I need to update column numbers for some puts commands. Easy fix! Code was open to the change.

Next step: Add a replay function.

Is it open? Not sure. I could set Game@board to a new Board. Currently, Board is fed into Game#initialize. I would want to run something like #play again. #setup currently calls #instructions, which I would not want to show again.

Code smells. First, most noticable thanks to Rubocop, is Game class is too long.

2022-09-12
Today, I am going to implement the column names being named 1~7 instead of 0~6. 0~6 does not make as much sense to someone who is not a programmer. Also, assuming the player is not playing with a numpad, 0 is inconveniently placed on the far right of a keyboard instead of next to 1.

Is the code open to receiving input 1~7? No.

How can I make it open? Look for code smells.

I don't know if this is a listed 'code smell', but I see that #valid_input? references COL_LOWER_INDEX.to_s. This seems to be a smell to me. This method does not want the lower index because it is checking inputs, not indeces. This is clear from the fact that the index is being converted to a string with to_s.

Furthermore, the last segment of this method has input.to_i sent to board.valid_drop?. This is another 'smell'. We are converting input.to_i because we know valid_drop? wants a column index, not a string input. However, using this primitive method, #to_i, obscures this a bit. It feels to me that we desire a method like #to_column_index.


Trying to refactor #valid_input? has been a journey of grief. I have realized that many of my tests expect the upper and lower limits of input to be specific values. In other words, the tests know how Game works.

The more I look at my tests, the more coupling between tests and code I see. I also am finding that many of these seem to be related to methods using instance variables when they could be using parameters (with these instance variables set as defaults).

2022-09-11
I dislike how #winner is determined in Game currently.
The method currently returns the #current_player if #winner? returns true. #winner? returns true if Board returns true to #any_wins? which is checking the #last_move received on the Board. This #last_move is set as the default of #any_wins.

#last_move and #current_player are not actually linked in any way other than WHERE they are called in the game. I think that is what is bugging me. Whether this is an actual problem or not is hard for me to say right now.

I had the notion that maybe I wanted a Players class to organize all Player type methods in Game. I am not sure the game really requires it at the moment, but it sounds like a neat idea.

2022-09-11
An example of why I love TDD:
1. I want to build the method #draw? for my Game class.
2. I have to write tests for this method if I want it. The first test I can think of, is that I want the method to return false if the board is not full.
* I note in my head, that the reason the board not being full is a signal for draw? status is because the game is not over yet. I think about how this could affect my game_over? method but keep on the "horizontal" path and keep this "vertical" thought for later.
3. Is my code currently open to knowing if board is full? No. This signals to me that the Board class needs some work.
4. I switch to Board. What I want is a #full? method for Board.
5. I start a test for Board#full?. I want this method to return true if every Column in board is full.
6. Is the Column class open to this? Yes. I can see that the path forward is probably to use an Enumerator to check each Column returns true to #full?, but I stay with the prescribed steps and write the tests first.
7. Once I write Board#full? tests and have them passing, I now have a method to help get my original goal of writing Game#draw? tests.

2022-09-10
I have been seeing lots of family, so it's been hard to work on this project continuously. I think this is good practice though for working on a project in chunks instead of straight through in one go.

I have the game working now. I had spent some time trying to write methods in a not TDD way, but I reverted back to TDD all the way through even though it seems silly sometimes. The mindset is helpful in keeping me on track.

Some methods seem silly to write a test for, but I think these sometimes especially benefit from writing the test first. The test make it clear to me what I am thinking is the purpose of the new method. Sometimes, I realize that I am thinking of a method doing multiple things, and many times when I ask should they be multiple methods? I have almost always answered yes to this, which leads me to realizing I need to write a smaller method before the desired one.

2022-09-05
I have been struggling with this problem of making moves in the game. I have been on vacation and spending time with family which makes it hard to keep track of my thoughts, but I think that is mostly an excuse. The main problem is that my thoughts are too muddled for me to understand or use them.

I am trying to implement a #game_over? check. To do so, I need to make the Board open to knowing what its last drop coordinate was.

Right now, it is not open to that. The Board does not keep track of the order of moves.

The moves themselves are also not really open to this. The board will find the appropriate spot to fill in given a column_num, and fill it in with the given mark. #mark allows you to see what the mark value is given coordinates but having drop fill this mark value in feels wrong.

What the Board class seems to desire in this path of opening to knowing the last_drop, is to be able to do something like [0, 0].mark = 'x' or mark([0, 0]) = 'x'.

2022-09-03 continue
Starting Game tests is difficult. So, I am asking myself, what is the responsibility of Game?

The responsibility of Board is to determine if the game has been won. It also has the responsibility of storing the data of the game in #columns. **(This makes me wonder, should these responsibilities be separate?) One way I think about it that makes me feel the current state is okay, is that Board's responsibility is to handle the game's data. One of the way it handles it is remembering it. Another way is analyzing it.**

The responsibility of BoardCoordinator is to find lines in #columns, which helps Board to find if a win exists.

The responsibility of Game is to propogate Board towards a win (or a draw) and to announce when the game has reached its conclusion.

Game will propogate Board through #run_round. #run_round will be run until the goal is reached (the game is won) through #play and #game_over?. How will Game know what to propogate Board with? It will request input from the players. 

Whose responsibility is it to check if player input is valid?

I think this may fall into Board. Board contains the coordinates, so it would make sense that it would know which coordinates are valid and which are not.

2022-09-03
Extracting BoardCoordinator went much better than when I tried to extract Disc. I think ultimately what made it smoother was that BoardCoordinator had a single responsibility (at least I think it does lol). That responsibility is to take a coordinate return a line.

I refactored BoardCoordinator out for practice and fun. The Board was already functioning as required for the game (or at least we will see if it is).

That said, while there is plenty in Board still that I want to try to refactor, I will hold off for now. I am ready to start writing tests for a completely new class, Game.

2022-09-02 continue
I have a sneaking suspicion that I found the wrong abstraction when extracting the repetitive 'coordinates' parameters. These are coordinates. Cells do have coordinates, but it is it a Cell's job to know other coordinates?

I think perhaps what I really wanted was a Coordinator class. The Coordinator would know given a coordinate, what coordinates relate. It would not know what 'marks' or Cells would be in those coordinates. It simply would tell you, if you want the horizontal line that contains a coordinate, here it is.

Now that seems like a class with a single role or a single action. "Give me a coordinate, and I will return you lines."

2022-09-02
I asked myself this morning, I am having trouble extracting the Column and Cell classes because of how I setup my tests. My tests expecte Board to be able to take an argument of an arrays that represent a board in Connect Four. This made it easy for me to write test boards.

This thought led me to two others. The first, is that if Column and Cell are to be useful, they should be able to fulfill this test. My tests should be easy to follow, and the way they visually look now, I think that is the case.

The second thought, however, is that my tests are misleading! The boards are flipped. I have columns horizontal and rows vertical. This is because of how arrays are defined in Ruby, they lean towards being horizontal (which is in turn a product of how English works).

Why did I make these horizontal arrays represent columns instead of horizontal rows? Because the game has discs traverse through columns, not through rows. I made an unconscious decision that it would be best to keep columns as one clear object.

Going back to my second thought which stems from the first. Visually, for my eyes, I can tell what the arrays with an array are trying to visually represent in the tests. However, is this the best form for the test? How does this array in arrays compare to just having one large array or even a string?

I recall now that originally, I actually wanted to start with the display method of the board. If I had written that method, and it returned a string, then I could have used that string to compare with tests...

But, isn't that going against a core principle of TDD? My tests should be decoupled from code. For example, if my tests all know that a #display method will return a string and that string represents a board, my tests now know something about the code. Worse, that knowing is a dependency! If the display method changed, all of my tests would become a wall of red.

How is this different from the current state of affairs? Right now, with arrays in arrays being fed into the test, my test knows that it gives data grouped in a specific way, the Board class can make that into a board and use the appropriate methods on that data. While things would break if the expected input were to change for Board, that is something that should be foundational to the class and should stay constant if possible. Taking an array of 42 values seems foundational to me. The fact that the 42 values are grouped in 7 'column' arrays I think is also fine, for now.

2022-09-01
I had a thought this morning. My new Disc class seems to have some problems. The use of its methods are currently only being used for helping to find wins on the board. They are also planned to store whatever mark is dropped in each space on the board.

That's where my concern lines. There are discs, but there is also the space the disc resides. Which does my Disc class represent?

If it is the space of the board itself, it is a poor choice of word. In the beginning of the game, the board will have no discs dropped. Will these spaces contain no object then?

My bigger worry is, if these objects are created as they are dropped, then how will a disc already on the board know when a new disc has been dropped beside it? I would have to update all discs each time of the state of the board when a new disc is dropped. That sounds awfully inefficient!

Perhaps it is not. If I think of it concretely, what is this board? This board is a collection of columns, which also happen to be a collection of rows and diagonals. Each row is a collection of spaces which can receive a disc. Each disc will thus have a position on the overall board, but that position will already be known by the space itself. Thus the disc really only needs to know its mark.

I think this idea of spaces presented itself by the fact that I named the parameters for methods 'coordinates'. I did not name them 'discs' but last night I mistook them as Discs.


So, later in the day, I was able to name one of the things that was bugging me. It was a code smell called Primitive Obsession. I was using arrays as coordinates and as columns and as the set of columns. These formed the foundation of data storage in Board. However, these were all ultimately instances of the primitive class, Array. I wanted these to be their own classes. However, when I started work on extracting a class such as Column, I discovered a tremendous horror. Many of my tests relied on the ability to inject an array of arrays into Board.

I am currently fumbling to find a way to inject these extracted classes into Board without breaking my tests. I wonder how I should have written these tests to begin with to avoid this.

I also hear the whisper of shameless green. What is the problem here? My tests are shamelessly green. Sure, there is a code smell here, but I am not trying to make any changes here so should I leave it as is with the code smells and continue on the project?

I'm curious what's going to happen if I continue on this refactoring path, so I am going for it. I realized that I could define #columns to return whatever I want if I define the method instead of attr_reader'ing it. So, if I inject my class and somehow get an array of the same shape to return from the new classes and have that return from #columns, the tests should all still pass.

2022-08-31
I was happy to make my diagonal methods cleaner, and I was able to make horizontal methods fairly quickly.

Extracting methods is fun. I still worry that I am doing things incorrectly, but I keep reminding myself:
- This is not a test that I must get 100% on.
- If I do something incorrectly, the poor solution will reflect it and teach it.

I noticed many of my methods have a parameter called 'coordinates'. Are all of these 'coordinates' the same thing? Should these be methods for a new class? 

I have the same case with the parameter 'column_num'. This one seems easier for me to extract, so I will try that and see what happens.

That actually was not easy. Some of these methods refer to columns, which is a method in Board, so a dependency exists. The next question is, does this dependency need to exist? Or is that the next question? I look at row(row_number) in the context of Board, and I think, "My board does have a row with a row number and the same applies for columns." This leads me to think these methods are fine where they are.

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
"???Despite its apparent import, the choice you make here hardly matters. In the beginning, you have ideas about the problem but actually know very little. Your ideas may turn out to be correct, but it???s just as possible that time will prove them wrong. You can???t figure out what???s right until you write some tests, at which time you may realize that the best course of action is to throw everything away and start over. Therefore, the purpose of some of your tests might very well be to prove that they represent bad ideas. Learning which ideas won???t work is forward progress, however disappointing it may be in the moment.???
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
