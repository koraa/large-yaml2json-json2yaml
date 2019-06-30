JOBS := $(shell < /proc/cpuinfo grep processor | wc -l)
JOBS ?= 2

PREFIX ?= /usr/local

CPPFLAGS += -I"$(PWD)/vendor/include" -I"$(PWD)/vendor/rapidjson/include/"
CXXFLAGS ?= -O3
CXXFLAGS += -std=c++11 -Wall -Wpedantic -Wextra
LDFLAGS  += -std=c++11 -Wall -Wpedantic -Wextra

.PHONY: all
all: json2yaml yaml2json

j2y_objs = json2yaml.o yaml_scalar_parse.o
json2yaml: $(j2y_objs) deps/lib/libyaml.a
	$(CXX) $(LDFLAGS) $(j2y_objs) deps/lib/libyaml.a -o json2yaml

y2j_objs = yaml2json.o yaml_scalar_parse.o
yaml2json: $(y2j_objs) deps/lib/libyaml.a
	$(CXX) $(LDFLAGS) $(y2j_objs) deps/lib/libyaml.a -o yaml2json

$(y2j_objs) $(j2y_objs): yaml_scalar_parse.hpp deps/lib/libyaml.a

deps/lib/libyaml.a:
	mkdir -p "$(PWD)/"deps/build/libyaml         && \
		rm -R deps/build/libyaml                   && \
		cp -R vendor/libyaml deps/build/           && \
	  cd deps/build/libyaml                      && \
		./bootstrap                                && \
		./configure --prefix="$(PWD)/deps/"        && \
		$(MAKE)                                    && \
		$(MAKE) install

.PHONY: install

install: json2yaml yaml2json
	cp -v json2yaml yaml2json "$(PREFIX)/bin"

.PHONY: clean clean-deps

clean:
	rm -f yaml2json json2yaml $(j2y_objs) $(y2j_objs)

clean-deps:
	rm -Rf deps/
