import Foundation

@MainActor
final class MealStore: ObservableObject {
    @Published var suggestions: [MealOption] = []
    @Published var selectedMood: MealMood = .anything
    @Published var maximumPrice = 80
    @Published var selectedMeal: MealOption?
    @Published var memories: [MealMemory] = []
    @Published var excludedCategories: Set<MealCategory> = []

    private let memoriesKey = "meal-companion.memories.v1"

    init() {
        load()
        drawSuggestions()
    }

    func drawSuggestions() {
        let recentNames = Set(memories.prefix(8).map(\.meal.name))
        var pool = MealLibrary.all.filter {
            $0.price <= maximumPrice &&
            !excludedCategories.contains($0.category) &&
            !recentNames.contains($0.name) &&
            (selectedMood == .anything || $0.moods.contains(selectedMood))
        }

        if pool.count < 3 {
            pool = MealLibrary.all.filter { $0.price <= maximumPrice && !excludedCategories.contains($0.category) }
        }

        var result: [MealOption] = []
        for category in pool.map(\.category).shuffled() where result.count < 3 {
            guard !result.contains(where: { $0.category == category }),
                  let choice = pool.filter({ $0.category == category }).randomElement() else { continue }
            result.append(choice)
        }
        if result.count < 3 {
            result += pool.filter { !result.contains($0) }.shuffled().prefix(3 - result.count)
        }
        suggestions = result
    }

    func choose(_ meal: MealOption) {
        selectedMeal = meal
    }

    func saveMeal(reaction: MealReaction?, note: String, imageData: Data?) {
        guard let selectedMeal else { return }
        memories.insert(MealMemory(id: UUID(), meal: selectedMeal, date: .now, reaction: reaction, note: note, imageData: imageData), at: 0)
        self.selectedMeal = nil
        persist()
        drawSuggestions()
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(memories) {
            UserDefaults.standard.set(data, forKey: memoriesKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: memoriesKey),
              let decoded = try? JSONDecoder().decode([MealMemory].self, from: data) else { return }
        memories = decoded
    }
}
