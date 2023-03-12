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
        )
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
                "SwiftVisualizer"
            ]
        ),
        .target(
            name: "SwiftVisualizer",
            resources: [
                .process("public")
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
