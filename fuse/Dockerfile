# Dockerfile: hello-fuse-nfs
FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y fuse libfuse2 libfuse-dev nfs-kernel-server build-essential && \
    mkdir -p /mnt/fuse /exports && \
    echo "/mnt/fuse *(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports

# --- Hello World FUSE filesystem source ---
RUN cat > /root/hello.c <<'EOF'
#define FUSE_USE_VERSION 31
#include <fuse3/fuse.h>
#include <string.h>

static int hello_getattr(const char *path, struct stat *st, struct fuse_file_info *fi) {
    (void) fi;
    memset(st, 0, sizeof(struct stat));
    if (strcmp(path, "/") == 0) {
        st->st_mode = S_IFDIR | 0755;
        st->st_nlink = 2;
    } else if (strcmp(path, "/hello") == 0) {
        st->st_mode = S_IFREG | 0444;
        st->st_nlink = 1;
        st->st_size = 13;
    } else
        return -ENOENT;
    return 0;
}

static int hello_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
                         off_t offset, struct fuse_file_info *fi, enum fuse_readdir_flags flags) {
    (void) offset; (void) fi; (void) flags;
    if (strcmp(path, "/") != 0)
        return -ENOENT;
    filler(buf, ".", NULL, 0, 0);
    filler(buf, "..", NULL, 0, 0);
    filler(buf, "hello", NULL, 0, 0);
    return 0;
}

static int hello_open(const char *path, struct fuse_file_info *fi) {
    if (strcmp(path, "/hello") != 0)
        return -ENOENT;
    if ((fi->flags & O_ACCMODE) != O_RDONLY)
        return -EACCES;
    return 0;
}

static int hello_read(const char *path, char *buf, size_t size, off_t offset,
                      struct fuse_file_info *fi) {
    const char *hello_str = "Hello World!\n";
    size_t len = strlen(hello_str);
    if (strcmp(path, "/hello") != 0)
        return -ENOENT;
    if (offset < len) {
        if (offset + size > len)
            size = len - offset;
        memcpy(buf, hello_str + offset, size);
    } else
        size = 0;
    return size;
}

static const struct fuse_operations hello_oper = {
    .getattr = hello_getattr,
    .readdir = hello_readdir,
    .open    = hello_open,
    .read    = hello_read,
};

int main(int argc, char *argv[]) {
    return fuse_main(argc, argv, &hello_oper, NULL);
}
EOF

# --- Build FUSE hello ---
RUN gcc /root/hello.c -o /usr/local/bin/hello -lfuse3

# --- Entrypoint: start FUSE + NFS ---
CMD /usr/local/bin/hello /mnt/fuse -f -o allow_other & \
    service nfs-kernel-server start && \
    echo "Container ready. Exporting /mnt/fuse over NFS..." && \
    tail -f /dev/null
