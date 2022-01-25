cdef ICore* _core = NULL


cdef public void OMPy_setCore(ICore* core):
    global _core
    _core = core


cdef class Config:
    cdef IConfig* config

    @staticmethod
    cdef Config from_config(IConfig* config):
        cdef Config self = Config.__new__(Config)
        self.config = config
        return self

    def get_string(self, key):
        cdef StringView value = self.config.getString(key.encode('utf8'))
        return bytes(value).decode('utf8')

    def get_int(self, key):
        return self.config.getInt(key.encode('utf8'))[0]

    def get_float(self, key):
        return self.config.getFloat(key.encode('utf8'))[0]


cdef class Core:
    cdef ICore* core

    def __cinit__(self):
        if _core is NULL:
            raise RuntimeError(
                'Cannot instantiate Core: OMPy is not initialized.'
            )

        self.core = _core

    def get_version(self):
        cdef SemanticVersion* version
        try:
            version = new SemanticVersion(self.core.getVersion())
            return (
                version.major,
                version.minor,
                version.patch,
                version.prerel,
            )
        finally:
            del version

    def get_config(self):
        cdef IConfig* core_config = &self.core.getConfig()
        return Config.from_config(core_config)

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
