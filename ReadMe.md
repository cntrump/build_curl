# Build cURL for macOS

- [x] OpenSSL 3.3.0
- [x] ngHTTP3 1.2.0
- [x] zlib 1.3.1

## Building

Run `build.sh`

## Testing

```
$ ./macosx/bin/curl -V

curl 8.7.1 (apple-macosx10.9) libcurl/8.7.1 OpenSSL/3.3.0 zlib/1.3.1 nghttp3/1.2.0
Release-Date: 2024-05-07
Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns mqtt pop3 pop3s rtsp smb smbs smtp smtps telnet tftp
Features: alt-svc AsynchDNS HSTS HTTP3 HTTPS-proxy IPv6 Largefile libz NTLM SSL threadsafe TLS-SRP UnixSockets
```

Test `HTTP/1.1`:

```
$ ./macosx/bin/curl --http1.1 -I https://quic.aiortc.org/

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
$ ./macosx/bin/curl --http2 -I https://quic.aiortc.org/

HTTP/2 200 
server: nginx/1.14.2
date: Tue, 01 Dec 2020 07:23:11 GMT
content-type: text/html; charset=utf-8
content-length: 978
alt-svc: h3-29=":443"; ma=86400, h3-28=":443"; ma=86400, h3-27=":443"; ma=86400
```

Test `HTTP/3`:

```
$ ./macosx/bin/curl --http3 -I https://quic.aiortc.org/

HTTP/3 200
server: aioquic/0.9.7
date: Tue, 01 Dec 2020 07:23:33 GMT
content-length: 1068
content-type: text/html; charset=utf-8
```

Upgrade via `Alt-Svc`:

```
$ ./macosx/bin/curl -I -v --alt-svc altsvc.cache https://quic.aiortc.org

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
brew tap cntrump/brew
brew install curlx
```

Test

```
curlx -V
```
