import Foundation

enum MealCategory: String, Codable, CaseIterable, Identifiable {
    case chinese = "中餐"
    case noodles = "面与粉"
    case japanese = "日料"
    case korean = "韩餐"
    case southeastAsian = "东南亚"
    case western = "西餐"
    case light = "清淡"
    case quick = "快速解决"

    var id: String { rawValue }
}

enum MealMood: String, Codable, CaseIterable, Identifiable {
    case anything = "随机"
    case comforting = "热的"
    case spicy = "辣的"
    case dry = "干的"
    case soup = "汤的"
    case light = "清淡"

    var id: String { rawValue }
}

struct MealOption: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let category: MealCategory
    let note: String
    let symbol: String
    let moods: Set<MealMood>
    let price: Int

    init(_ name: String, _ category: MealCategory, _ note: String, _ symbol: String, _ moods: Set<MealMood>, _ price: Int) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.note = note
        self.symbol = symbol
        self.moods = moods
        self.price = price
    }
}

enum MealReaction: String, Codable, CaseIterable {
    case loved = "很好吃"
    case okay = "还可以"
    case skip = "下次不要"
}

struct MealMemory: Identifiable, Codable {
    let id: UUID
    let meal: MealOption
    let date: Date
    var reaction: MealReaction?
    var note: String
    var imageData: Data?
}
