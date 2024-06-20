cmake_minimum_required(VERSION 3.22.1)

project("TNN")

set(OpenCV_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/opencv/sdk/native/jni)
find_package(OpenCV REQUIRED)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/opencv/sdk/native/jni/include)


set(BASE_ROOT 3rdparty/base-utils) # 设置base-utils所在的根目录
add_subdirectory(${BASE_ROOT}/base_utils/ base_build) # 添加子目录到build中
include_directories(${BASE_ROOT}/base_utils/include)
include_directories(${BASE_ROOT}/base_utils/src)

set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
set(TNN_ARM_ENABLE ON CACHE BOOL "" FORCE)
set(TNN_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
#set(TNN_HUAWEI_NPU_ENABLE OFF CACHE BOOL "" FORCE)
add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
add_definitions(-DTNN_ARM_ENABLE)              # for Android CPU
add_definitions(-DDEBUG_ANDROID_ON)            # for Android Log
add_definitions(-DPLATFORM_ANDROID)


set(TNN_ROOT 3rdparty/TNN)
include_directories(${TNN_ROOT}/include)
include_directories(${TNN_ROOT}/third_party/opencl/include)
add_subdirectory(${TNN_ROOT}) # 添加外部项目文件夹
set(TNN -Wl,--whole-archive TNN -Wl,--no-whole-archive)# set TNN library

find_library( # Sets the name of the path variable.
        log-lib
        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

# dmcv库
include_directories(src)
set(SRC_LIST
        src/object_detection.cpp
        src/Interpreter.cpp)

# JNI接口库
add_library(tnn_wrapper SHARED jni_interface.cpp ${SRC_LIST})
target_link_libraries( # Specifies the target library.
        tnn_wrapper
        -ljnigraphics
        # Links the target library to the log library
        # included in the NDK.
        ${log-lib}
        ${android-lib}
        ${jnigraphics-lib}
        ${TNN}
        ${OpenCV_LIBS}
        base_utils
        )