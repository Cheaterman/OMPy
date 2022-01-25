from libcpp.pair cimport pair
from libcpp.string cimport string


cdef extern from '<array>' namespace 'std':
    cdef cppclass array[T, N]:
        T& operator[](size_t)
        T* data()


cdef extern from '<span>' namespace 'std':
    cdef cppclass span[T]:
        T& operator[](size_t)
        T* data()


cdef extern from 'types.hpp':
    ctypedef array StaticArray
    ctypedef pair Pair
    ctypedef span Span
    ctypedef string StringView
    ctypedef char uint8_t
    ctypedef short uint16_t

    cdef cppclass SemanticVersion:
        SemanticVersion(const SemanticVersion&)
        uint8_t major
        uint8_t minor
        uint8_t patch
        uint16_t prerel
