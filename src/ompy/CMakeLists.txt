file(GLOB_RECURSE pyx_files "${CMAKE_CURRENT_SOURCE_DIR}/*.pyx")
foreach(pyx_file ${pyx_files})
    add_cython_target(${pyx_file} CXX OUTPUT_VAR generated_cxx_file)
    list(APPEND ompy_module ${generated_cxx_file})
endforeach()

add_library(ompy_module STATIC ${ompy_module})
set_target_properties(ompy_module PROPERTIES
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY ".."
    POSITION_INDEPENDENT_CODE ON
)
target_include_directories(ompy_module PRIVATE
    ${Python3_INCLUDE_DIRS}
)
target_link_libraries(ompy_module PRIVATE
    SDK
)
