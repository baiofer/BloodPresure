import Foundation
import SwiftUI

class ReadingViewModel: ObservableObject {
    @Published var readings: [Reading] = [Reading(), Reading(), Reading()]
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func calculateAverage() -> (systolic: Int, diastolic: Int, pulse: Int)? {
        var validReadings: [(systolic: Int, diastolic: Int, pulse: Int)] = []
        
        for reading in readings {
            guard let systolic = Int(reading.systolic),
                  let diastolic = Int(reading.diastolic),
                  let pulse = Int(reading.pulse),
                  systolic > 0 && systolic < 300,
                  diastolic > 0 && diastolic < 200,
                  pulse > 0 && pulse < 250 else {
                continue
            }
            validReadings.append((systolic, diastolic, pulse))
        }
        
        guard validReadings.count == 3 else {
            return nil
        }
        
        let avgSystolic = validReadings.map { $0.systolic }.reduce(0, +) / 3
        let avgDiastolic = validReadings.map { $0.diastolic }.reduce(0, +) / 3
        let avgPulse = validReadings.map { $0.pulse }.reduce(0, +) / 3
        
        return (avgSystolic, avgDiastolic, avgPulse)
    }
    
    func resetReadings() {
        readings = [Reading(), Reading(), Reading()]
    }
}
