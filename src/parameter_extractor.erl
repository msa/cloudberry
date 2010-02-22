-module(parameter_extractor).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

it_should_extract_parameter_based_on_single_quotes_test() ->
  {"Jojo, verkar som att $1 har fyllt 2", ["nisse"]} = extract("Jojo, verkar som att 'nisse' har fyllt 2").

it_should_extract_parameters_based_on_single_quotes_test() ->
  {"Jojo, verkar som att $1 har fyllt $2", ["nisse", "2"]} = extract("Jojo, verkar som att 'nisse' har fyllt '2'").

it_should_extract_empty_list_when_no_parameters_are_passed_test() ->
  {"Jojo, verkar som att nisse har fyllt 2", []} = extract("Jojo, verkar som att nisse har fyllt 2").

extract(Paramtext, nomatch) ->  {Paramtext, []};

extract(Paramtext, {match, Matches}) ->
  extract(Paramtext, Matches, []).

extract(Paramtext) ->
  extract(Paramtext, re:run(Paramtext, "'([^'\\s]*)'", [global, {capture, all, list}])).

extract(Paramtext, [], L) -> {Paramtext, lists:reverse(L)};

extract(Paramtext, [[Quote|Value]|T], L) ->
  RegExp = string:concat("\\$", integer_to_list(length(L) + 1)),
  Paramtext2 = re:replace(Paramtext, Quote, RegExp, [{return, list}]),
  [Value2|_] = Value,
  extract(Paramtext2, T, [Value2|L]).
