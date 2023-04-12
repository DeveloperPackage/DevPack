cmake_minimum_required(VERSION 3.5)

project(main LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(DEVPACK $ENV{DEVPACK})

set(BOOST_ROOT "${DEVPACK}/boost")
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME ON)
find_package(Boost REQUIRED COMPONENTS atomic chrono container context contract coroutine date_time exception fiber filesystem graph headers iostreams json locale log log_setup math_c99 math_c99f math_c99l math_tr1 math_tr1f math_tr1l nowide program_options python random regex serialization stacktrace_noop stacktrace_windbg stacktrace_windbg_cached system thread timer type_erasure url wave wserialization)
include_directories(${Boost_INCLUDE_DIRS})
link_libraries(${Boost_LIBRARIES})

include_directories("${DEVPACK}/wxWidgets/include")
include_directories("${DEVPACK}/wxWidgets/lib/gcc_lib/mswu")
link_directories("${DEVPACK}/wxWidgets/lib/gcc_lib")
link_libraries(wxexpat wxmsw32u wxpng wxscintilla wxzlib wxjpeg wxmsw32u_gl wxregexu wxtiff ole32 uuid shlwapi comctl32 uxtheme oleacc version comdlg32 winspool oleaut32 gdi32 shell32 rpcrt4 user32 advapi32)

add_link_options("-static")

add_executable(main main.cpp)
