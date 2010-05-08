-module(cloudberry_steps).
-compile(export_all).

step("Givet att jag märker det") -> 0;

step("När den här storyn körs") -> 0;

step("Så blir jag glad") -> 0.

step("Givet att jag har en $1", [Parameter]) -> 0;

step("När flera $1 kan hanteras $2 $3", [Parametertext, Parameter2, Parameter3]) -> 0.
