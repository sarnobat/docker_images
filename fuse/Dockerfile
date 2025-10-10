# ==============================================
#  FUSE + NFS-Ganesha Complete Working Solution
#  Exports FUSE filesystem via NFS using bindfs
#  REQUIRES: docker run --privileged -p 2049:2049
# ==============================================
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# ---- Install all required packages ----
RUN apt-get update && \
    apt-get install -y \
        fuse3 libfuse3-dev \
        bindfs \
        nfs-ganesha nfs-ganesha-vfs \
        rpcbind \
        dbus \
        build-essential \
        net-tools iproute2 procps psmisc vim less && \
    echo "user_allow_other" >> /etc/fuse.conf && \
    mkdir -p /mnt/fuse /export/fuse /var/run/ganesha /var/lib/nfs /var/log /run/dbus

# ---- Build the FUSE "Hello World" program ----
RUN cat > /root/hello.c <<'EOF'
#define FUSE_USE_VERSION 31
#include <fuse3/fuse.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <stddef.h>

static int getattr_cb(const char *p, struct stat *st, struct fuse_file_info *fi) {
    (void)fi; memset(st,0,sizeof(*st));
    if (!strcmp(p,"/")) { st->st_mode=S_IFDIR|0755; st->st_nlink=2; return 0; }
    if (!strcmp(p,"/hello")) { st->st_mode=S_IFREG|0444; st->st_nlink=1; st->st_size=13; return 0; }
    return -ENOENT;
}
static int readdir_cb(const char *p, void *b, fuse_fill_dir_t f, off_t o,
                      struct fuse_file_info *fi, enum fuse_readdir_flags fl) {
    (void)o;(void)fi;(void)fl;
    if (strcmp(p,"/")) return -ENOENT;
    f(b,".",NULL,0,0); f(b,"..",NULL,0,0); f(b,"hello",NULL,0,0);
    return 0;
}
static int open_cb(const char *p, struct fuse_file_info *fi) {
    if (strcmp(p,"/hello")) return -ENOENT;
    if ((fi->flags&O_ACCMODE)!=O_RDONLY) return -EACCES;
    return 0;
}
static int read_cb(const char *p,char *b,size_t s,off_t o,struct fuse_file_info *fi){
    const char *msg="Hello World!\n"; size_t l=strlen(msg);
    if (strcmp(p,"/hello")) return -ENOENT;
    if (o<l){ if (o+s>l) s=l-o; memcpy(b,msg+o,s);} else s=0; return s;
}
static const struct fuse_operations ops={ .getattr=getattr_cb,.readdir=readdir_cb,
                                         .open=open_cb,.read=read_cb };
int main(int a,char **v){ return fuse_main(a,v,&ops,NULL); }
EOF

RUN gcc /root/hello.c -o /usr/local/bin/hello -lfuse3

# ---- Configure NFS-Ganesha ----
RUN mkdir -p /etc/ganesha
RUN cat > /etc/ganesha/ganesha.conf <<'EOF'
NFS_Core_Param {
    NFS_Protocols = 4;
    Bind_Addr = 0.0.0.0;
    MNT_Port = 20048;
    NFS_Port = 2049;
}

NFSv4 {
    Grace_Period = 0;
    Lease_Lifetime = 10;
    RecoveryBackend = fs;
}

NFS_KRB5 {
    Active_krb5 = false;
}

LOG {
    Components {
        ALL = EVENT;
    }
    Facility {
        name = FILE;
        destination = "/var/log/ganesha.log";
    }
}

EXPORT {
    Export_Id = 1;
    Path = /export/fuse;
    Pseudo = /;
    Access_Type = RW;
    Squash = No_Root_Squash;
    Protocols = 4;
    Transports = TCP;
    SecType = "sys";
    FSAL { Name = VFS; }
}
EOF

# ---- Expose NFS port ----
EXPOSE 2049

# ---- Entrypoint ----
CMD ["/bin/bash", "-c", "\
set -e; \
echo '🔧 Setting up directories...'; \
mkdir -p /var/run/ganesha /var/lib/nfs /var/log /run/dbus /mnt/fuse /export/fuse; \
\
echo '🚀 Starting rpcbind (required for NFS)...'; \
rpcbind; \
sleep 2; \
\
echo '🚀 Starting DBUS...'; \
dbus-daemon --system --fork 2>/dev/null || true; \
\
echo '📁 Starting FUSE Hello filesystem at /mnt/fuse...'; \
/usr/local/bin/hello /mnt/fuse -f -o allow_other & \
sleep 3; \
\
echo '✅ Verifying FUSE mount...'; \
if ! mountpoint -q /mnt/fuse; then \
  echo '❌ ERROR: FUSE mount failed!'; \
  echo '❌ Run container with: docker run --privileged -p 2049:2049 IMAGE'; \
  exit 1; \
fi; \
ls -la /mnt/fuse; \
cat /mnt/fuse/hello; \
\
echo '🔗 Binding FUSE to /export/fuse with bindfs...'; \
bindfs /mnt/fuse /export/fuse; \
ls -la /export/fuse; \
\
echo '✅ Starting NFS-Ganesha...'; \
ganesha.nfsd -F -f /etc/ganesha/ganesha.conf -L /var/log/ganesha.log -N NIV_EVENT & \
sleep 5; \
\
echo '🔍 Verifying NFS port 2049 is listening...'; \
if ! netstat -tulpn | grep -q ':2049'; then \
  echo '❌ ERROR: NFS port 2049 not listening!'; \
  echo '❌ Ganesha failed to start properly'; \
  cat /var/log/ganesha.log | tail -20; \
  exit 1; \
fi; \
\
echo ''; \
echo '═══════════════════════════════════════════════'; \
echo '✅ NFS Server Ready!'; \
echo '═══════════════════════════════════════════════'; \
echo 'FUSE mount: /mnt/fuse'; \
echo 'NFS export: /export/fuse'; \
echo 'NFS port: 2049'; \
echo ''; \
echo 'Test inside container:'; \
echo '  mkdir -p /mnt/test'; \
echo '  mount -t nfs -o vers=4,port=2049 127.0.0.1:/ /mnt/test'; \
echo '  cat /mnt/test/hello'; \
echo ''; \
echo 'Test from host (get container IP first):'; \
echo '  hostname -I'; \
echo '  sudo mount -t nfs -o vers=4 CONTAINER_IP:/ /tmp/nfs'; \
echo '═══════════════════════════════════════════════'; \
echo ''; \
\
tail -f /var/log/ganesha.log \
"]