import ArgumentParser

struct Platform {
    let name: String
    let destination: String
    let sdk: String? // xcodebuild -showsdks
    let archs: String
    let buildFolder: String
}

/*
 1. buildFolder的结尾要和sdk名称一致
 2. build之前最好清空整个output文件夹
 */
extension Platform {
    static let ios = Platform(
        name: "ios",
        destination: "-destination generic/platform=iOS",
        sdk: "iphoneos",
        archs: "arm64",
        buildFolder: "Release-iphoneos"
    )

    static let catalyst = Platform(
        name: "catalyst",
        destination: "generic/platform=macOS,variant=Mac Catalyst",
        sdk: nil,
        archs: "arm64",
        buildFolder: "Release-catalyst"
    )
}

extension Platform {
    static let visionos = Platform(
        name: "visionos",
        destination: "-destination generic/platform=visionOS",
        sdk: "xros",
        archs: "arm64",
        buildFolder: "Release-xros"
    )
}

extension Platform {
    static let iosSimulator = Platform(
        name: "iosSimulator",
        destination: "-destination 'generic/platform=iOS Simulator'",
        sdk: "iphonesimulator",
        archs: "x86_64 arm64",
        buildFolder: "Release-iphonesimulator"
    )

    static let visionosSimulator = Platform(
        name: "visionosSimulator",
        destination: "-destination 'generic/platform=visionOS Simulator'",
        sdk: "xrsimulator",
        archs: "arm64",
        buildFolder: "Release-xrsimulator"
    )
}

extension Platform: ExpressibleByArgument {
    init?(argument: String) {
        switch argument {
        case "ios": self = .ios
        case "visionos": self = .visionos
        case "iosSimulator": self = .iosSimulator
        case "visionosSimulator": self = .visionosSimulator
        default: return nil
        }
    }
}

extension Array: ExpressibleByArgument where Element: ExpressibleByArgument {
    public init?(argument: String) {
        self = argument.split(separator: " ")
            .compactMap { Element.init(argument: String($0)) }
    }
}
