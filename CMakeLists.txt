cmake_minimum_required(VERSION 3.7)
project(unifiedCuda)
set(CMAKE_CXX_STANDARD 11)

find_package(CUDA REQUIRED)

set(CUDA_NVCC_FLAGS "
#        -gencode;arch=compute_30,code=sm_30;
#        -gencode;arch=compute_35,code=sm_35;
#        -gencode;arch=compute_35,code=compute_35;
#        -gencode;arch=compute_20,code=sm_20;
#        -gencode;arch=compute_11,code=sm_11;
#        -gencode;arch=compute_12,code=sm_12;
#        -gencode;arch=compute_13,code=sm_13;
")

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} "-Xcompiler -Wextra -G")

include_directories(${EIGEN_INCLUDE_DIRS})

# Find all source files
file(GLOB_RECURSE SRC "src/*.cpp")
file(GLOB_RECURSE CUDASRC "src/*.cu")
file(GLOB_RECURSE HDR "include/*.h")
list(APPEND SRC ${HDR})
list(APPEND SRC ${CUDASRC})

cuda_add_executable(${PROJECT_NAME} ${SRC})

target_include_directories(${PROJECT_NAME} PUBLIC "include")