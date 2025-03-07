PROGRAM_NAME := y_diffusion
PROGRAM_NAME_EX := y_diffusion_extrae

CC := mpic++
#CC := g++

ARCH := native

LIBEX=-L/apps/GPP/BSCTOOLS/extrae/4.2.0/openmpi_4_1_5_gcc/lib -lomptrace
INC_EXTRAE=-I /apps/GPP/BSCTOOLS/extrae/4.2.0/openmpi_4_1_5_gcc/include/
FLAGS := -march=$(ARCH) -O0 -fomit-frame-pointer -fopenmp  -std=c++11 -fpermissive -g

COMPILE_COMMAND := $(CC) $(FLAGS)

Tridiagonals_OBJECTS := utils.o microenvironment.o kernels.o
Tridiagonals_OBJECTS_nmpi := utils.o microenvironment_nmpi.o kernels_nmpi.o

tridiagonals: tridiagonals.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -o tridiagonals tridiagonals.cpp $(Tridiagonals_OBJECTS) ${INC_EXTRAE}

tridiagonals_ex: tridiagonals.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -DEXTRAE_LINK -o tridiagonals_ex tridiagonals.cpp $(Tridiagonals_OBJECTS) ${LIBEX} ${INC_EXTRAE}

tridiagonals_512: tridiagonals_512.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -o tridiagonals_512 tridiagonals_512.cpp $(Tridiagonals_OBJECTS) 

tridiagonals_512_ex: tridiagonals_512.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -DEXTRAE_LINK -o tridiagonals_512_ex tridiagonals_512.cpp $(Tridiagonals_OBJECTS) ${LIBEX} ${INC_EXTRAE}

novector: novector.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -o novector novector.cpp $(Tridiagonals_OBJECTS) ${INC_EXTRAE}

novector_ex: novector.cpp $(Tridiagonals_OBJECTS)
	    $(COMPILE_COMMAND) -DEXTRAE_LINK -o novector_ex novector.cpp $(Tridiagonals_OBJECTS) ${LIBEX} ${INC_EXTRAE} 

utils.o: utils.cpp
	$(COMPILE_COMMAND) -c utils.cpp

microenvironment.o: microenvironment.cpp
	$(COMPILE_COMMAND) -c microenvironment.cpp

microenvironment_nmpi.o: microenvironment_nmpi.cpp
	$(COMPILE_COMMAND) -c microenvironment_nmpi.cpp

kernels.o: kernels.cpp
	$(COMPILE_COMMAND) -c kernels.cpp

kernels_nmpi.o: kernels_nmpi.cpp
	$(COMPILE_COMMAND) -c kernels_nmpi.cpp

tridiagonals_nmpi: tridiagonals_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)
	    $(COMPILE_COMMAND) -o tridiagonals_nmpi tridiagonals_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)

tridiagonals_512_nmpi: tridiagonals_512_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)
	    $(COMPILE_COMMAND) -o tridiagonals_512_nmpi tridiagonals_512_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)

novector_nmpi: novector_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)
	    $(COMPILE_COMMAND) -o novector_nmpi novector_nmpi.cpp $(Tridiagonals_OBJECTS_nmpi)

memory: memory.cpp $(Tridiagonals_OBJECTS_nmpi)
	    $(COMPILE_COMMAND) -o memory memory.cpp $(Tridiagonals_OBJECTS_nmpi)

perf_stat:
	make tridiagonals_nmpi
	make tridiagonals_512_nmpi
	make novector_nmpi
clean:
	rm -f tridiagonals
	rm -f tridiagonals_512
	rm -f tridiagonals_512_nmpi
	rm -f tridiagonals_nmpi
	rm -f novector
	rm -f novector_nmpi
	rm -f *.o
