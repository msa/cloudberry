-module(mysteps).
-compile(export_all).

step("Step without parameter") ->
  io:format("Step without parameter");

step("Another step") ->
  io:format("Running another step");

step("Givet att jag märker det") ->
  io:format("Märksteg");

step("Nar den har storyn kors") ->
  io:format("Körsteg");

step("Sa blir jag glad") ->
  io:format("Gladsteg").

step("Step with one $1", _) ->
  io:format("Parametersteg").
