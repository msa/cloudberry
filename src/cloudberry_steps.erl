-module(cloudberry_steps).
-compile(export_all).

step("Givet att jag märker det") ->
  io:format("Märksteg");

step("När den här storyn körs") ->
  io:format("Körsteg");

step("Så blir jag glad") ->
  io:format("Gladsteg").

step("Givet att jag har en $1", [Parameter]) ->
  io:format("Parametersteg");

step("När $1 kan skrivas ut med sin vikt $2 $3", [Namn, Vikt, Sort]) ->
  io:format(string:concat(string:concat(Namn, " väger "), string:concat(Vikt, Sort))).
