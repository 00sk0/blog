
document.addEventListener("DOMContentLoaded", function(_e) {
	const links = Array.from(document.getElementsByTagName("a"));
	links.forEach(e => {
		if (e.innerHTML.match(/^https?:\/\//)) {
			e.style.wordBreak = "break-all";
		}
	});
	const ps = Array.from(document.getElementsByTagName("p"));
	ps.forEach(p => {
		p.innerHTML = p.innerHTML.replace(/．\ /, "．");
	});
});

