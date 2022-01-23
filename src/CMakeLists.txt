list(APPEND CMAKE_MODULE_PATH
    ${PROJECT_SOURCE_DIR}/lib/scikit-build/skbuild/resources/cmake
)

find_package(
    Python3
    COMPONENTS Development
    REQUIRED
)
find_package(Cython REQUIRED)

add_library(${PROJECT_NAME} SHARED
    main.cpp
)
add_subdirectory(ompy)
set_target_properties(${PROJECT_NAME} PROPERTIES
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY ".."
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${Python3_INCLUDE_DIRS}
    ${CMAKE_BINARY_DIR}/src
    ${CMAKE_BINARY_DIR}/generated
)
target_link_libraries(${PROJECT_NAME} PRIVATE
    SDK
    ompy_module
    ${Python3_LIBRARIES}
)

if(WIN32)
    get_filename_component(PYTHON_HOME "${Python3_INCLUDE_DIRS}/.." REALPATH)
else()
    get_filename_component(PYTHON_HOME "${Python3_INCLUDE_DIRS}/../.." REALPATH)
endif()

configure_file(python_vars.h.in ${CMAKE_BINARY_DIR}/generated/python_vars.h)
