cmake_minimum_required(VERSION 3.22.1)
project("TNN")
add_compile_options(-fPIC) # fix Bug: can not be used when making a shared object
#set(CMAKE_BUILD_TYPE Release)
#set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type (default Debug)" FORCE)
#set(CMAKE_CXX_FLAGS "-Wall -std=c++11 -pthread")
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "set build type to release" FORCE)

# opencv set
# copy `OpenCV-android-sdk/sdk` to `3rdparty/opencv/`
set(OpenCV_DIR ${CMAKE_SOURCE_DIR}/3rdparty/opencv/sdk/native/jni)
find_package(OpenCV REQUIRED)
include_directories(${CMAKE_SOURCE_DIR}/3rdparty/opencv/sdk/native/jni/include)


# base_utils
set(BASE_ROOT 3rdparty/base-utils) # 设置base-utils所在的根目录
add_subdirectory(${BASE_ROOT}/base_utils/ base_build) # 添加子目录到build中
include_directories(${BASE_ROOT}/base_utils/include)
include_directories(${BASE_ROOT}/base_utils/src)
MESSAGE(STATUS "BASE_ROOT = ${BASE_ROOT}")



# TNN set
# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds it for you.
# Gradle automatically packages shared libraries with your APK.
# build for platform
# set(TNN_BUILD_SHARED OFF CACHE BOOL "" FORCE)
if (CMAKE_SYSTEM_NAME MATCHES "Android")
    set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_ARM_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_BUILD_SHARED OFF CACHE BOOL "" FORCE)
    set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
    #set(TNN_HUAWEI_NPU_ENABLE OFF CACHE BOOL "" FORCE)
    add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
    add_definitions(-DTNN_ARM_ENABLE)              # for Android CPU
    add_definitions(-DDEBUG_ANDROID_ON)            # for Android Log
    add_definitions(-DPLATFORM_ANDROID)
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_CPU_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_X86_ENABLE OFF CACHE BOOL "" FORCE)
    set(TNN_QUANTIZATION_ENABLE OFF CACHE BOOL "" FORCE)
    set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
    add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
    add_definitions(-DDEBUG_ON)                    # for WIN/Linux Log
    add_definitions(-DDEBUG_LOG_ON)                # for WIN/Linux Log
    add_definitions(-DDEBUG_IMSHOW_OFF)            # for OpenCV show
    add_definitions(-DPLATFORM_LINUX)
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
    set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_CPU_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_X86_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_QUANTIZATION_ENABLE OFF CACHE BOOL "" FORCE)
    set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
    add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
    add_definitions(-DDEBUG_ON)                    # for WIN/Linux Log
    add_definitions(-DDEBUG_LOG_ON)                # for WIN/Linux Log
    add_definitions(-DDEBUG_IMSHOW_OFF)            # for OpenCV show
    add_definitions(-DPLATFORM_WINDOWS)
endif ()
set(TNN_ROOT 3rdparty/TNN)
include_directories(${TNN_ROOT}/include)
include_directories(${TNN_ROOT}/third_party/opencl/include)
add_subdirectory(${TNN_ROOT}) # 添加外部项目文件夹
set(TNN -Wl,--whole-archive TNN -Wl,--no-whole-archive)# set TNN library
MESSAGE(STATUS "TNN_ROOT = ${TNN_ROOT}")

# NPU Set
if (TNN_HUAWEI_NPU_ENABLE)
    add_library(hiai
            SHARED
            IMPORTED)
    set_target_properties(hiai
            PROPERTIES
            IMPORTED_LOCATION
            ${CMAKE_SOURCE_DIR}/src/main/jni/thirdparty/hiai_ddk/${ANDROID_ABI}/libhiai.so)

    add_library(hiai_ir
            SHARED
            IMPORTED)
    set_target_properties(hiai_ir
            PROPERTIES
            IMPORTED_LOCATION
            ${CMAKE_SOURCE_DIR}/src/main/jni/thirdparty/hiai_ddk/${ANDROID_ABI}/libhiai_ir.so)

    add_library(hiai_ir_build
            SHARED
            IMPORTED)
    set_target_properties(hiai_ir_build
            PROPERTIES
            IMPORTED_LOCATION
            ${CMAKE_SOURCE_DIR}/src/main/jni/thirdparty/hiai_ddk/${ANDROID_ABI}/libhiai_ir_build.so)

endif ()


find_library( # Sets the name of the path variable.
        log-lib
        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in the
# build script, prebuilt third-party libraries, or system libraries.

# dmcv库
include_directories(src)
set(SRC_LIST
        src/object_detection.cpp
        src/Interpreter.cpp)
MESSAGE(STATUS "DIR_SRCS = ${SRC_LIST}")

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

if (TNN_HUAWEI_NPU_ENABLE)
    target_link_libraries( # Specifies the target library.
            tnn_wrapper hiai hiai_ir hiai_ir_build)
endif ()