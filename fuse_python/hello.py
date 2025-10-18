from fuse import FUSE, Operations
import os

class HelloFS(Operations):
    def getattr(self, path, fh=None):
        if path == '/':
            return dict(st_mode=(0o755 | 0o040000), st_nlink=2)
        elif path == '/hello':
            return dict(st_mode=(0o444 | 0o100000), st_nlink=1, st_size=len("Hello world 1\n"))
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
            data = b"Hello world 2\n"
            return data[offset:offset + size]
        raise FileNotFoundError

if __name__ == '__main__':
    FUSE(HelloFS(), '/mnt/fuse', foreground=True, allow_other=True)
