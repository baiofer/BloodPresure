import Foundation
import SwiftUI

class ReadingViewModel: ObservableObject {
    @Published var readings: [Reading] = [Reading(), Reading(), Reading()]
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    // Validation constants for blood pressure readings
    private enum ValidationLimits {
        static let systolicMin = 40      // Minimum viable systolic pressure
        static let systolicMax = 300     // Maximum measurement range
        static let diastolicMin = 30     // Minimum viable diastolic pressure
        static let diastolicMax = 200    // Maximum measurement range
        static let pulseMin = 20         // Minimum viable pulse
        static let pulseMax = 250        // Maximum measurement range
    }
    
    func calculateAverage() -> (systolic: Int, diastolic: Int, pulse: Int)? {
        var validReadings: [(systolic: Int, diastolic: Int, pulse: Int)] = []
        
        for reading in readings {
            guard let systolic = Int(reading.systolic),
                  let diastolic = Int(reading.diastolic),
                  let pulse = Int(reading.pulse),
                  systolic >= ValidationLimits.systolicMin && systolic <= ValidationLimits.systolicMax,
                  diastolic >= ValidationLimits.diastolicMin && diastolic <= ValidationLimits.diastolicMax,
                  pulse >= ValidationLimits.pulseMin && pulse <= ValidationLimits.pulseMax else {
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
