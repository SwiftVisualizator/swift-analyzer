// swift-tools-version: 5.7
import PackageDescription


let package = Package(
    name: "SwiftAnalyzer",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "SwiftAnalyzer",
            targets: ["SwiftAnalyzer"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax",
            branch: "0.50700.1"
        )
    ],
    targets: [
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
