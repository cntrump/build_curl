# Build cUrl for macOS

- [x] HTTPS  (using [boringSSL](https://github.com/google/boringssl))
- [x] HTTP/2 (using [nghttp2](https://github.com/nghttp2/nghttp2))
- [x] HTTP/3 (using [quiche](https://github.com/cloudflare/quiche))

Install `rust` (for building quiche using cargo)

```
brew install rust
```

Install `cmake`, `ninja` for building sources

```
brew install cmake ninja
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

Test HTTP/1.1

```
curl/build/src/curl --http1.1 -I https://quic.aiortc.org/
```

```
HTTP/1.1 200 OK
Server: nginx/1.14.2
Date: Tue, 01 Dec 2020 07:22:46 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 978
Connection: keep-alive
Alt-Svc: h3-29=":443"; ma=86400, h3-28=":443"; ma=86400, h3-27=":443"; ma=86400
```

Test HTTP/2

```
curl/build/src/curl --http2 -I https://quic.aiortc.org/
```

```
HTTP/2 200 
server: nginx/1.14.2
date: Tue, 01 Dec 2020 07:23:11 GMT
content-type: text/html; charset=utf-8
content-length: 978
alt-svc: h3-29=":443"; ma=86400, h3-28=":443"; ma=86400, h3-27=":443"; ma=86400
```

Test HTTP/3

```
curl/build/src/curl --http3 -I https://quic.aiortc.org/
```

```
HTTP/3 200
server: aioquic/0.9.7
date: Tue, 01 Dec 2020 07:23:33 GMT
content-length: 1068
content-type: text/html; charset=utf-8
```

More HTTP/3 test servers: 

https://bagder.github.io/HTTP3-test/