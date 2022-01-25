from .network cimport BanEntry
from .types cimport Pair, SemanticVersion, Span, StaticArray, StringView


cdef extern from 'core.hpp':
    cdef cppclass shaOutputSize '64 + 1':
        pass

    cdef struct IConfig:
        const StringView getString(StringView key)
        int* getInt(StringView key)
        float* getFloat(StringView key)
        size_t getStrings(StringView key, Span[StringView] output)
        size_t getStringsCount(StringView key)
        size_t getBansCount()
        const BanEntry& getBan(size_t index)
        void addBan(const BanEntry& entry)
        void removeBan(size_t index)
        void writeBans()
        Pair[bint, StringView] getNameFromAlias(StringView alias)

    cdef struct ICore:
        SemanticVersion getVersion()
        IConfig& getConfig()
        void printLn(const char* fmt, ...)
        unsigned getTickCount()
        unsigned tickRate()
        bint sha256(StringView password, StringView salt, StaticArray[char, shaOutputSize]& output)
