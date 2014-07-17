#! /bin/sh

# Open file descriptor limit
ulimit -n 4096

# Populate the Riak CS backends
for node in $(env | egrep 8080_TCP_ADDR);
do
  index=$(echo "${node}" | cut -d'-' -f2 | cut -d'_' -f1 | sed 's/CS//')
  node_ip=$(echo "${node}" | cut -d'=' -f2)

  echo "    server riak-cs${index} ${node_ip}:8080 weight 1 maxconn 1024 check" >> /etc/haproxy/haproxy.cfg
done

# Start HAProxy
exec /sbin/setuser haproxy /usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg >> /var/log/haproxy.log 2>&1
