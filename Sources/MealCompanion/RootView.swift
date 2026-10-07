import SwiftUI

struct RootView: View {
    @State private var selectedTab = AppTab.today

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .today:
                    TodayView()
                case .memories:
                    MemoriesView()
                case .preferences:
                    PreferencesView()
                case .moon:
                    MoonRecommendationsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                ForEach(AppTab.allCases) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        VStack(spacing: 3) {
                            ThinTabIcon(tab.icon)
                            Text(tab.title)
                                .font(RiverFont.text(10, relativeTo: .caption2))
                        }
                        .foregroundStyle(selectedTab == tab ? RiverTheme.ink.opacity(0.92) : RiverTheme.ink.opacity(0.42))
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(tab.title)
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 7)
        }
        .font(RiverFont.text(17))
        .foregroundStyle(RiverTheme.ink)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

private enum AppTab: CaseIterable, Identifiable {
    case today
    case memories
    case preferences
    case moon

    var id: Self { self }

    var title: String {
        switch self {
        case .today: "今天"
        case .memories: "吃过的"
        case .preferences: "偏好"
        case .moon: "月亮推荐"
        }
    }

    var icon: ThinTabIconKind {
        switch self {
        case .today: .today
        case .memories: .memories
        case .preferences: .preferences
        case .moon: .moon
        }
    }
}

private enum ThinTabIconKind {
    case today
    case memories
    case preferences
    case moon
}

private struct ThinTabIcon: View {
    let kind: ThinTabIconKind

    init(_ kind: ThinTabIconKind) {
        self.kind = kind
    }

    var body: some View {
        Canvas { context, size in
            let style = StrokeStyle(lineWidth: 1.35, lineCap: .round, lineJoin: .round)
            context.stroke(path(in: size), with: .color(RiverTheme.ink.opacity(0.82)), style: style)
        }
        .frame(width: 24, height: 24)
        .accessibilityHidden(true)
    }

    private func path(in size: CGSize) -> Path {
        let x = size.width / 24
        let y = size.height / 24
        var path = Path()

        switch kind {
        case .today:
            path.addEllipse(in: CGRect(x: 8 * x, y: 8 * y, width: 8 * x, height: 8 * y))
            let rays = [
                (CGPoint(x: 12 * x, y: 3 * y), CGPoint(x: 12 * x, y: 6 * y)),
                (CGPoint(x: 12 * x, y: 18 * y), CGPoint(x: 12 * x, y: 21 * y)),
                (CGPoint(x: 3 * x, y: 12 * y), CGPoint(x: 6 * x, y: 12 * y)),
                (CGPoint(x: 18 * x, y: 12 * y), CGPoint(x: 21 * x, y: 12 * y)),
                (CGPoint(x: 5.5 * x, y: 5.5 * y), CGPoint(x: 7.4 * x, y: 7.4 * y)),
                (CGPoint(x: 16.6 * x, y: 16.6 * y), CGPoint(x: 18.6 * x, y: 18.6 * y)),
                (CGPoint(x: 18.5 * x, y: 5.4 * y), CGPoint(x: 16.5 * x, y: 7.4 * y)),
                (CGPoint(x: 7.4 * x, y: 16.6 * y), CGPoint(x: 5.5 * x, y: 18.6 * y))
            ]
            for ray in rays {
                path.move(to: ray.0)
                path.addLine(to: ray.1)
            }
            path.move(to: CGPoint(x: 10 * x, y: 10.5 * y))
            path.addCurve(
                to: CGPoint(x: 14 * x, y: 10.5 * y),
                control1: CGPoint(x: 11.2 * x, y: 9.8 * y),
                control2: CGPoint(x: 12.8 * x, y: 9.8 * y)
            )
        case .memories:
            path.move(to: CGPoint(x: 17 * x, y: 6 * y))
            path.addCurve(
                to: CGPoint(x: 20 * x, y: 13 * y),
                control1: CGPoint(x: 20 * x, y: 8 * y),
                control2: CGPoint(x: 21 * x, y: 11 * y)
            )
            path.addCurve(
                to: CGPoint(x: 12 * x, y: 20 * y),
                control1: CGPoint(x: 19 * x, y: 18 * y),
                control2: CGPoint(x: 16 * x, y: 20 * y)
            )
            path.addCurve(
                to: CGPoint(x: 4.5 * x, y: 12 * y),
                control1: CGPoint(x: 7 * x, y: 20 * y),
                control2: CGPoint(x: 4 * x, y: 17 * y)
            )
            path.addCurve(
                to: CGPoint(x: 11 * x, y: 4.5 * y),
                control1: CGPoint(x: 5 * x, y: 7 * y),
                control2: CGPoint(x: 7.5 * x, y: 4.5 * y)
            )
            path.move(to: CGPoint(x: 14 * x, y: 4.7 * y))
            path.addCurve(to: CGPoint(x: 17 * x, y: 6 * y), control1: CGPoint(x: 15 * x, y: 4.9 * y), control2: CGPoint(x: 16 * x, y: 5.2 * y))
        case .preferences:
            path.move(to: CGPoint(x: 12 * x, y: 19 * y))
            path.addCurve(
                to: CGPoint(x: 5.5 * x, y: 10 * y),
                control1: CGPoint(x: 7.5 * x, y: 16 * y),
                control2: CGPoint(x: 4.5 * x, y: 13.5 * y)
            )
            path.addCurve(
                to: CGPoint(x: 12 * x, y: 8 * y),
                control1: CGPoint(x: 6.5 * x, y: 6 * y),
                control2: CGPoint(x: 10 * x, y: 6.2 * y)
            )
            path.addCurve(
                to: CGPoint(x: 18.5 * x, y: 10 * y),
                control1: CGPoint(x: 14 * x, y: 6 * y),
                control2: CGPoint(x: 17.5 * x, y: 6 * y)
            )
            path.addCurve(
                to: CGPoint(x: 12 * x, y: 19 * y),
                control1: CGPoint(x: 19.5 * x, y: 13.5 * y),
                control2: CGPoint(x: 16.5 * x, y: 16 * y)
            )
        case .moon:
            path.move(to: CGPoint(x: 16 * x, y: 4 * y))
            path.addCurve(
                to: CGPoint(x: 16 * x, y: 20 * y),
                control1: CGPoint(x: 9 * x, y: 5 * y),
                control2: CGPoint(x: 8 * x, y: 18 * y)
            )
            path.addCurve(
                to: CGPoint(x: 16 * x, y: 4 * y),
                control1: CGPoint(x: 8 * x, y: 16 * y),
                control2: CGPoint(x: 9 * x, y: 7 * y)
            )
        }

        return path
    }
}

