# OMPy

Python support for open.mp.

## Tools

* [CMake 3.19+](https://cmake.org/)
* [Conan 1.33+](https://conan.io/)

## Tools on Windows

* [Visual Studio 2019+](https://www.visualstudio.com/)

Visual Studio needs the `Desktop development with C++` workload with the `MSVC v142`, `Windows 10 SDK` and `C++ Clang tools for Windows` components.

## Sources

```bash
# With HTTPS:
git clone --recursive https://github.com/Cheaterman/OMPy.git
# With SSH:
git clone --recursive git@github.com:Cheaterman/OMPy.git
```

Note the use of the `--recursive` argument, because this repository contains submodules.

## Building on Windows

```bash
mkdir build
cd build
cmake .. -A Win32 -T ClangCL
```

Open Visual Studio and build the solution.

## Building on Linux

```bash
./build.sh
```
