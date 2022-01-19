#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <sdk.hpp>

#include "python_vars.h"


struct OMPyComponent final : IComponent {
    PROVIDE_UniqueID(0x33342353125330CC);

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

        Py_InitializeEx(false);
        PySys_SetArgv(1, &programName);
    }

    void onReady() override {
        if(PyImport_ImportModule("python") == nullptr)
            PyErr_Print();
    }

    void free() override {
        Py_FinalizeEx();
        delete this;
    }

    ICore* core = nullptr;
};


COMPONENT_ENTRY_POINT() {
    return new OMPyComponent();
}
