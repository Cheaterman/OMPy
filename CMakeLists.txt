cmake_minimum_required(VERSION 3.19)
project(PyOMP LANGUAGES C CXX VERSION 0.0.1)

add_subdirectory(open.mp-sdk)

add_library(${PROJECT_NAME} SHARED
    main.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")

target_link_libraries(${PROJECT_NAME} PRIVATE
    SDK
)
