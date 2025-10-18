#define FUSE_USE_VERSION 31
#include <errno.h>
#include <fcntl.h>
#include <fuse3/fuse.h>
#include <stddef.h>
#include <string.h>

static int getattr_cb(const char *p, struct stat *st,
                      struct fuse_file_info *fi) {
  (void)fi;
  memset(st, 0, sizeof(*st));
  if (!strcmp(p, "/")) {
    st->st_mode = S_IFDIR | 0755;
    st->st_nlink = 2;
    return 0;
  }
  if (!strcmp(p, "/hello")) {
    st->st_mode = S_IFREG | 0444;
    st->st_nlink = 1;
    st->st_size = 13;
    return 0;
  }
  return -ENOENT;
}
static int readdir_cb(const char *p, void *b, fuse_fill_dir_t f, off_t o,
                      struct fuse_file_info *fi, enum fuse_readdir_flags fl) {
  (void)o;
  (void)fi;
  (void)fl;
  if (strcmp(p, "/"))
    return -ENOENT;
  f(b, ".", NULL, 0, 0);
  f(b, "..", NULL, 0, 0);
  f(b, "hello", NULL, 0, 0);
  return 0;
}
static int open_cb(const char *p, struct fuse_file_info *fi) {
  if (strcmp(p, "/hello"))
    return -ENOENT;
  if ((fi->flags & O_ACCMODE) != O_RDONLY)
    return -EACCES;
  return 0;
}
static int read_cb(const char *p, char *b, size_t s, off_t o,
                   struct fuse_file_info *fi) {
  const char *msg = "Hello World C\n";
  size_t l = strlen(msg);
  if (strcmp(p, "/hello"))
    return -ENOENT;
  if (o < l) {
    if (o + s > l)
      s = l - o;
    memcpy(b, msg + o, s);
  } else
    s = 0;
  return s;
}
static const struct fuse_operations ops = {.getattr = getattr_cb,
                                           .readdir = readdir_cb,
                                           .open = open_cb,
                                           .read = read_cb};
int main(int a, char **v) { return fuse_main(a, v, &ops, NULL); }