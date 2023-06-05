#!/usr/bin/env sh
set -ex

PROXY_PORT="${PROXY_PORT:-7060}"
PROXY_UID="${PROXY_UID:-2103}"
POD_HOST_NETWORK="${POD_HOST_NETWORK:-false}"

if [ "$POD_HOST_NETWORK" = "true" ]; then
  echo "Pod is running on the host network, not injecting proxy"
  exit 0
fi

if [ "$LINKERD" = "true" ]; then
  echo "Detected linkerd, redirecting localhost traffic from linkerd proxy to $PORT"
  echo

  LINKERD_PROXY_UID="${LINKERD_PROXY_UID:-2102}"
  LINKERD_ADMIN_PORT="${LINKERD_ADMIN_PORT:-4191}"

  # Implementation based on description here: https://linkerd.io/2021/09/23/how-linkerd-uses-iptables-to-transparently-route-kubernetes-traffic/ and
  # observing the actual iptables setup of linkerd.

  iptables -t nat -N STS_PROXY_LOCAL_REDIRECT
  # Need to ignore linkerd liveness port to allow pod to start up (otherwise our proxy won't be up just yet).
  iptables -t nat -A STS_PROXY_LOCAL_REDIRECT -p tcp -m multiport --dports "$LINKERD_ADMIN_PORT" -m comment --comment "ignore-linkerd-liveness-probe" -j RETURN
  # We only want to redirect localhost traffic coming form the linkerd proxy. (Inbound traffic)
  iptables -t nat -A STS_PROXY_LOCAL_REDIRECT -p tcp -o lo -m owner --uid-owner "$LINKERD_PROXY_UID" -j REDIRECT --to-port "$PROXY_PORT" -m comment --comment redirect-to-id-injector
  iptables -t nat -A OUTPUT -j STS_PROXY_LOCAL_REDIRECT -m comment --comment sts-local-rerouting

  iptables-save
elif [ "`iptables -t nat -S PREROUTING`" = "-P PREROUTING ACCEPT" ]; then # Making sure we are rewriting a vanilla iptables
  echo "Redirecting incoming traffic traffic to $PROXY_PORT"
  echo
  iptables -t nat -N STS_PROXY_INBOUND_REDIRECT
  iptables -t nat -A STS_PROXY_INBOUND_REDIRECT -p tcp -j REDIRECT --to-port "$PROXY_PORT" -m comment --comment redirect-to-id-injector
  iptables -t nat -A PREROUTING -j STS_PROXY_INBOUND_REDIRECT -m comment --comment sts-prerouting

  iptables-save
else
  echo "Not modifying iptables, the iptables have been modified"
  echo
  iptables-save
fi