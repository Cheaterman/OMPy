from libcpp.string cimport string


cdef extern from '<array>' namespace 'std':
    cdef cppclass array[T, N]:
        T& operator[](size_t)
        T* data()


cdef extern from 'types.hpp':
    ctypedef array StaticArray
    ctypedef string StringView


cdef extern from 'sdk.hpp':
    cdef cppclass shaOutputSize '64 + 1':
        pass

    cdef struct ICore:
        void printLn(const char* fmt, ...)
        unsigned getTickCount()
        unsigned tickRate()
        bint sha256(StringView password, StringView salt, StaticArray[char, shaOutputSize]& output)
