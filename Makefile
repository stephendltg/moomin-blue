#!make
PROJECT=app
VERSION=v14.16.1
NVM=v0.38.0

all: 
	docker-compose up -d

install: 
	@echo "Installing project ${PROJECT}..."
	. ${NVM_DIR}/nvm.sh && nvm install ${VERSION} && nvm use ${VERSION}
	npm install
	npm i install autocannon -g
	npm install -g clinic

install-rasp:
	@echo "Installing for raspberry"
	sudo apt-get install libsqlite3-dev
	npm install sqlite3 --build-from-source --sqlite=/usr
	npm i install autocannon -g
	npm install -g clinic

bench:
	@echo "Benchmark ... https://github.com/mcollina/autocannon#readme"
	autocannon -c 100 -d 5 -p 10 http://localhost:3000

doctor:
	@echo "Doctor ... https://github.com/clinicjs/node-clinic#readme"
	clinic doctor --autocannon [ / ] -- node ./src/www

inspect:
	@echo "Inspect ..."
	node --inspect ./src/www

clean:
	@echo "Clean project ${PROJECT}..."
	npm run clean
	rm -rf ./node_modules

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM}/install.sh | bash


help: 
	@echo "install: Install ${PROJECT}"
	@echo "production: Start production ${PROJECT}"
	@echo "stop-production: Stop production ${PROJECT}"
	@echo "staging: Start staging ${PROJECT}"
	@echo "stop-staging: Start staging ${PROJECT}"
	@echo "dev: Start dev ${PROJECT}"
	@echo "clean: Clean ${PROJECT}"
	@echo "nvm: NVM install${PROJECT}"