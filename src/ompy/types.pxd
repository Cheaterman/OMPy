from libcpp.string cimport string


cdef extern from '<array>' namespace 'std':
    cdef cppclass array[T, N]:
        T& operator[](size_t)
        T* data()


cdef extern from 'types.hpp':
    ctypedef array StaticArray
    ctypedef string StringView


