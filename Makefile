crux:
	docker run -d -p 3000:3000 --name CruxDB juxt/crux-standalone:20.09-1.11.0

all: deps app protocols

get-deps:
	rm -f mix.lock
	mix deps.get

deps: get-deps
	mix deps.compile

app:
	mix compile

protocols:
	mix compile.protocols

clean-deps:
	mix deps.clean --all
	rm -rf deps

clean: clean-deps
	mix clean

test: app
	mix test

docs:
	MIX_ENV=docs mix docs

publish:
	mix hex.publish
	mix hex.publish docs
