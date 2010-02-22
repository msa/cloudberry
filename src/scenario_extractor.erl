-module(scenario_extractor).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

it_should_ignore_lines_before_scenario_keyword_test() ->
  [] = extract_scenarios(["junk text", "more junk", "nothing here"]).

it_should_extract_scenario_description_test() ->
  [{scenario, "Scenario: Description in many words", []}] = extract_scenarios(["Scenario: Description in many words"]).

it_should_extract_step_for_scenario_test() ->
  [{scenario, "Scenario: Description", ["Step one"]}] = extract_scenarios(["Scenario: Description", "Step one"]).

it_should_extract_step_for_scenario_in_left_to_right_fashion_test() ->
  [{scenario, "Scenario: Description", ["Step one", "Step two"]}] = extract_scenarios(["Scenario: Description", "Step one", "Step two"]).

it_should_reverse_scenarios_and_steps_test() ->
  [{scenario, "Scenario: 1", ["Step 1", "Step 2"]},{scenario, "Scenario: 2", ["Step 1", "Step 2"]}] = reverse_all([{scenario, "Scenario: 2", ["Step 2", "Step 1"]}, {scenario, "Scenario: 1", ["Step 2", "Step 1"]}]).

extract_scenarios([Line|Lines]) -> extract_scenarios(matches_scenario(Line), Line, Lines, []).

extract_scenarios(nomatch, Step, [NextLine|Lines], [{scenario, Desc, Steps}|Scenarios]) -> 
  extract_scenarios(matches_scenario(NextLine), NextLine, Lines, [{scenario, Desc, [Step|Steps]}|Scenarios]);

extract_scenarios(nomatch, _, [Line|Lines], []) -> extract_scenarios(matches_scenario(Line), Line, Lines, []);

extract_scenarios(nomatch, nothing, [], Scenarios) -> reverse_all(Scenarios);
extract_scenarios(nomatch, LastStep, [], [{scenario, Scenario, Steps}|Scenarios]) -> reverse_all([{scenario, Scenario, [LastStep|Steps]} | Scenarios]);
extract_scenarios(nomatch, _, [], []) -> [];

extract_scenarios(_, Scenario, [], []) ->
  extract_scenarios(nomatch, nothing, [], [{scenario, Scenario, []}]);

extract_scenarios(_, Scenario, [Line|Lines], []) -> 
  extract_scenarios(matches_scenario(Line), Line, Lines, [{scenario, Scenario, []}]);

extract_scenarios(_, Scenario, [Line|Lines], Scenarios) -> 
  extract_scenarios(matches_scenario(Line), Line ,Lines, [{scenario, Scenario, []}|Scenarios]).

matches_scenario(Line) -> re:run(Line, "^Scenario: ").

reverse_all(Scenarios) -> reverse_all(Scenarios, []).
reverse_all([], Scenarios) -> Scenarios;
reverse_all([{scenario, Description, Step}|Scenarios], Acc) ->
  reverse_all(Scenarios, [{scenario, Description, lists:reverse(Step)}|Acc]).
