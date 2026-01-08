import Foundation

struct BloodPressureReading: Codable, Identifiable {
    let id: UUID
    let systolic: Int
    let diastolic: Int
    let pulse: Int
    let date: Date
    let userId: UUID
    
    init(id: UUID = UUID(), systolic: Int, diastolic: Int, pulse: Int, date: Date = Date(), userId: UUID) {
        self.id = id
        self.systolic = systolic
        self.diastolic = diastolic
        self.pulse = pulse
        self.date = date
        self.userId = userId
    }
}

struct Reading: Identifiable {
    let id = UUID()
    var systolic: String = ""
    var diastolic: String = ""
    var pulse: String = ""
    var time: Date = Date()
}
