from .types cimport StaticArray, StringView


cdef extern from 'core.hpp':
    cdef cppclass shaOutputSize '64 + 1':
        pass

    cdef struct ICore:
        void printLn(const char* fmt, ...)
        unsigned getTickCount()
        unsigned tickRate()
        bint sha256(StringView password, StringView salt, StaticArray[char, shaOutputSize]& output)
