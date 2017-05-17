cmake_minimum_required(VERSION 3.7)
project(unifiedCuda)
set(CMAKE_CXX_STANDARD 11)

find_package(CUDA REQUIRED)

include_directories(${EIGEN_INCLUDE_DIRS})

# Find all source files
file(GLOB_RECURSE SRC "src/*.cpp")
file(GLOB_RECURSE CUDASRC "src/*.cu")
file(GLOB_RECURSE HDR "include/*.h")
list(APPEND SRC ${HDR})
list(APPEND SRC ${CUDASRC})

cuda_add_executable(${PROJECT_NAME} ${SRC})

target_include_directories(${PROJECT_NAME} PUBLIC "include")