import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject private var store: MealStore
    @State private var isWobbling = false
    @State private var shakeAmount: CGFloat = 0

    private var meals: [MealOption] { MealLibrary.all }

    var body: some View {
        NavigationStack {
            ZStack {
                RiverBackground()

                GeometryReader { proxy in
                    ZStack {
                        ForEach(Array(meals.enumerated()), id: \.element.id) { index, meal in
                            FoodSnowballWord(
                                meal: meal,
                                index: index,
                                isExcluded: store.excludedCategories.contains(meal.category),
                                isWobbling: isWobbling,
                                shakeAmount: shakeAmount,
                                size: proxy.size
                            ) {
                                toggle(meal.category)
                            }
                        }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .contentShape(Rectangle())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 18)
            }
            #if os(iOS)
            .toolbar(.hidden, for: .navigationBar)
            #endif
            .onAppear {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    isWobbling = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShake)) { _ in
                withAnimation(.spring(response: 0.42, dampingFraction: 0.48)) {
                    shakeAmount += 1
                }
            }
        }
    }

    private func toggle(_ category: MealCategory) {
        if store.excludedCategories.contains(category) {
            store.excludedCategories.remove(category)
        } else {
            store.excludedCategories.insert(category)
        }
        store.drawSuggestions()
    }
}

private struct FoodSnowballWord: View {
    let meal: MealOption
    let index: Int
    let isExcluded: Bool
    let isWobbling: Bool
    let shakeAmount: CGFloat
    let size: CGSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(meal.name)
                .font(RiverFont.text(fontSize, relativeTo: .caption))
                .foregroundStyle(isExcluded ? RiverTheme.ink.opacity(0.38) : RiverTheme.ink.opacity(opacity))
                .rotationEffect(.degrees(rotation + (isWobbling ? wobble : -wobble)))
                .offset(
                    x: (isWobbling ? drift : -drift) + shakeOffset.width,
                    y: shakeOffset.height
                )
                .padding(.horizontal, 2)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .position(position)
        .animation(.easeInOut(duration: duration).repeatForever(autoreverses: true), value: isWobbling)
        .accessibilityLabel("\(meal.name)，\(isExcluded ? "已暂时不推荐" : "正在推荐")")
    }

    private var position: CGPoint {
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        let circleRadius = min(size.width * 0.43, size.height * 0.34)
        let angle = Double(index) * 2.399963229728653
        let radius = sqrt((Double(index) + 0.5) / Double(max(1, MealLibrary.all.count)))
        let jitterX = normalized(seed: index * 31 + 7) * 10
        let jitterY = normalized(seed: index * 29 + 13) * 10

        return CGPoint(
            x: center.x + cos(angle) * circleRadius * radius + jitterX,
            y: center.y + sin(angle) * circleRadius * radius + jitterY
        )
    }

    private var fontSize: CGFloat {
        8.5 + CGFloat(abs((index * 17) % 4))
    }

    private var rotation: Double {
        normalized(seed: index * 19 + 3) * 18
    }

    private var wobble: Double {
        1.4 + Double(index % 4) * 0.32
    }

    private var drift: CGFloat {
        CGFloat(1.6 + Double(index % 5) * 0.52)
    }

    private var duration: Double {
        1.55 + Double(index % 6) * 0.18
    }

    private var opacity: Double {
        0.74 + Double(index % 5) * 0.05
    }

    private var shakeOffset: CGSize {
        guard shakeAmount > 0 else { return .zero }
        let phase = Double(shakeAmount)
        return CGSize(
            width: normalized(seed: index * 43 + Int(phase) * 11) * 24,
            height: normalized(seed: index * 47 + Int(phase) * 13) * 18
        )
    }

    private func normalized(seed: Int) -> Double {
        let value = sin(Double(seed) * 12.9898) * 43758.5453
        return (value - floor(value)) * 2 - 1
    }
}

#if os(iOS)
private extension Notification.Name {
    static let deviceDidShake = Notification.Name("deviceDidShake")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        guard motion == .motionShake else { return }
        NotificationCenter.default.post(name: .deviceDidShake, object: nil)
    }
}
#endif
