#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <sdk.hpp>

#include "python_vars.h"
#include "ompy/core.h"

extern "C" {
    PyMODINIT_FUNC PyInit_ompy(void);
    PyMODINIT_FUNC PyInit_core(void);
}

struct OMPyComponent final : IComponent {
    PROVIDE_UID(0x33342353125330CC);

    StringView componentName() const override {
        return "OMPy";
    }

    SemanticVersion componentVersion() const override {
        return SemanticVersion(0, 0, 1, 0);
    }

    void onLoad(ICore* _core) override {
        core = _core;
    }

    void onInit(IComponentList* components) override {
#ifndef WIN32
        dlopen(PYTHON_LIBRARY, RTLD_GLOBAL | RTLD_LAZY);
#endif
        Py_SetPythonHome(PYTHON_HOME);
        wchar_t *programName = (wchar_t *)L"OMPy";
        Py_SetProgramName(programName);

        PyImport_AppendInittab("ompy", PyInit_ompy);
        PyImport_AppendInittab("ompy.core", PyInit_core);

        Py_InitializeEx(false);
        PySys_SetArgv(1, &programName);

        PyImport_ImportModule("ompy.core");
        OMPy_setCore(core);

        Py_UNBLOCK_THREADS
    }

    void onReady() override {
        Py_BLOCK_THREADS

        if(PyImport_ImportModule("python") == nullptr)
            PyErr_Print();

        Py_UNBLOCK_THREADS
    }

    void free() override {
        Py_BLOCK_THREADS
        OMPy_setCore(nullptr);
        Py_FinalizeEx();
        delete this;
    }

    ICore* core = nullptr;
    PyThreadState *_save;
};


COMPONENT_ENTRY_POINT() {
    return new OMPyComponent();
}
