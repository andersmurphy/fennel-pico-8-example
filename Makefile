all: games/lua/*.lua

games/lua/%.lua: fnl/%.fnl
# Compile fennel code to lua
		./fennel/fennel --compile $< > $@
# Remove the module return statement generated by fennel
# (the last line of the output .lua file) as pico-8 doesn't
# support return statements outside of functions.
		sed -i '' '$$d' $@
