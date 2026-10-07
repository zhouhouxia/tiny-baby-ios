// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MealCompanion",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.executable(name: "MealCompanion", targets: ["MealCompanion"])],
    targets: [.executableTarget(name: "MealCompanion")]
)
