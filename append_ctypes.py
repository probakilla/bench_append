from attr import attrs, attrib
import ctypes as ct
import sys


def load_library(path):
    lib = ct.cdll.LoadLibrary(path)
    lib.append.argtypes = [ct.c_char_p, ct.c_char]
    lib.append.restype = ct.c_char_p
    return lib


@attrs
class Main:
    _loop_count = attrib()
    _lib = attrib(default=load_library("lib/append.so"))

    def run(self):
        string = "".encode("utf-8")
        char = "a".encode("utf-8")
        for _ in range(self._loop_count):
            string = self._lib.append(string, char)
        print(string)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("\033[31mERROR\033[0m Need a loop count")
        sys.exit(1)
    loop_count = int(sys.argv[1])
    Main(loop_count).run()
