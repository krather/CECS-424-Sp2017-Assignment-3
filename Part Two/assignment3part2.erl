-module(assignment3part2).
-export([readFile/1, addWord/2, hashWordFrequency/1, howMany/1]).

readFile(FileName) ->
	{ok, Device} = file:open(FileName, read), %I got the idea for the tuple {ok, Device} from various StackOverflow questions. For some reason, using just a variable prompted an error.
	Temp = io:get_line(Device, ""),
	List = string:tokens(Temp, " ").

addWord(Word, Tuple) ->
	case lists:keyfind(Word, 1, Tuple) of
		false ->
			TempList = [{Word, 1}],
			lists:append(TempList, Tuple);
		Otherwise ->
			TempTuple = lists:keyfind(Word, 1, Tuple),
			lists:keyreplace(Word, 1, Tuple, {element(1,TempTuple), element(2,TempTuple)+1})
	end.
	
hashWordFrequency(ListOfWords) ->
	lists:foldl(fun(Word, Acc) -> addWord(string:to_lower(Word),Acc) end, [], ListOfWords).

howMany(FileName) ->
	lists:sort(hashWordFrequency(readFile(FileName))).