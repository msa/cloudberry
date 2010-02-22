
APPNAME=cloudberry

SUB_DIRECTORIES=src

include vsn.mk

DOC_OPTS={def,{version,\"$(CLOUDBERRY_VSN)\"}}


all: subdirs

subdirs:
	mkdir -p ebin
	@for d in $(SUB_DIRECTORIES); do \
	  	(cd $$d; $(MAKE)); \
	done

clean:
	@for d in $(SUB_DIRECTORIES); do \
	  	(cd $$d; $(MAKE) clean); \
	done

docs:
	mkdir -p doc
	erl -noshell -eval "edoc:application($(APPNAME), \".\", [$(DOC_OPTS)])" -s init stop

test: subdirs
	@echo Testing...
	@erl -noshell -pa ebin -eval 'eunit:test([step_runner, story_runner, parameter_extractor, scenario_extractor])' -s init stop
