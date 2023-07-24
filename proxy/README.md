This proxy assures x-request-id is et on both the request and response of http rquests going through this proxy.

It is configured to forward traffic to SO_ORIGINAL_DST when traffic go into the proxy through iptables rewrite. Non-http tcp
traffic will be forwarded unaltered.