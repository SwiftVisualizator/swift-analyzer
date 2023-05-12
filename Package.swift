// swift-tools-version: 5.7
import PackageDescription

let package = Package(
	name: "SwiftAnalyzer",
	platforms: [
		.macOS(.v10_15)
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
			branch: "508.0.0"
		)
	],
	targets: [
		.executableTarget(
			name: "CommandLineRunner",
			dependencies: [
				"CommandLineCore",
				"Utils"
			]
		),
		.target(
			name: "CommandLineCore",
			dependencies: [
				"SwiftAnalyzer",
				"SwiftVisualizer",
				"Utils"
			]
		),
		.target(
			name: "SwiftVisualizer",
			dependencies: [
				"Utils"
			],
			resources: [
				.process("public")
			]
		),
		.target(
			name: "SwiftAnalyzer",
			dependencies: [
				"Utils",
				.product(name: "SwiftSyntax", package: "swift-syntax"),
				.product(name: "SwiftSyntaxParser", package: "swift-syntax"),
			]
		),
		.target(
			name: "Utils"
		),
		.testTarget(
			name: "SwiftAnalyzerTests",
			dependencies: ["SwiftAnalyzer"]
		)
	]
)
