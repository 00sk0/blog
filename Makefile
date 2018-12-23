
default:
	make serve_css & make serve_hugo &

serve_css:
	npm run watch --prefix themes/sk0

serve_hugo:
	hugo server -D

clean:
	rm -r public

product:
	hugo

hoge:
	[[ ! -z ${name} ]] && echo "%x[hugo new posts/${name}.md]"
