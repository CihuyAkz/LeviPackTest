cmake_minimum_required(VERSION 3.22)
project(LeviBloomNoShader LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT DEFINED MOD_ID)
  set(MOD_ID levi_bloom_noshader)
endif()
if(NOT DEFINED MOD_NAME)
  set(MOD_NAME "LeviBloom NoShader")
endif()
if(NOT DEFINED MOD_AUTHOR)
  set(MOD_AUTHOR "OpenAI")
endif()
if(NOT DEFINED MOD_VERSION)
  set(MOD_VERSION 0.1.0)
endif()
if(NOT DEFINED MOD_LIBRARY_NAME)
  set(MOD_LIBRARY_NAME levi_bloom_noshader)
endif()
if(NOT DEFINED MOD_MINECRAFT_VERSIONS)
  set(MOD_MINECRAFT_VERSIONS "[\"1.21.*\"]")
endif()

include(FetchContent)
FetchContent_Declare(
  preloader_android
  GIT_REPOSITORY https://github.com/LiteLDev/preloader-android.git
  GIT_TAG 0.2.2)
FetchContent_MakeAvailable(preloader_android)

add_library(${MOD_LIBRARY_NAME} SHARED
  src/main.cpp
  src/mod/LeviBloom.cpp
)

target_include_directories(${MOD_LIBRARY_NAME} PRIVATE src)
target_link_libraries(${MOD_LIBRARY_NAME} PRIVATE preloader)

target_compile_definitions(${MOD_LIBRARY_NAME} PRIVATE
  LEVIBLOOM_VERSION="${MOD_VERSION}"
)

configure_file(manifest.json.in manifest.json @ONLY)

add_custom_target(levi_package ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/dist/${MOD_LIBRARY_NAME}
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MOD_LIBRARY_NAME}> ${CMAKE_BINARY_DIR}/dist/${MOD_LIBRARY_NAME}/$<TARGET_FILE_NAME:${MOD_LIBRARY_NAME}>
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/manifest.json ${CMAKE_BINARY_DIR}/dist/${MOD_LIBRARY_NAME}/manifest.json
  DEPENDS ${MOD_LIBRARY_NAME}
)
