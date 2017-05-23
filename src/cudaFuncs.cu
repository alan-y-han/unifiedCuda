#include <cstdio>
#include <iostream>
#include <cstring>
#include <utility>
#include "cudaUtils.h"

#include <eigen3/Eigen/Dense>
#include <eigen3/Eigen/src/Core/Matrix.h>
#include <cublas_v2.h>

#ifdef __JETBRAINS_IDE__
#define threadIdx();
#define blockIdx();
#define blockDim();
#endif

#if (defined __GNUC__) && (__GNUC__>4 || __GNUC_MINOR__>=7)
#undef _GLIBCXX_ATOMIC_BUILTINS
#undef _GLIBCXX_USE_INT128
#endif

//class Managed
//{
//public:
//    void* operator new(size_t len)
//    {
//        void* ptr;
//        cudaMallocManaged(&ptr, len);
//        cudaDeviceSynchronize();
//        return ptr;
//    }
//
//    void operator delete(void* ptr)
//    {
//        cudaDeviceSynchronize();
//        cudaFree(ptr);
//    }
//};
//
//class String : public Managed
//{
//    int length;
//    char *data;
//
//public:
//    String (const String& s)
//    {
//        length = s.length;
//        cudaMallocManaged(&data, length);
//        memcpy(data, s.data, length);
//    }
//};
//
//class dataElem : public Managed
//{
//public:
//    int prop1;
//    int prop2;
//    String name;
//};

//__global__ void cube(float * d_out, float * d_in){
//    int id = threadIdx.x;
//    float value = d_in[id];
//    d_out[id] = value * value * value;
//}

//void printCubes()
//{
//    std::cout << "Hello, World!" << std::endl;
//    const int ARRAY_SIZE = 96;
//    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);
//
//    // generate the input array on the host
//    float* h_in;
//    checkCudaErrors(cudaMallocManaged(&h_in, ARRAY_BYTES));
//    for (int i = 0; i < ARRAY_SIZE; i++) {
//        h_in[i] = i;
//    }
//    float* h_out;
//    checkCudaErrors(cudaMallocManaged(&h_out, ARRAY_BYTES));
//
//    // launch the kernel
//    cube<<<1, ARRAY_SIZE>>>(h_out, h_in);
//    checkCudaErrors(cudaGetLastError());
//    checkCudaErrors(cudaDeviceSynchronize());
//
//    // print out the resulting array
//    for (int i = 0; i < ARRAY_SIZE; i++) {
//        printf("%f", h_out[i]);
//        printf(((i % 4) != 3) ? "\t" : "\n");
//    }
//
//    checkCudaErrors(cudaFree(h_in));
//    checkCudaErrors(cudaFree(h_out));
//}

//__global__ void cudaDoEigen(Eigen::MatrixXd* m, int rows, int columns)
//{
//    printf("CUDA value: %lf\n", (*m)(0,0));
//}

__global__ void cudaDoEigen(double* m, int rows, int columns)
{
//    Eigen::Matrix stuff = m;
//    printf("CUDA testing\n");
    printf("CUDA ptr: %p\n", m);
    printf("CUDA value: %lf\n", m[0]);
    printf("CUDA value: %lf\n", m[1]);
    printf("CUDA value: %lf\n", m[2]);
    printf("CUDA value: %lf\n", m[3]);

}

void doEigenStuff()
{
    double* m_pointer;
    checkCudaErrors(cudaMallocManaged(&m_pointer, sizeof(double) * 4));

//    m_pointer[0] = 1;

//    for (int i = 0; i < 4; i++)
//    {
//
//    }
//
    for (int j = 0; j < 4; j++)
    {
        m_pointer[j] = static_cast<double>(j);
    }
//    new (m_pointer) Eigen::MatrixXd(2,2);

    Eigen::MatrixXd m = Eigen::Map<Eigen::MatrixXd>(m_pointer, 2, 2);

//    Eigen::MatrixXd& m = *((Eigen::MatrixXd*)m_pointer);
    m(0,0) = 3;
    m(1,0) = 2.5;
    m(0,1) = -1;
    m(1,1) = m(1,0) + m(0,1);
//
    std::cout << m << std::endl;
//
    for (int i = 0; i < 4; i++)
    {
        std::cout << "CPU value: " << m_pointer[i] << std::endl;
    }



//    cudaDoEigen<<<1, 1>>>(m_pointer, 2, 2);
//    cudaDeviceSynchronize();

//    checkCudaErrors(cudaGetLastError());
}
