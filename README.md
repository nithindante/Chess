# Chess
Chess is a board game for two players, called White and Black, each controlling an army of chess pieces, to checkmate the opponent's king

I split my whole program into 4 modules,  Board, Piece, Main, and Players.  I wrote most of my functions in Board, but I need to refactor and make it cleaner, I wrote around 32 tests for my chess game as well 

If a Player inserts an invalid color, it throws an error message, If a player tries to move a blank cell, that also throws an error,  if a player moves to a inavlid position that is not relative to the piece, it throws a error message,  If the player tries to move to a position which is already ocuupied by the same color, it throws a error message.

After throwing the error message, it asks for the input again until the correct input is send 

Need to include the functionality where if a invalid cell is entered, it should throw a error message
