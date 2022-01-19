#include <sdk.hpp>


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
    }

    void onReady() override {
    }

    void free() override {
        delete this;
    }

    ICore* core = nullptr;
};


COMPONENT_ENTRY_POINT() {
    return new PyOMPComponent();
}
