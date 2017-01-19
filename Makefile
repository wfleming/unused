.PHONY: codeclimate

tmp/unused: **.hs
	mkdir -p tmp
	stack install \
		--docker \
		--work-dir .stack-work-docker \
		--local-bin-path ./tmp

codeclimate: build/unused
	docker build \
		--tag codeclimate/codeclimate-unused \
		--file CodeClimateEngine.dockerfile .

