cmake_minimum_required(VERSION 3.19)
project(OMPy LANGUAGES C CXX VERSION 0.0.1)

add_subdirectory(open.mp-sdk)

add_library(${PROJECT_NAME} SHARED
    main.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

find_package(
    Python3
    COMPONENTS Development
    REQUIRED
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${Python3_INCLUDE_DIRS}
    ${CMAKE_BINARY_DIR}/generated
)
target_link_libraries(${PROJECT_NAME} PRIVATE
    SDK
    ${Python3_LIBRARIES}
)

if(WIN32)
    get_filename_component(PYTHON_HOME "${Python3_INCLUDE_DIRS}/.." REALPATH)
else()
    get_filename_component(PYTHON_HOME "${Python3_INCLUDE_DIRS}/../.." REALPATH)
endif()

configure_file(python_vars.h.in ${CMAKE_BINARY_DIR}/generated/python_vars.h)
