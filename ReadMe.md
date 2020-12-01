# Build cUrl for macOS

[x] HTTPS  (using [boringSSL](https://github.com/google/boringssl))
[x] HTTP/2 (using [nghttp2](https://github.com/nghttp2/nghttp2))
[x] HTTP/3 (using [quiche](https://github.com/cloudflare/quiche))

Install rust (for building quiche)

```
brew install rust
```

## Building

Run `build.sh`

## Testing

```
curl/build/src/curl -V
```

output

```
curl 7.73.0-DEV (Darwin) libcurl/7.73.0-DEV BoringSSL zlib/1.2.11 libssh2/1.9.0 nghttp2/1.42.0 quiche/0.6.0
Release-Date: [unreleased]
Protocols: dict file ftp ftps gopher http https imap imaps ldap mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS HTTP2 HTTP3 HTTPS-proxy IPv6 Largefile libz NTLM SSL UnixSockets
```

