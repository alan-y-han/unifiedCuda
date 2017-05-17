#include <cstdio>
#include <iostream>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>
#include "cudaUtils.h"

__global__ void cube(float * d_out, float * d_in){
    int id = threadIdx.x;
    float value = d_in[id];
    d_out[id] = value * value * value;
}

void printCubes()
{
    std::cout << "Hello, World!" << std::endl;
    const int ARRAY_SIZE = 96;
    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    // generate the input array on the host
    float* h_in;
    checkCudaErrors(cudaMallocManaged(&h_in, ARRAY_BYTES));
    for (int i = 0; i < ARRAY_SIZE; i++) {
        h_in[i] = i;
    }
    float* h_out;
    checkCudaErrors(cudaMallocManaged(&h_out, ARRAY_BYTES));

    // launch the kernel
    cube<<<1, ARRAY_SIZE>>>(h_out, h_in);
    checkCudaErrors(cudaGetLastError());
    checkCudaErrors(cudaDeviceSynchronize());

    // print out the resulting array
    for (int i =0; i < ARRAY_SIZE; i++) {
        printf("%f", h_out[i]);
        printf(((i % 4) != 3) ? "\t" : "\n");
    }

    checkCudaErrors(cudaFree(h_in));
    checkCudaErrors(cudaFree(h_out));
}