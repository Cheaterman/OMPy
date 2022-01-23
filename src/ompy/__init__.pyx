import sys
from importlib.abc import MetaPathFinder
from importlib.machinery import BuiltinImporter
from importlib.util import spec_from_loader


__path__ = 'ompy'


class OMPyFinder(MetaPathFinder):
    valid_modules = set(
        name for name in sys.builtin_module_names
        if name.startswith('ompy')
    )

    def find_spec(self, fullname, path, target=None):
        if fullname not in self.valid_modules:
            return

        return spec_from_loader(fullname, BuiltinImporter())


sys.meta_path.insert(0, OMPyFinder())