private struct MoonRecommendationsView: View {
    private let meals = [
        "赛百味", "串饼", "麦当劳", "烩面", "羊肉泡馍",
        "港式炒面", "越南米粉", "湘菜", "江西小炒"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                RiverBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 34) {
                        Text("月亮推荐")
                            .font(RiverFont.text(21, relativeTo: .title3))
                            .foregroundStyle(RiverTheme.ink)
                            .padding(.top, 18)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 18),
                                GridItem(.flexible(), spacing: 18)
                            ],
                            alignment: .leading,
                            spacing: 25
                        ) {
                            ForEach(Array(meals.enumerated()), id: \.element) { index, meal in
                                Text(meal)
                                    .font(RiverFont.text(fontSize(for: index), relativeTo: .body))
                                    .foregroundStyle(RiverTheme.ink.opacity(opacity(for: index)))
                                    .rotationEffect(.degrees(rotation(for: index)))
                                    .offset(x: offsetX(for: index), y: offsetY(for: index))
                                    .frame(maxWidth: .infinity, alignment: index.isMultiple(of: 2) ? .leading : .trailing)
                                    .padding(.vertical, 3)
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 18)
                    .padding(.bottom, 94)
                }
            }
            #if os(iOS)
            .toolbar(.hidden, for: .navigationBar)
            #endif
        }
    }

    private func fontSize(for index: Int) -> CGFloat {
        14 + CGFloat(index % 3)
    }

    private func opacity(for index: Int) -> Double {
        0.72 + Double(index % 3) * 0.08
    }

    private func rotation(for index: Int) -> Double {
        let values = [-3.5, 2.4, -1.6, 3.1, -2.2, 1.4, -2.8, 2.0, -1.0]
        return values[index % values.count]
    }

    private func offsetX(for index: Int) -> CGFloat {
        let values: [CGFloat] = [0, -10, 16, 4, -3, -16, 10, -5, 18]
        return values[index % values.count]
    }

    private func offsetY(for index: Int) -> CGFloat {
        let values: [CGFloat] = [0, 9, -4, 7, -9, 3, 11, -5, 5]
        return values[index % values.count]
    }
}
