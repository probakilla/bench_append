import sys


def append():
    if len(sys.argv) != 2:
        print("\033[31mERROR\033[0m Need loop count")
        sys.exit(1)
    loop_count = int(sys.argv[1])
    string = ""
    for _ in range(loop_count):
        string += "a"


if __name__ == "__main__":
    append()
