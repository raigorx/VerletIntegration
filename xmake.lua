add_rules("mode.debug", "mode.release", "mode.check", "mode.tsan", "mode.lsan" ,"mode.ubsan","mode.valgrind")
set_policy("build.sanitizer.address", true)
add_rules("plugin.vsxmake.autoupdate")
add_rules("plugin.compile_commands.autoupdate")

set_languages("c17", "c++20")

set_warnings("allextra")

add_cxflags("gcc::-Wconversion")
add_cxflags("gcc::-Wsign-conversion")

add_cxflags("cl::/DUNICODE")
add_cxflags("cl::/Wall")

if is_mode("debug") then
  add_cxflags("cl::/MDd")
else
  add_cxflags("cl::/MD")
end

add_includedirs("src/dependencies/include")

if is_plat("windows") then
  add_defines("WIN32", "__WIN32__")
end

if is_plat("windows") and is_mode("debug") then
  add_linkdirs("src/dependencies/library/windows/glfw/Debug/Static")
  add_linkdirs("src/dependencies/library/windows/glew/Debug/x64")
  add_links("glfw3", "glew32d")
  add_syslinks("opengl32", "gdi32", "user32", "kernel32", "shell32")
else
  add_linkdirs("src/dependencies/library")
  add_links("pthread", "glfw", "GLEW")
  add_syslinks("Cocoa", "OpenGL", "IOKit")
end

target("VerletIntegration")
    set_kind("binary")
    add_files("src/*.c")