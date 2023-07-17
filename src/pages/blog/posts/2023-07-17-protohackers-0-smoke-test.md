---
layout: ../../../layouts/MarkdownPostLayout.astro
draft: true
title: "Protohackers - 0: Smoke Test"
pubDate: 2023-07-17T14:48:31.304Z
featuredImage: /images/uploads/351000_series-of-matrix-like-0-and-1-digits-behind-smoke-_esrgan-v1-x2plus.png
description: Protohacker solution breakdown for the first problem.
tags:
  - protohacker
  - solution
---

## P﻿roblem summary

The task is to create a generic server that implements the TCP Echo Service from RFC 862. The server should accept TCP connections and be capable of handling at least five simultaneous clients. Its main functionality is to receive data from clients and send it back unmodified. The server must handle binary data without altering it. Once a client finishes sending data and closes it's sending side, the server should close the corresponding socket after receiving and echoing all the data. This behavior aligns with the requirements specified in the TCP Echo Service definition.

P﻿roblem statement link: [https://protohackers.com/problem/0](https://protohackers.com/problem/0)

## Code

```go
package main

import (
    "fmt"
    "io"
    "log"
    "net"
)

var PORT = 80

func RunServer() {
    for {
        // Listen for incoming connections
        log.Print("Listening on port ", PORT, " for incoming connections.")
        lst, err := net.Listen("tcp", ":"+fmt.Sprint(PORT))
        if err != nil {
            // Handle error
            log.Fatal(err)
        }
}

func handleConnection(c net.Conn) {
    defer c.Close()
}

func main() {
    RunServer()
}

```

## B﻿reakdown

```go
package main

import (
    "fmt"
    "io"
    "log"
    "net"
)
```
In this section, the program is defining its package as main. This is the entry point for a standalone executable program in Go. It then imports several packages which it will use in the following code:

- fmt: provides formatting for input and output.
- io: provides basic functions to perform input and output operations. log: provides simple logging services.
- net: provides a portable interface for network I/O, including TCP/IP, UDP, domain name resolution, and Unix domain sockets.

```go
var PORT = 80
```
Here, a global variable `PORT` is declared and initialized to `80`. This represents the port number that the server will listen on for incoming TCP connections.

```go
func RunServer() {
	for {
		// Listen for incoming connections
		log.Print("Listening on port ", PORT, " for incoming connections.")
		lst, err := net.Listen("tcp", ":"+fmt.Sprint(PORT))
		if err != nil {
			// Handle error
			log.Fatal(err)
		}
}
```
In this block, a function `RunServer` is defined. This function listens for incoming connections indefinitely. It's missing a close brace `}`, so the current form will result in a compile-time error.

The `net.Listen` function is used to listen for incoming connections on the specified network and address. In this case, it's listening on `tcp` network at the port defined by `PORT`. If `net.Listen` encounters an error, it's logged and the program is terminated by `log.Fatal`.

```go
func handleConnection(c net.Conn) {
	defer c.Close()
}
```
This function is intended to handle a connection once it's established. `net.Conn` is an interface representing a network connection. The `defer` keyword is used to ensure that the `Close` method is called on the connection when the `handleConnection` function exits, regardless of how it exits.

```go
func main() {
	RunServer()
}
```
Finally, the `main` function is defined. This is the entry point for the executable program. It calls the `RunServer` function to start the server. The server will then listen indefinitely for incoming connections on the specified port.