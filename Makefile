
default:
	make serve_css & make serve_hugo &

serve_css:
	npm run watch --prefix themes/sk0

serve_hugo:
	hugo server -D

clean:
	rm -r public

build:
	make clean
	hugo

# deploy:
# 	make build
# 	npm run deploy

post:
	[[ ! -z ${name} ]] && echo "%x[hugo new posts/${name}.md]"
