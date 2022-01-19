#include <Python.h>
#include <sdk.hpp>

#include "python_vars.h"


struct PyOMPComponent final : IComponent {
    PROVIDE_UniqueID(0x33342353125330CC);

    StringView componentName() const override {
        return "PyOMP";
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
        Py_Initialize();

        PyObject* osModule = PyImport_ImportModule("os");
        PyObject* cwdStr = PyObject_CallMethod(osModule, "getcwd", NULL);
        Py_DECREF(osModule);

        PyObject* sysPath = PySys_GetObject("path");
        PyList_Append(sysPath, cwdStr);
        Py_DECREF(cwdStr);
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
    return new PyOMPComponent();
}
