import SwiftUI
import PhotosUI

struct MealRecordView: View {
    @EnvironmentObject private var store: MealStore
    @Environment(\.dismiss) private var dismiss
    @State private var reaction: MealReaction?
    @State private var note = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var showPhotoPicker = false

    var body: some View {
        NavigationStack {
            ZStack {
                RiverBackground()
                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        if let meal = store.selectedMeal {
                            Text("就吃这个")
                                .font(RiverFont.text(15, relativeTo: .subheadline))
                                .foregroundStyle(RiverTheme.moss)
                            Text(meal.name)
                                .font(RiverFont.text(34, relativeTo: .largeTitle))
                                .foregroundStyle(RiverTheme.ink)
                            Text("吃完拍一张，留给今天。")
                                .font(RiverFont.text(15, relativeTo: .subheadline))
                                .foregroundStyle(RiverTheme.ink.opacity(0.62))
                        }

                        Button {
                            showPhotoPicker = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 26)
                                    .fill(RiverTheme.card)
                                    .frame(height: 230)
                                MealPhotoPreview(data: imageData)
                            }
                        }
                        .buttonStyle(.plain)
                        .photosPicker(isPresented: $showPhotoPicker, selection: $photoItem, matching: .images)
                        .onChange(of: photoItem) { _, item in
                            Task { imageData = try? await item?.loadTransferable(type: Data.self) }
                        }

                        HStack(spacing: 8) {
                            ForEach(MealReaction.allCases, id: \.self) { item in
                                Button(item.rawValue) { reaction = item }
                                    .font(RiverFont.text(15, relativeTo: .subheadline))
                                    .foregroundStyle(RiverTheme.ink)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .overlay(alignment: .bottom) {
                                        Rectangle()
                                            .fill(reaction == item ? RiverTheme.ink : Color.clear)
                                            .frame(height: 1)
                                    }
                            }
                        }

                        TextField("留一句话，也可以空着", text: $note, axis: .vertical)
                            .font(RiverFont.text(15, relativeTo: .body))
                            .foregroundStyle(RiverTheme.ink)
                            .padding(15)
                            .overlay(alignment: .bottom) { Divider() }

                        Button("记住这一餐") {
                            store.saveMeal(reaction: reaction, note: note, imageData: imageData)
                            dismiss()
                        }
                        .font(RiverFont.text(17))
                        .foregroundStyle(RiverTheme.ink)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .overlay(alignment: .bottom) { Divider() }
                    }
                    .padding(22)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("稍后再说")
                            .font(RiverFont.text(15, relativeTo: .subheadline))
                            .foregroundStyle(RiverTheme.ink)
                    }
                }
            }
        }
    }
}

private struct MealPhotoPreview: View {
    let data: Data?

    var body: some View {
        if let data {
            #if os(iOS)
            if let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
            #else
            if let image = NSImage(data: data) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
            }
            #endif
        } else {
            VStack(spacing: 10) {
                Image(systemName: "camera")
                    .font(RiverFont.text(34, relativeTo: .largeTitle))
                Text("拍下或选择这一餐")
                    .font(RiverFont.text(15, relativeTo: .subheadline))
            }
            .foregroundStyle(RiverTheme.moss)
        }
    }
}
