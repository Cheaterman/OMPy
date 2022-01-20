cdef Core _core_instance = None

cdef class Core:
    cdef ICore* core

    @staticmethod
    cdef void set_core(ICore* core):
        global _core_instance

        if not core:
            _core_instance = None
            return

        cdef Core new_core = Core.__new__(Core)
        new_core.core = core
        _core_instance = new_core

    @classmethod
    def get(cls):
        if _core_instance is None:
            raise RuntimeError('Cannot get Core: OMPy is not initialized.')

        return _core_instance

    def print_ln(self, text):
        cdef text_bytes = text.encode('utf8')
        cdef char* _text = text_bytes
        self.core.printLn('%s', _text)


cdef public void OMPy_setCore(ICore* core):
    Core.set_core(core)
