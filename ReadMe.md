# Build cUrl for macOS [![Build Status](https://travis-ci.com/cntrump/build_curl.svg?branch=main)](https://travis-ci.com/cntrump/build_curl)

- [x] HTTPS  (using [boringSSL](https://github.com/google/boringssl))
- [x] HTTP/2 (using [nghttp2](https://github.com/nghttp2/nghttp2))
- [x] HTTP/3 (using [quiche](https://github.com/cloudflare/quiche))

Install `rust` (for building `quiche` using cargo) and `go` (for building `boringssl`)

```
brew install rust go
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
curl 7.73.0 (Darwin) libcurl/7.73.0 BoringSSL zlib/1.2.11 zstd/1.4.5 libssh2/1.9.0 nghttp2/1.42.0 quiche/0.6.0
Release-Date: 2020-12-02
Protocols: dict file ftp ftps gopher http https imap imaps ldap mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: alt-svc AsynchDNS HTTP2 HTTP3 HTTPS-proxy IPv6 Largefile libz NTLM SSL UnixSockets zstd
```

Test `HTTP/1.1`:

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

Test `HTTP/2`:

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

Test `HTTP/3`:

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

Upgrade via `Alt-Svc`:

```
curl/build/src/curl -I -v --alt-svc altsvc.cache https://quic.aiortc.org
```

```
* Alt-svc connecting from [h2]quic.aiortc.org:443 to [h3-29]quic.aiortc.org:443
*   Trying 34.247.69.99:443...
* Sent QUIC client Initial, ALPN: h3-29,h3-28,h3-27
* Connected to quic.aiortc.org (34.247.69.99) port 443 (#0)
* h3 [:method: HEAD]
* h3 [:path: /]
* h3 [:scheme: https]
* h3 [:authority: quic.aiortc.org]
* h3 [user-agent: curl/7.73.0]
* h3 [accept: */*]
* h3 [alt-used: quic.aiortc.org:443]
* Using HTTP/3 Stream ID: 0 (easy handle 0x7f8fdc813e00)
> HEAD / HTTP/3
> Host: quic.aiortc.org
> user-agent: curl/7.73.0
> accept: */*
> alt-used: quic.aiortc.org:443
> 
< HTTP/3 200
HTTP/3 200
< server: aioquic/0.9.7
server: aioquic/0.9.7
< date: Wed, 02 Dec 2020 07:26:39 GMT
date: Wed, 02 Dec 2020 07:26:39 GMT
< content-length: 1068
content-length: 1068
< content-type: text/html; charset=utf-8
content-type: text/html; charset=utf-8

< 
* Excess found: excess = 1068 url = / (zero-length body)
* Connection #0 to host quic.aiortc.org left intact
```

More HTTP/3 test servers: 

https://bagder.github.io/HTTP3-test/

## Install

```
brew tap cntrump/curlx
brew install curlx
```

Test

```
curlx -V
```
