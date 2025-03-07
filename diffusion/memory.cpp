#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <chrono>
#include <omp.h>
#include <mpi.h>
#include "./microenvironment.h"
#include "./utils.h"



using namespace std;


double error = 0.00001;

long long test_BioFVM(long long voxels, long long substrates) {
    vector<double> one(substrates, 1.0);
    vector<vector<double>> box(voxels, one);
    long long bytes = 0;
    #pragma omp parallel for reduction(+:bytes)
    for(int i = 0; i < box.capacity(); ++i) {
        bytes += sizeof(box[i]) + (sizeof(double) * box[i].capacity());
    }
    bytes += sizeof(box); 
    return bytes; 
}

long long test_BioFVM_B(long long voxels, long long substrates) {
    long long positions = voxels * substrates;
    vector<vector<double>> box;
    box.resize(positions);
    long long bytes = 0;
    bytes += sizeof(box); 
    bytes += sizeof(double)*box.capacity();
    return bytes; 
}

int main(int argc, char* argv[]) {
  
    #ifdef EXTRAE_LINK
        Extrae_shutdown();
    #endif

    double side, delta;
    int densities;
    int factor;
    int threads;
    string path;
    if (argc == 4) {
        delta = atof(argv[1]);
        threads = atoi(argv[2]);
        path = argv[3];        
	} 
	else {
		cout << "Error: Expected arguments are: " << endl;
        cout << "   1. Simulation cube side (um)" << endl;
        cout << "   2. Discretization  (um)" << endl;
        cout << "   3. Number of densities" << endl;
        cout << "   4. OMP threads" << endl;
        cout << "   5. Path to csv timing" << endl;
		exit(1);
	}
    int size, wrank;
    /* Declaracion de variables */
    MPI_Init(&argc, &argv);
    /* Reparto de contenido */
    /* Bucle principal del programa */
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &wrank);

    omp_set_num_threads(threads);
    
    vector<double> v;

    /*
    if (wrank == 0 ) {    
        cout << "Cube side:  " << side << " um" << endl;
        cout << "Number of voxels per dimension " << side/delta << endl;
        cout << "Total voxels " << side/delta * side/delta * side/delta << endl;
        cout << "Number of substrates: " << densities << endl;
        cout << "Path to CSV " << path << " number of threads" << endl;
        cout << "Execution with " << omp_get_max_threads() << " number of threads" << endl;
        cout << "Max size of vector is " << v.max_size() << endl;
    }*/

    std::ofstream file(path, std::ios::app);
    if (wrank == 0) {
        file << "Side,Substrates,BioFVM,BioFVM-B,Reduction" << std::endl;
    } 

    for(int side = 500; side <= 20000; side+=500){
        for(int substrates = 1; substrates <=32; ++substrates){
            long long voxels = 0;
            voxels = side/delta;
            voxels = voxels*voxels*voxels;
            long double og = test_BioFVM(voxels, substrates);
    
            long double opt = test_BioFVM_B(voxels, substrates);

            file << side << "," << substrates << "," << og << "," << opt << "," << opt/og << endl;
        }
    }
    
    MPI_Finalize();
    return 0;
}
