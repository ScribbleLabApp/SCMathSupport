// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MathSupport",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .watchOS(.v11), .macCatalyst(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MathSupport",
            targets: ["MathSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/exyte/SVGView.git", from: "1.0.6"),
        .package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.4.0"),
        .package(url: "https://github.com/Kitura/swift-html-entities.git", from: "4.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MathSupport", 
            dependencies: ["SVGView", "MathJaxSwift", "HTMLEntities"]
        ),
        .testTarget(
            name: "MathSupportTests",
            dependencies: ["MathSupport"]
        ),
    ]
)
