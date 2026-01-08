import Foundation

class DataService: ObservableObject {
    @Published var readings: [BloodPressureReading] = []
    
    private let readingsKey = "bloodPressureReadings"
    
    init() {
        loadReadings()
    }
    
    func saveReading(_ reading: BloodPressureReading) {
        readings.insert(reading, at: 0)
        saveReadings()
    }
    
    func getReadings(for userId: UUID) -> [BloodPressureReading] {
        return readings.filter { $0.userId == userId }
    }
    
    func deleteReading(_ reading: BloodPressureReading) {
        readings.removeAll { $0.id == reading.id }
        saveReadings()
    }
    
    private func loadReadings() {
        guard let data = UserDefaults.standard.data(forKey: readingsKey),
              let savedReadings = try? JSONDecoder().decode([BloodPressureReading].self, from: data) else {
            return
        }
        readings = savedReadings
    }
    
    private func saveReadings() {
        if let data = try? JSONEncoder().encode(readings) {
            UserDefaults.standard.set(data, forKey: readingsKey)
        }
    }
}
