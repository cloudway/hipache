#!/bin/sh 

if [ -n "$HIPACHE_TLS_KEY" -a -n "$HIPACHE_TLS_CERT" ]; then
    cat > /hipache/config/config.json <<EOF
{
    "server": {
        "accessLog": "/var/log/hipache/hipache.log",
        "workers": 10,
        "maxSockets": 100,
        "deadBackendTTL": 300,
        "tcpTimeout": 30,
        "retryOnError": 3,
        "deadBackendOn500": true,
        "httpKeepAlive": false,
        "staticDir": null
    },
    "http": {
        "port": 80,
        "bind": [ "0.0.0.0" ]
    },
    "https": {
        "port": 443,
        "bind": [ "0.0.0.0" ],
        "key": "${HIPACHE_TLS_KEY}",
        "cert": "${HIPACHE_TLS_CERT}"
    },
    "driver": "redis://127.0.0.1:6379"
}
EOF
fi

exec /usr/local/bin/hipache -c /hipache/config/config.json
