-module(step_runner).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

it_should_run_step_without_parameters_test() ->
  run_step("Givet att jag märker det", [], mysteps).

run_steps([]) -> done;

run_steps([Step|Steps]) ->
  {Steptext, Parameters} = parameter_extractor:extract(Step),
  run_step(Steptext, Parameters, cloudberry_steps),
  run_steps(Steps).

run_step(Step, [], Module) -> run_step(Step, Module);

run_step(Step, Parameters, Module) ->
  io:fwrite(string:concat(Step, "~n")),
  Module:step(Step, Parameters).

run_step(Step,Module) ->
  io:fwrite(string:concat(Step, "~n")),
  Module:step(Step).
