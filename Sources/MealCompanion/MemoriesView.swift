import SwiftUI

struct MemoriesView: View {
    @EnvironmentObject private var store: MealStore

    var body: some View {
        NavigationStack {
            ZStack {
                RiverBackground()
                if store.memories.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 28, weight: .ultraLight))
                        Text("还没有吃饭记忆")
                            .font(RiverFont.text(18, relativeTo: .headline))
                        Text("选定一餐后，它会慢慢出现在这里。")
                            .font(RiverFont.text(14, relativeTo: .subheadline))
                            .foregroundStyle(RiverTheme.moss)
                    }
                    .foregroundStyle(RiverTheme.ink)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 14) {
                            ForEach(store.memories) { memory in
                                HStack(spacing: 14) {
                                    mealImage(memory)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(memory.meal.name).font(RiverFont.text(18, relativeTo: .headline)).foregroundStyle(RiverTheme.ink)
                                        Text(memory.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(RiverFont.accent(13, relativeTo: .caption)).foregroundStyle(RiverTheme.ink.opacity(0.58))
                                        if let reaction = memory.reaction {
                                            Text(reaction.rawValue).font(RiverFont.text(15, relativeTo: .subheadline)).foregroundStyle(RiverTheme.moss)
                                        }
                                        if !memory.note.isEmpty { Text(memory.note).font(RiverFont.text(15, relativeTo: .subheadline)).foregroundStyle(RiverTheme.ink.opacity(0.66)) }
                                    }
                                    Spacer()
                                }
                                .padding(14)
                                .overlay(alignment: .bottom) { Divider() }
                            }
                        }
                        .padding(20)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("吃过的")
                        .font(RiverFont.text(17, relativeTo: .headline))
                        .foregroundStyle(RiverTheme.ink)
                }
            }
        }
    }

    @ViewBuilder
    private func mealImage(_ memory: MealMemory) -> some View {
        if let data = memory.imageData {
            #if os(iOS)
            if let image = UIImage(data: data) {
                Image(uiImage: image).resizable().scaledToFill().frame(width: 76, height: 76).clipShape(RoundedRectangle(cornerRadius: 17))
            } else { placeholder(memory) }
            #else
            if let image = NSImage(data: data) {
                Image(nsImage: image).resizable().scaledToFill().frame(width: 76, height: 76).clipShape(RoundedRectangle(cornerRadius: 17))
            } else { placeholder(memory) }
            #endif
        } else { placeholder(memory) }
    }

    private func placeholder(_ memory: MealMemory) -> some View {
        RoundedRectangle(cornerRadius: 17)
            .fill(RiverTheme.mist)
            .frame(width: 76, height: 76)
            .overlay(Image(systemName: memory.meal.symbol).foregroundStyle(RiverTheme.moss))
    }
}
