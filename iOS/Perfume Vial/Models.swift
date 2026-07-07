import Foundation

struct Bottle: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var notes: String
    var fillLevel: Double
    var occasion: String
}
