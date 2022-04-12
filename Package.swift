// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(

    name: "RecurrenceKit",

    products: [

        .library(
            name: "RecurrenceKit",
            targets: ["RecurrenceKit"]
        ),

        .executable(
            name: "Run",
            targets: ["Run"]
        )

    ],

    dependencies: [

        .package(name: "SnapshotTesting",
                 url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
                 from: "1.9.0")

    ],

    targets: [

        .target(
            name: "RecurrenceKit",
            dependencies: [

            ]
        ),

        .executableTarget(
            name: "Run",
            dependencies: [
                "RecurrenceKit"
            ]
        ),

        .testTarget(
            name: "RRuleTests",
            dependencies: [
                "RecurrenceKit",
                "SnapshotTesting"
            ]
        ),

    ]

)
