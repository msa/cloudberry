-module(story_runner).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

can_see_correct_number_of_files_test() ->
  1 = length(story_files_in_dir("./test_resources")).

can_see_correct_files_test() ->
  ["./test_resources/test.story"] = story_files_in_dir("./test_resources").

will_run_all_lines_in_story_test() ->
  for_each("./test_resources/test.story").

run(Dir) ->
  run_story(story_files_in_dir(Dir)).

story_files_in_dir(Dir) ->
  filelib:wildcard(filename:join(Dir, "*.story")).

run_story(L) -> run_story(L, 0).

run_story([], 1) -> io:format("~nSuccessfully ran 1 story.~n");
run_story([], Count) -> io:fwrite("~nSuccessfully ran ~B stories.~n", [Count]);

run_story([Story|Stories], Count) ->
  io:format("~nRunning story..."),
  for_each(Story),
  run_story(Stories, Count + 1).

for_each(Story) ->
  Text = story_reader:read(Story),
  Scenarios = scenario_extractor:extract_scenarios(Text),
  run_steps(Scenarios).

run_steps([{scenario, ScenarioDescription, Steps}| Scenarios]) ->
  io:format(string:concat(string:concat("~n", ScenarioDescription), "~n")),
  step_runner:run_steps(Steps),
  run_steps(Scenarios);

run_steps([]) -> done.


