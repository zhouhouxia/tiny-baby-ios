import SwiftUI

@main
struct MealCompanionApp: App {
    @StateObject private var store = MealStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                #if os(macOS)
                .frame(minWidth: 430, minHeight: 780)
                #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
