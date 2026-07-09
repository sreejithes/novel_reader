// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "novel_reader",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "novel_reader", targets: ["novel_reader"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "novel_reader",
            dependencies: [],
            path: "Classes",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
