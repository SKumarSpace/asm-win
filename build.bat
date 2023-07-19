nasm -f win64 -o hello_world.obj hello_world.asm

link hello_world.obj /subsystem:console /out:hello_world_basic.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib

hello_world_basic.exe