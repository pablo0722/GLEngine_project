engine_name = GLEngine
inc = -I include
out = lib

engine_src = dependencies/${engine_name}_src
engine_bin = dependencies/${engine_name}_src/bin
engine_libname = ${engine_name}

khr_src = dependencies/${engine_name}_src/Khr_src
khr_bin = dependencies/${engine_name}_src/Khr_src/bin
khr_libname = Khr

egl_src = dependencies/${engine_name}_src/Khr_src/Egl_src
egl_bin = dependencies/${engine_name}_src/Khr_src/Egl_src/bin
egl_libname = Egl

winsystem_src = dependencies/WindowSystem_src
winsystem_bin = dependencies/WindowSystem_src/bin
windowsystem_libname = WindowSystem

all:
	make clean
	make Engine_createExample
	./Engine_createExample

test: ${out}/lib${engine_libname}.a
	g++ -o test egl_example.cpp -L lib -l${engine_libname} ${inc} -lX11 -lGLESv2 -lEGL

Engine_createExample: ${out}/lib${engine_libname}.a
	g++ -o Engine_createExample Engine_createExample.cpp -L lib -l${engine_libname} ${inc} -lX11 -lGLESv2 -lEGL

WindowSystem_createExample: ${out}/lib${windowsystem_libname}.a
	g++ -o WindowSystem_createExample WindowSystem_createExample.cpp -L lib -l${windowsystem_libname} ${inc} -lX11

clean: clean_winsystem clean_engine clean_khr clean_egl
	rm -rf ./*.o ./main_linux ./test ./Engine_createExample ./WindowSystem_createExample

# MAKE ENGINE LIB
${out}/lib${engine_libname}.a: ${engine_bin}/lib${engine_libname}_isolated.a ${out}/lib${windowsystem_libname}.a ${out}/lib${khr_libname}.a
	printf "CREATE ${out}/lib${engine_libname}.a\nADDLIB ${engine_bin}/lib${engine_libname}_isolated.a\nADDLIB ${out}/lib${windowsystem_libname}.a\nADDLIB ${out}/lib${khr_libname}.a\nSAVE\nEND" | ar -M

${engine_bin}/lib${engine_libname}_isolated.a: ${engine_bin}/${engine_name}.o
	mkdir -p ${engine_bin}
	ar -rcs ${engine_bin}/lib${engine_libname}_isolated.a ${engine_bin}/${engine_name}.o

${engine_bin}/${engine_name}.o: ${engine_src}/${engine_name}.cpp
	mkdir -p ${engine_bin}
	g++ -c ${engine_src}/${engine_name}.cpp -o ${engine_bin}/${engine_name}.o ${inc}

clean_engine:
	rm -rf ${engine_bin} ${out}/lib${engine_libname}.a

# MAKE KHR LIB
${out}/lib${khr_libname}.a: ${khr_bin}/lib${khr_libname}_isolated.a ${out}/lib${egl_libname}.a
	printf "CREATE ${out}/lib${khr_libname}.a\nADDLIB ${khr_bin}/lib${khr_libname}_isolated.a\nADDLIB ${out}/lib${egl_libname}.a\nSAVE\nEND" | ar -M

${khr_bin}/lib${khr_libname}_isolated.a: ${khr_bin}/Khr.o
	mkdir -p ${khr_bin}
	ar -rcs ${khr_bin}/lib${khr_libname}_isolated.a ${khr_bin}/Khr.o

${khr_bin}/Khr.o: ${khr_src}/Khr.cpp
	mkdir -p ${khr_bin}
	g++ -c ${khr_src}/Khr.cpp -o ${khr_bin}/Khr.o ${inc}

clean_khr:
	rm -rf ${khr_bin} ${out}/lib${khr_libname}.a

# MAKE EGL LIB
${out}/lib${egl_libname}.a: ${egl_bin}/Egl.o
	mkdir -p ${out}
	ar -rcs ${out}/lib${egl_libname}.a ${egl_bin}/Egl.o

${egl_bin}/Egl.o: ${egl_src}/Egl.cpp
	mkdir -p ${egl_bin}
	g++ -c ${egl_src}/Egl.cpp -o ${egl_bin}/Egl.o ${inc}

clean_egl:
	rm -rf ${egl_bin} ${out}/lib${egl_libname}.a

# MAKE WINDOW_SYSTEM LIB

${out}/lib${windowsystem_libname}.a: ${winsystem_bin}/WindowSystem_X11.o
	mkdir -p ${out}
	ar -rcs ${out}/lib${windowsystem_libname}.a ${winsystem_bin}/WindowSystem_X11.o

${winsystem_bin}/WindowSystem_X11.o: ${winsystem_src}/WindowSystem_X11.cpp
	mkdir -p ${winsystem_bin}
	g++ -c ${winsystem_src}/WindowSystem_X11.cpp -o ${winsystem_bin}/WindowSystem_X11.o ${inc}

clean_winsystem:
	rm -rf ${winsystem_bin} ${out}/lib${windowsystem_libname}.a