// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SwiftAnalyzer",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(
            name: "swift-analyzer",
            targets: ["CommandLineRunner"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax",
            branch: "0.50700.1"
        ),
        .package(url: "https://github.com/Kitura/Kitura", from: "2.8.0"),
        .package(url: "https://github.com/Kitura/Kitura-StencilTemplateEngine.git", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "CommandLineRunner",
            dependencies: ["CommandLineCore"]
        ),
        .target(
            name: "CommandLineCore",
            dependencies: [
                "SwiftAnalyzer",
                "WebServer"
            ]
        ),
        .target(
            name: "WebServer",
            dependencies: [
                .product(name: "Kitura", package: "Kitura"),
                .product(name: "KituraStencil", package: "Kitura-StencilTemplateEngine")
            ]
        ),
        .target(
            name: "SwiftAnalyzer",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxParser", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "SwiftAnalyzerTests",
            dependencies: ["SwiftAnalyzer"]
        )
    ]
)
