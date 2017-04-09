-module(assignment3part1).
-export([candy/4]).

candy(A, B, C, Turns) when A rem 2 =/= 0; B rem 2 =/= 0; C rem 2 =/= 0 ->
	io:format("Incorrect usage of the program. ~nPlease ensure that all kids have an EVEN number of candy to start with."),
	io:format("~n ~nUsage: candy(EVEN#ofKidACandy, EVEN#ofKidBCandy, EVEN#ofKidCCandy, #OfTurns).~n");
	
candy(A, B, C, Turns) when A =:= B, B =:= C ->
	io:format("~nAll of the kids have an equal pieces of candy left!! Turns left: ~p ~nGood job! Exiting program.~n", [Turns]);
	
candy(A, B, C, Turns) when Turns =:= 0 ->
	io:format("~nGame end!");
	
candy(A, B, C, Turns) when A rem 2 =:= 0, B rem 2 =:= 0, C rem 2 =:= 0 ->
	TempCandyA = A div 2,
	TempCandyB = B div 2,
	TempCandyC = C div 2,
	NewCandyA = TempCandyA + TempCandyC,
	NewCandyB = TempCandyB + TempCandyA,
	NewCandyC = TempCandyC + TempCandyB,
	if	%There might be a better way to do this, but for now we need to check the power series of the kids' candy quantities.
		%I originally attempted to check only the individual cases of kids (If KidA has odd, if KidB has odd, if KidC has odd), 
		%But each case had it's own recursive call, which effectively interrupted the checking process.
		%I also tried having some pseudo-boolean value (like a flag) to simplify this, but since variables are immutable in Erlang,
		%I couldn't find an efficient solution there either...T_T. I feel like there's a way to get around this.
		%Prof. Giacalone, let's talk about this on Tuesday! I'm curious as to what I could've done better here...
		
		NewCandyA rem 2 =/= 0, NewCandyB rem 2 =/= 0, NewCandyC rem 2 =/= 0 -> %If ALL kids have odd numbers of candy.
			io:format("~nAll kids had odd pieces of candy (~p for A, ~p for B, ~p for C), so the teacher gave them one.", [NewCandyA, NewCandyB, NewCandyC]),
			FixedCandyA = NewCandyA + 1,
			FixedCandyB = NewCandyB + 1,
			FixedCandyC = NewCandyC + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [FixedCandyA, FixedCandyB, FixedCandyC]),
			candy(FixedCandyA, FixedCandyB, FixedCandyC, Turns - 1);
			
		NewCandyA rem 2 =/= 0, NewCandyB rem 2 =/= 0 -> %If kids A and B have odd numbers of candy.
			io:format("~nKid A and Kid B wound up with ~p and ~p pieces of candy, so the teacher gave them one.", [NewCandyA, NewCandyB]),
			FixedCandyA = NewCandyA + 1,
			FixedCandyB = NewCandyB + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [FixedCandyA, FixedCandyB, NewCandyC]),
			candy(FixedCandyA, FixedCandyB, NewCandyC, Turns - 1);
			
		NewCandyA rem 2 =/= 0, NewCandyC rem 2 =/= 0 -> %If kids A and C have odd numbers of candy.
			io:format("~nKid A and Kid C wound up with ~p and ~p pieces of candy, so the teacher gave them one.", [NewCandyA, NewCandyC]),
			FixedCandyA = NewCandyA + 1,
			FixedCandyC = NewCandyC + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [FixedCandyA, NewCandyB, FixedCandyC]),
			candy(FixedCandyA, NewCandyB, FixedCandyC, Turns - 1);
			
		NewCandyB rem 2 =/= 0, NewCandyC rem 2 =/= 0 ->	%If kids B and C have odd numbers of candy.
			io:format("~nKid B and Kid C wound up with ~p and ~p pieces of candy, so the teacher gave them one.", [NewCandyB, NewCandyC]),
			FixedCandyB = NewCandyB + 1,
			FixedCandyC = NewCandyC + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [NewCandyA, FixedCandyB, FixedCandyC]),
			candy(NewCandyA, FixedCandyB, FixedCandyC, Turns - 1);
		
		NewCandyA rem 2 =/= 0 -> %If ONLY kid A has odd candy
			io:format("~nKid A wound up with ~p pieces of candy, so the teacher gave them one.", [NewCandyA]),
			FixedCandyA = NewCandyA + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [FixedCandyA, NewCandyB, NewCandyC]),
			candy(FixedCandyA, NewCandyB, NewCandyC, Turns - 1);
			
		NewCandyB rem 2 =/= 0 -> %If ONLY kid B has odd candy
			io:format("~nKid B wound up with ~p pieces of candy, so the teacher gave them one.", [NewCandyB]),
			FixedCandyB = NewCandyB + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [NewCandyA, FixedCandyB, NewCandyC]),
			candy(NewCandyA, FixedCandyB, NewCandyC, Turns - 1);
			
		NewCandyC rem 2 =/= 0 -> %If ONLY kid C has odd candy
			io:format("~nKid C wound up with ~p pieces of candy, so the teacher gave them one.", [NewCandyC]),
			FixedCandyC = NewCandyC + 1,
			io:format("~nKid A has: ~p pieces. ~nKid B has: ~p pieces. ~nKid C has: ~p pieces.", [NewCandyA, NewCandyB, FixedCandyC]),
			candy(NewCandyA, NewCandyB, FixedCandyC, Turns - 1);
			
		true ->
			candy(NewCandyA, NewCandyB, NewCandyC, Turns - 1)
	end.