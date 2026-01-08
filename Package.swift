// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BloodPressure",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BloodPressure",
            targets: ["BloodPressure"]),
    ],
    targets: [
        .target(
            name: "BloodPressure",
            path: "BloodPressure"
        )
    ]
)
