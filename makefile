jenkins: check pkg
check:
	luacheck *.lua --globals love
pkg:
	zip -9 ld31.love `find .|grep -v git`
