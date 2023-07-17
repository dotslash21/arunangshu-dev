---
layout: ../../../layouts/MarkdownPostLayout.astro
draft: false
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

        // Echo all incoming data.
        for {
            // Accept a TCP connection
            conn, err := lst.Accept()
            if err != nil {
                // Handle error
                log.Fatal(err)
            }

            log.Print("Accepted connection from ", conn.RemoteAddr().String())
            go handleConnection(conn)
        }
    }
}

func handleConnection(c net.Conn) {
    defer c.Close()

    io.Copy(c, c)

    log.Print("Closing connection to ", c.RemoteAddr().String())
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
This section specifies that the code is part of the `main` package, which is the default package for an executable Go program. Several libraries are then imported:

-   `fmt`: This package contains functions for formatted I/O.
-   `io`: This package provides basic interfaces to I/O primitives.
-   `log`: This package provides simple logging services.
-   `net`: This package provides a portable interface for network I/O, including TCP/IP, UDP, and Unix domain sockets.

```go
var PORT = 80
```
Here a global variable `PORT` is declared and initialized to `80`. This is the port that the server will listen on for incoming connections.

```go
func RunServer() {
	for {
		log.Print("Listening on port ", PORT, " for incoming connections.")
		lst, err := net.Listen("tcp", ":"+fmt.Sprint(PORT))
		if err != nil {
			log.Fatal(err)
		}

		for {
			conn, err := lst.Accept()
			if err != nil {
				log.Fatal(err)
			}

			log.Print("Accepted connection from ", conn.RemoteAddr().String())
			go handleConnection(conn)
		}
	}
}
```
The `RunServer` function starts an infinite loop that listens for incoming connections on the specified port. If it encounters an error, it logs the error and terminates the program. If it successfully accepts a connection, it prints a log message stating that it has accepted the connection from the remote address, and calls the `handleConnection` function in a separate goroutine, passing the connection to it.

```go
func handleConnection(c net.Conn) {
	defer c.Close()

	io.Copy(c, c)

	log.Print("Closing connection to ", c.RemoteAddr().String())
}
```
This function is used to handle a new connection. It uses the `defer` statement to ensure that the connection will be closed when the function exits, regardless of how it exits. It then copies data from the connection to itself, effectively echoing all incoming data back to the client. Once the connection is closed, a log message is printed to indicate this.

> **_Note:_** `io.Copy(c, c)` is a simple echo operation. It copies data from the source (the connection itself) to the destination (again, the connection itself). So, whatever data the server receives from a client, it sends the same data back to the client.

```go
func main() {
    RunServer()
}
```
The `main` function is the entry point for the executable program. It simply calls the `RunServer` function to start the server. The server will then listen indefinitely for incoming connections on the specified port.