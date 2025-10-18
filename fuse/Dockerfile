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
        systemd-sysv \
        dbus \
        build-essential \
        net-tools iproute2 procps psmisc vim less && \
    echo "user_allow_other" >> /etc/fuse.conf && \
    mkdir -p /mnt/fuse /export/fuse /var/run/ganesha /var/lib/nfs /var/log /run/dbus

# ---- Build the FUSE "Hello World" program ----
# RUN cat > /root/hello.c <<'EOF'

# EOF

COPY hello.c /root/hello.c

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
echo 'Verifying FUSE mount...'; \
if ! mountpoint -q /mnt/fuse; then \
  echo 'ERROR: FUSE mount failed'; \
  echo 'Run container with: docker run --privileged -p 2049:2049 IMAGE'; \
  exit 1; \
fi; \
ls -la /mnt/fuse; \
cat /mnt/fuse/hello; \
\
echo '🔗 Binding FUSE to /export/fuse with bindfs...'; \
bindfs /mnt/fuse /export/fuse; \
ls -la /export/fuse; \
\
echo 'Starting NFS-Ganesha...'; \
ganesha.nfsd -F -f /etc/ganesha/ganesha.conf -L /var/log/ganesha.log -N NIV_EVENT & \
sleep 5; \
\
echo '🔍 Verifying NFS port 2049 is listening...'; \
if ! netstat -tulpn | grep -q ':2049'; then \
  echo 'ERROR: NFS port 2049 not listening'; \
  echo 'Ganesha failed to start properly'; \
  cat /var/log/ganesha.log | tail -20; \
  exit 1; \
fi; \
\
echo ''; \
echo '═══════════════════════════════════════════════'; \
echo 'NFS Server Ready'; \
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