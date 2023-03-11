//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import Kitura
import KituraStencil

public final class WebServer {
    private let portNumber: Int
    private let router = Router()
    
    public init(portNumber: Int = 1337) {
        self.portNumber = portNumber
        configureRouter()
    }
    
    private func configureRouter() {
        router.add(templateEngine: StencilTemplateEngine())
        router.get("/") { request, response, next in
            try response.send(fileName: "public/index.html")
            next()
        }
        
        configureStaticFiles()
    }
    
    private func configureStaticFiles() {
        router.get("/main.css") { request, response, next in
            try response.send(fileName: "public/css/main.css")
            next()
        }
        
        router.get("/d3.min.js") { request, response, next in
            try response.send(fileName: "public/js/d3.min.js")
            next()
        }
        
        router.get("/main.js") { request, response, next in
            try response.send(fileName: "public/js/main.js")
            next()
        }
        
        router.get("/data.js") { request, response, next in
            // TODO: Replace with useful data
            let context: [String: Any] = [
                "nodes": [
                    ["name": "Charlie"],
                    ["name": "Mac"],
                    ["name": "Dennis"],
                    ["name": "Dee"],
                    ["name": "Frank"],
                    ["name": "Cricket"]
                ],
                "links": [
                    ["source": "Charlie", "target": "Mac"],
                    ["source": "Dennis", "target": "Mac"],
                    ["source": "Dennis", "target": "Dee"],
                    ["source": "Dee", "target": "Mac"],
                    ["source": "Dee", "target": "Frank"],
                    ["source": "Cricket", "target": "Dee"]
                ]
            ]
            try response.render("data.stencil", context: context)
        }
    }
    
    public func run() {
        Kitura.addHTTPServer(onPort: portNumber, with: router)
        Kitura.logTo(.init(label: "logger"))
        Kitura.run()
    }
}
