// swift-tools-version: 5.7
import PackageDescription


let package = Package(
    name: "SwiftAnalyzer",
    products: [
        .library(
            name: "SwiftAnalyzer",
            targets: ["SwiftAnalyzer"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftAnalyzer",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftAnalyzerTests",
            dependencies: ["SwiftAnalyzer"]
        )
    ]
)
