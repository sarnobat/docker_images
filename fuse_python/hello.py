from fuse import FUSE, Operations, FuseOSError
import errno

class HelloFS(Operations):
    def getattr(self, path, fh=None):
        if path == '/':
            return dict(st_mode=(0o755 | 0o040000), st_nlink=2)
        elif path == '/hello':
            data = b"Hello World!\n"
            return dict(st_mode=(0o444 | 0o100000), st_nlink=1, st_size=len(data))
        else:
            raise FuseOSError(errno.ENOENT)

    def readdir(self, path, fh):
        return ['.', '..', 'hello']

    def open(self, path, flags):
        if path != '/hello':
            raise FuseOSError(errno.ENOENT)

    def read(self, path, size, offset, fh):
        data = b"Hello World!\n"
        return data[offset:offset + size]

if __name__ == '__main__':
    import sys
    mountpoint = sys.argv[1]
    FUSE(HelloFS(), mountpoint, foreground=True, allow_other=True)
