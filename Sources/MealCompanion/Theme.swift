import SwiftUI

enum RiverFont {
    static let name = "HanziPenSC-W3"
    static let fallbackName = "HanziPen SC"
    static let accentName = "Bradley Hand"

    static func text(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
        .custom(resolvedChineseName, size: size, relativeTo: style)
    }

    static func accent(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
        .custom(accentName, size: size, relativeTo: style)
    }

    private static var resolvedChineseName: String {
        #if os(iOS)
        if UIFont(name: name, size: 12) != nil { return name }
        if UIFont(name: fallbackName, size: 12) != nil { return fallbackName }
        #endif
        return name
    }
}

enum RiverTheme {
    static let backgroundStorageKey = "tinyBabyBackgroundChoice"
    static let ink = Color.black
    static let moss = Color.black.opacity(0.62)
    static let tinyGreen = Color(red: 0.694, green: 0.733, blue: 0.071)
    static let clay = Color(red: 0.400, green: 0.454, blue: 0.620)
    static let mist = Color(red: 0.706, green: 0.784, blue: 0.855)
    static let card = Color(red: 0.925, green: 0.949, blue: 0.969).opacity(0.86)
}

enum RiverBackgroundChoice: String, CaseIterable, Identifiable {
    case mistBlue
    case sageGreen
    case warmIvory
    case paleLavender

    var id: String { rawValue }

    var name: String {
        switch self {
        case .mistBlue: "雾霾蓝"
        case .sageGreen: "鼠尾草绿"
        case .warmIvory: "暖象牙白"
        case .paleLavender: "淡薰衣草紫"
        }
    }

    var color: Color {
        switch self {
        case .mistBlue: Color(red: 175 / 255, green: 198 / 255, blue: 220 / 255)
        case .sageGreen: Color(red: 168 / 255, green: 185 / 255, blue: 164 / 255)
        case .warmIvory: Color(red: 244 / 255, green: 241 / 255, blue: 232 / 255)
        case .paleLavender: Color(red: 201 / 255, green: 190 / 255, blue: 219 / 255)
        }
    }

    var iconColor: Color {
        switch self {
        case .mistBlue:
            Color(red: 71 / 255, green: 104 / 255, blue: 133 / 255)
        case .paleLavender:
            Color(red: 116 / 255, green: 94 / 255, blue: 145 / 255)
        default:
            color
        }
    }
}

struct RiverBackground: View {
    @AppStorage(RiverTheme.backgroundStorageKey)
    private var selectedBackground = RiverBackgroundChoice.warmIvory.rawValue

    var body: some View {
        (RiverBackgroundChoice(rawValue: selectedBackground) ?? .warmIvory)
            .color
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.32), value: selectedBackground)
    }
}

struct RiverBackgroundPalette: View {
    @AppStorage(RiverTheme.backgroundStorageKey)
    private var selectedBackground = RiverBackgroundChoice.warmIvory.rawValue

    var body: some View {
        VStack(spacing: 14) {
            ForEach(RiverBackgroundChoice.allCases) { choice in
                Button {
                    withAnimation(.easeInOut(duration: 0.32)) {
                        selectedBackground = choice.rawValue
                    }
                } label: {
                    RiverDoodleIcon(
                        choice: choice,
                        isSelected: selectedBackground == choice.rawValue
                    )
                    .frame(width: 48, height: 48)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("切换为\(choice.name)背景")
                .accessibilityAddTraits(selectedBackground == choice.rawValue ? .isSelected : [])
            }
        }
    }
}

private struct RiverDoodleIcon: View {
    let choice: RiverBackgroundChoice
    let isSelected: Bool

    var body: some View {
        Canvas { context, size in
            let mark = markPath(in: size)
            let lineStyle = StrokeStyle(lineWidth: 1.55, lineCap: .round, lineJoin: .round)

            context.stroke(mark, with: .color(choice.iconColor), style: lineStyle)

            if isSelected {
                let ring = selectionRing(in: size)
                context.stroke(
                    ring,
                    with: .color(choice.iconColor),
                    style: StrokeStyle(lineWidth: 1.55, lineCap: .round, lineJoin: .round)
                )
            }
        }
        .accessibilityHidden(true)
    }

