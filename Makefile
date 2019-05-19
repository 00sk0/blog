
default:
	make serve

serve:
	make serve_theme & make serve_hugo

serve_theme:
	npm run watch --prefix themes/sk0

serve_hugo:
	hugo server -D --disableFastRender 

clean:
	rm -r public

build:
	make clean
	hugo

# deploy:
# 	make build
# 	npm run deploy

post:
	[[ ! -z ${name} ]] && ruby -e "%x[hugo new posts/${name}.md]"
