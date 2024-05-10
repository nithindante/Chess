# Chess
Chess is a board game for two players, called White and Black, each controlling an army of chess pieces, to checkmate the opponent's king

I split my whole program into 4 modules,  Board, Piece, Main, and Players.  I wrote most of my functions in Board, but I need to refactor and make it cleaner, I wrote around 32 tests for my chess game as well 

If a Player inserts an invalid color, it throws an error message, If a player tries to move a blank cell, that also throws an error,  if a player moves to a inavlid position that is not relative to the piece, it throws an error message,  If the player tries to move to a position which is already ocuupied by the same color, it throws an error message, if an invalid cell is entered, it will throw an error message

Used Serialisation to save data to a YAML file, so that the board and the previous players' moves are stored. 

After throwing the error message, it asks for the input again until the correct input is sent 

One can exit from the Game by entering nil values when asked for Source and Destination 
