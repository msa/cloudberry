-module(story_reader).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

it_should_read_non_blank_lines_into_a_list_of_strings_test() ->
  ["För att kunna låta verksamhetskunniga personer delta i utvecklingsarbetet", "Som utvecklare", "Vill jag kunna köra normalspråkliga specifikationer som verifikationer av systemet under utveckling","Scenario: Parameterlösa steg", "Givet att jag märker det","När den här storyn körs","Så blir jag glad", "Scenario: Steg med parametrar", "Givet att jag har en 'parameter'","När flera 'parametrar' kan hanteras 'en' 'ytterligare'","Så blir jag glad"] = read("./test_resources/test.story").

read(Storyfile) ->
  {ok, File} = file:open(Storyfile, read),
  read([], io:get_line(File, ""), File).

read(Acc, eof, File) ->
  file:close(File),
  lists:reverse(Acc);

read(Acc, Line, File) -> 
  TrimmedLine = re:replace(Line, "\n", "", [{return, list}]),
  Acc2 = collect_non_blank_lines(string:len(TrimmedLine), TrimmedLine, Acc),
  read(Acc2, io:get_line(File, ""), File).


collect_non_blank_lines(0, _, Acc) -> Acc;
collect_non_blank_lines(_, Line, Acc) -> [Line|Acc].