    private func markPath(in size: CGSize) -> Path {
        let x = size.width / 48
        let y = size.height / 48
        var path = Path()

        switch choice {
        case .mistBlue:
            path.move(to: CGPoint(x: 16 * x, y: 13 * y))
            path.addCurve(
                to: CGPoint(x: 34 * x, y: 35 * y),
                control1: CGPoint(x: 22 * x, y: 21 * y),
                control2: CGPoint(x: 29 * x, y: 29 * y)
            )
            path.move(to: CGPoint(x: 35 * x, y: 12 * y))
            path.addCurve(
                to: CGPoint(x: 14 * x, y: 36 * y),
                control1: CGPoint(x: 29 * x, y: 20 * y),
                control2: CGPoint(x: 21 * x, y: 28 * y)
            )
        case .sageGreen:
            path.move(to: CGPoint(x: 25 * x, y: 12 * y))
            path.addCurve(
                to: CGPoint(x: 37 * x, y: 25 * y),
                control1: CGPoint(x: 33 * x, y: 12 * y),
                control2: CGPoint(x: 37 * x, y: 18 * y)
            )
            path.addCurve(
                to: CGPoint(x: 23 * x, y: 37 * y),
                control1: CGPoint(x: 36 * x, y: 33 * y),
                control2: CGPoint(x: 30 * x, y: 37 * y)
            )
            path.addCurve(
                to: CGPoint(x: 12 * x, y: 23 * y),
                control1: CGPoint(x: 15 * x, y: 36 * y),
                control2: CGPoint(x: 11 * x, y: 30 * y)
            )
            path.addCurve(
                to: CGPoint(x: 25 * x, y: 12 * y),
                control1: CGPoint(x: 13 * x, y: 16 * y),
                control2: CGPoint(x: 18 * x, y: 12 * y)
            )
        case .warmIvory:
            path.move(to: CGPoint(x: 13 * x, y: 14 * y))
            path.addLine(to: CGPoint(x: 35 * x, y: 12 * y))
            path.addLine(to: CGPoint(x: 36 * x, y: 35 * y))
            path.addLine(to: CGPoint(x: 12 * x, y: 36 * y))
            path.closeSubpath()
        case .paleLavender:
            path.move(to: CGPoint(x: 24 * x, y: 11 * y))
            path.addLine(to: CGPoint(x: 38 * x, y: 35 * y))
            path.addLine(to: CGPoint(x: 11 * x, y: 34 * y))
            path.closeSubpath()
        }
        return path
    }

    private func selectionRing(in size: CGSize) -> Path {
        let x = size.width / 48
        let y = size.height / 48
        var path = Path()
        path.move(to: CGPoint(x: 25 * x, y: 4 * y))
        path.addCurve(
            to: CGPoint(x: 44 * x, y: 24 * y),
            control1: CGPoint(x: 37 * x, y: 4 * y),
            control2: CGPoint(x: 43 * x, y: 12 * y)
        )
        path.addCurve(
            to: CGPoint(x: 23 * x, y: 44 * y),
            control1: CGPoint(x: 44 * x, y: 37 * y),
            control2: CGPoint(x: 35 * x, y: 44 * y)
        )
        path.addCurve(
            to: CGPoint(x: 4 * x, y: 23 * y),
            control1: CGPoint(x: 11 * x, y: 44 * y),
            control2: CGPoint(x: 4 * x, y: 35 * y)
        )
        path.addCurve(
            to: CGPoint(x: 25 * x, y: 4 * y),
            control1: CGPoint(x: 5 * x, y: 11 * y),
            control2: CGPoint(x: 13 * x, y: 5 * y)
        )
        return path
    }
}
