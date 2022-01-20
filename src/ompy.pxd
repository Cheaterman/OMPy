cdef extern from 'sdk.hpp':
    cdef struct ICore:
        void printLn(const char* fmt, ...)
