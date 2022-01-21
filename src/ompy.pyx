cdef ICore* _core = NULL

cdef class Core:
    cdef ICore* core

    def __cinit__(self):
        if _core is NULL:
            raise RuntimeError(
                'Cannot instantiate Core: OMPy is not initialized.'
            )

        self.core = _core

    def print_ln(self, text):
        cdef text_bytes = text.encode('utf8')
        cdef char* _text = text_bytes
        self.core.printLn('%s', _text)

    def get_tick_count(self):
        return self.core.getTickCount()

    def tick_rate(self):
        return self.core.tickRate()

    def sha256(self, value, salt):
        cdef StaticArray[char, shaOutputSize] result
        self.core.sha256(value.encode('utf8'), salt.encode('utf8'), result)
        return result.data().decode('utf8')


cdef public void OMPy_setCore(ICore* core):
    global _core
    _core = core
