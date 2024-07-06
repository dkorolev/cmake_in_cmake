cmake_minimum_required(VERSION 3.11)

execute_process(COMMAND ${CMAKE_SOURCE_DIR}/cmake/update_cmakelists_txt.sh RESULT_VARIABLE update_result)
if(NOT update_result EQUAL 0)
  message(FATAL_ERROR "Could not update `cmake/CMakeLists.txt`, terminating.")
endif()

set(C5T_PROJECT_ROOT ${CMAKE_SOURCE_DIR})
add_subdirectory(cmake)

project(cmake_in_cmake)
