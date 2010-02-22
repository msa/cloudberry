-module(step_runner).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

it_should_run_step_without_parameters_test() ->
  run_step("Givet att jag märker det", [], mysteps).

run_step(Step, [], Module) -> run_step(Step, Module);

run_step(Step, Parameters, Module) ->
  Module:step(Step, Parameters).

run_step(Step,Module) ->
  Module:step(Step).
