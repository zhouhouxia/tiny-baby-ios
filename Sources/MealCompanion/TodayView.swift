import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var store: MealStore
    @State private var showRecordSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                RiverBackground()

                VStack(spacing: 0) {
                    header

                    Spacer(minLength: 58)

                    Text("TODAY'S PICK")
                        .font(RiverFont.accent(13, relativeTo: .caption))
                        .tracking(1.2)
                        .foregroundStyle(RiverTheme.moss)
                        .frame(maxWidth: 280, alignment: .leading)
                        .padding(.bottom, 14)

                    if let primary = store.suggestions.first {
                        primaryPick(primary)
                    }

                    candidatePicks
                        .padding(.top, 15)

                    Spacer(minLength: 28)

                    randomButton

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 8)
            }
            #if os(iOS)
            .toolbar(.hidden, for: .navigationBar)
            #endif
            .sheet(isPresented: $showRecordSheet) { MealRecordView() }
            .onChange(of: store.selectedMeal) { _, value in
                if value != nil { showRecordSheet = true }
            }
        }
    }

    private var header: some View {
        HStack {
            Text(shortEnglishDate)
                .font(RiverFont.accent(14, relativeTo: .subheadline))
                .tracking(1.1)

            Spacer()
        }
        .foregroundStyle(RiverTheme.ink)
        .padding(.top, 18)
    }

    private var shortEnglishDate: String {
        Date.now
            .formatted(
                .dateTime
                    .locale(Locale(identifier: "en_US"))
                    .weekday(.abbreviated)
                    .month(.abbreviated)
                    .day()
            )
            .uppercased()
    }

    private func primaryPick(_ meal: MealOption) -> some View {
        Button {
            store.choose(meal)
        } label: {
            ZStack {
                Capsule()
                    .stroke(RiverTheme.ink, lineWidth: 1)

                Capsule()
                    .inset(by: 8)
                    .stroke(RiverTheme.ink.opacity(0.26), lineWidth: 1)
                    .rotationEffect(.degrees(-2.4))

                Text(meal.name)
                    .font(RiverFont.text(20, relativeTo: .title3))
                    .tracking(0.8)
                    .foregroundStyle(RiverTheme.ink)
                    .padding(.horizontal, 32)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: 280)
            .frame(height: 190)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("今天推荐：\(meal.name)")
    }

    private var candidatePicks: some View {
        HStack(spacing: 16) {
            ForEach(Array(store.suggestions.dropFirst().prefix(2))) { meal in
                Button(meal.name) {
                    store.choose(meal)
                }
                .font(RiverFont.text(13, relativeTo: .caption))
                .foregroundStyle(RiverTheme.moss)
                .buttonStyle(.plain)

                if meal.id != store.suggestions.dropFirst().prefix(2).last?.id {
                    Text("·")
                        .foregroundStyle(RiverTheme.ink)
                }
            }
        }
        .frame(minHeight: 36)
    }

    private var randomButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.32)) {
                store.drawSuggestions()
            }
        } label: {
            HStack(spacing: 8) {
                Text("random")
                    .font(RiverFont.accent(17))
                    .tracking(1.1)
                Text("🕹️")
                    .font(.system(size: 17))
            }
            .foregroundStyle(RiverTheme.ink)
            .padding(.vertical, 12)
            .padding(.horizontal, 18)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("重新抽取三个推荐")
    }
}
