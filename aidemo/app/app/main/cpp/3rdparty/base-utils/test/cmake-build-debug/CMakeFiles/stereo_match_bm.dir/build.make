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
include CMakeFiles/stereo_match_bm.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/stereo_match_bm.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/stereo_match_bm.dir/flags.make

CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o: CMakeFiles/stereo_match_bm.dir/flags.make
CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o: ../opencv/stereo_match_bm.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o -c /media/dm/新加卷/SDK/base-utils/test/opencv/stereo_match_bm.cpp

CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /media/dm/新加卷/SDK/base-utils/test/opencv/stereo_match_bm.cpp > CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.i

CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /media/dm/新加卷/SDK/base-utils/test/opencv/stereo_match_bm.cpp -o CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.s

# Object files for target stereo_match_bm
stereo_match_bm_OBJECTS = \
"CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o"

# External object files for target stereo_match_bm
stereo_match_bm_EXTERNAL_OBJECTS =

stereo_match_bm: CMakeFiles/stereo_match_bm.dir/opencv/stereo_match_bm.cpp.o
stereo_match_bm: CMakeFiles/stereo_match_bm.dir/build.make
stereo_match_bm: base_build/libbase_utils.a
stereo_match_bm: /usr/local/lib/libopencv_dnn.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_gapi.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_highgui.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_ml.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_objdetect.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_photo.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_stitching.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_video.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_videoio.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_imgcodecs.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_calib3d.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_features2d.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_flann.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_imgproc.so.4.3.0
stereo_match_bm: /usr/local/lib/libopencv_core.so.4.3.0
stereo_match_bm: CMakeFiles/stereo_match_bm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable stereo_match_bm"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/stereo_match_bm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/stereo_match_bm.dir/build: stereo_match_bm

.PHONY : CMakeFiles/stereo_match_bm.dir/build

CMakeFiles/stereo_match_bm.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/stereo_match_bm.dir/cmake_clean.cmake
.PHONY : CMakeFiles/stereo_match_bm.dir/clean

CMakeFiles/stereo_match_bm.dir/depend:
	cd /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/dm/新加卷/SDK/base-utils/test /media/dm/新加卷/SDK/base-utils/test /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug /media/dm/新加卷/SDK/base-utils/test/cmake-build-debug/CMakeFiles/stereo_match_bm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/stereo_match_bm.dir/depend

