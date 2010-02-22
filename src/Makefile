
include ../vsn.mk

EMULATOR=beam
EBIN=../ebin
INCLUDE=../include

APP_TARGET=$(EBIN)/cloudberry.app
APPUP_TARGET=$(EBIN)/cloudberry.appup

ERL_COMPILE_FLAGS += -I$(INCLUDE) +warn_unused_vars +nowarn_shadow_vars +warn_unused_import

SOURCES= \
	parameter_extractor.erl \
	step_runner.erl \
	cloudberry_steps.erl \
	mysteps.erl \
	scenario_extractor.erl \
	story_runner.erl

OBJECTS=$(SOURCES:%.erl=$(EBIN)/%.$(EMULATOR)) $(APP_TARGET) $(APPUP_TARGET)

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)

$(EBIN)/%.$(EMULATOR):%.erl
	erlc -pa $(EBIN) -W $(ERL_COMPILE_FLAGS) -o$(EBIN) $<

$(APP_TARGET): cloudberry.app.src ../vsn.mk
	sed -e 's;%VSN%;$(CLOUDBERRY_VSN);' $< > $@

$(APPUP_TARGET): cloudberry.appup.src ../vsn.mk
	sed -e 's;%VSN%;$(CLOUDBERRY_VSN);' $< > $@
