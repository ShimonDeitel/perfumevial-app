import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Bottle] = []
    @Published var isPro: Bool = false

    static let freeLimit = 25

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("perfumevial", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Bottle) {
        guard canAddMore else { return }
        items.append(item)
        save()
    }

    func update(_ item: Bottle) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Bottle) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Bottle].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static var seedData: [Bottle] {
        [
        Bottle(id: UUID(), title: "Aventus", notes: "Bergamot, birch, ambergris", fillLevel: 0.8, occasion: "Special occasion"),
        Bottle(id: UUID(), title: "Sauvage", notes: "Citrus, ambroxan", fillLevel: 0.5, occasion: "Daily"),
        Bottle(id: UUID(), title: "Black Opium", notes: "Coffee, vanilla", fillLevel: 0.3, occasion: "Evening")
        ]
    }
}
