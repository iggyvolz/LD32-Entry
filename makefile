globals := love
jenkins: check pkg
check:
	luacheck *.lua --globals $(globals)
pkg:
	zip -9 ld31.love `find .|grep -v git`
