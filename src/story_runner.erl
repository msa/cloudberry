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
  {ok, File} = file:open(Story, read),
  for_each_step(io:get_line(File, ""), File).

for_each_step(eof, File) ->
  file:close(File);

for_each_step(Line, File) ->
  TrimmedLine = re:replace(Line, "\n", "", [{return, list}]),
  run_step(string:len(TrimmedLine), TrimmedLine, File).

run_step(0, _, File) ->
  for_each_step(io:get_line(File, ""), File);

run_step(_, Line, File) ->
  {StepText, Parameters} = parameter_extractor:extract(Line),
  io:format(string:concat(string:concat("\nRunning step: ", StepText), "\n")),
  step_runner:run_step(StepText, Parameters, cloudberry_steps),
  for_each_step(io:get_line(File, ""), File).
