# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/dm/app/clion-2020.1.2/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/dm/app/clion-2020.1.2/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /media/dm/新加卷/SDK/base-utils/test

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/openmp_test.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/openmp_test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/openmp_test.dir/flags.make

CMakeFiles/openmp_test.dir/openmp_test.cpp.o: CMakeFiles/openmp_test.dir/flags.make
CMakeFiles/openmp_test.dir/openmp_test.cpp.o: ../openmp_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/openmp_test.dir/openmp_test.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/openmp_test.dir/openmp_test.cpp.o -c /media/dm/新加卷/SDK/base-utils/test/openmp_test.cpp

CMakeFiles/openmp_test.dir/openmp_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/openmp_test.dir/openmp_test.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /media/dm/新加卷/SDK/base-utils/test/openmp_test.cpp > CMakeFiles/openmp_test.dir/openmp_test.cpp.i

CMakeFiles/openmp_test.dir/openmp_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/openmp_test.dir/openmp_test.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /media/dm/新加卷/SDK/base-utils/test/openmp_test.cpp -o CMakeFiles/openmp_test.dir/openmp_test.cpp.s

# Object files for target openmp_test
openmp_test_OBJECTS = \
"CMakeFiles/openmp_test.dir/openmp_test.cpp.o"

# External object files for target openmp_test
openmp_test_EXTERNAL_OBJECTS =

openmp_test: CMakeFiles/openmp_test.dir/openmp_test.cpp.o
openmp_test: CMakeFiles/openmp_test.dir/build.make
openmp_test: base_build/libbase_utils.a
openmp_test: /usr/local/lib/libopencv_dnn.so.4.3.0
openmp_test: /usr/local/lib/libopencv_gapi.so.4.3.0
openmp_test: /usr/local/lib/libopencv_highgui.so.4.3.0
openmp_test: /usr/local/lib/libopencv_ml.so.4.3.0
openmp_test: /usr/local/lib/libopencv_objdetect.so.4.3.0
openmp_test: /usr/local/lib/libopencv_photo.so.4.3.0
openmp_test: /usr/local/lib/libopencv_stitching.so.4.3.0
openmp_test: /usr/local/lib/libopencv_video.so.4.3.0
openmp_test: /usr/local/lib/libopencv_videoio.so.4.3.0
openmp_test: /usr/local/lib/libopencv_imgcodecs.so.4.3.0
openmp_test: /usr/local/lib/libopencv_calib3d.so.4.3.0
openmp_test: /usr/local/lib/libopencv_features2d.so.4.3.0
openmp_test: /usr/local/lib/libopencv_flann.so.4.3.0
openmp_test: /usr/local/lib/libopencv_imgproc.so.4.3.0
openmp_test: /usr/local/lib/libopencv_core.so.4.3.0
openmp_test: CMakeFiles/openmp_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable openmp_test"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/openmp_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/openmp_test.dir/build: openmp_test

.PHONY : CMakeFiles/openmp_test.dir/build

CMakeFiles/openmp_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/openmp_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/openmp_test.dir/clean

CMakeFiles/openmp_test.dir/depend:
	cd /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/dm/新加卷/SDK/base-utils/test /media/dm/新加卷/SDK/base-utils/test /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles/openmp_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/openmp_test.dir/depend

