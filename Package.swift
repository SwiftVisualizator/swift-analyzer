// swift-tools-version: 5.7
import PackageDescription


let package = Package(
    name: "SwiftAnalyzer",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "SwiftAnalyzer",
            targets: ["SwiftAnalyzer"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "SwiftAnalyzer",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "SwiftAnalyzerTests",
            dependencies: ["SwiftAnalyzer"]
        )
    ]
)
