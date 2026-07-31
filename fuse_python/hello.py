from fuse import FUSE, Operations
import os
import sys

HELLO_CONTENT = b"[hello.py] read()\n"

class HelloFS(Operations):
    def getattr(self, path, fh=None):
        if path == '/':
            return dict(st_mode=(0o755 | 0o040000), st_nlink=2)
        elif path == '/hello':
            return dict(st_mode=(0o444 | 0o100000), st_nlink=1, st_size=len(HELLO_CONTENT))
        else:
            raise FileNotFoundError

    def readdir(self, path, fh):
        return ['.', '..', 'hello']

    def open(self, path, flags):
        if path != '/hello':
            raise FileNotFoundError
        return 0  # must return an integer file handle

    def read(self, path, size, offset, fh):
        if path == '/hello':
            return HELLO_CONTENT[offset:offset + size]
        raise FileNotFoundError

if __name__ == '__main__':
    mountpoint = sys.argv[1] if len(sys.argv) > 1 else '/mnt/fuse'
    FUSE(HelloFS(), mountpoint, foreground=True, allow_other=True)
