import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var authService: AuthenticationService
    @EnvironmentObject var dataService: DataService
    
    var userReadings: [BloodPressureReading] {
        guard let userId = authService.currentUser?.id else { return [] }
        return dataService.getReadings(for: userId)
    }
    
    var body: some View {
        NavigationView {
            List {
                if userReadings.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "list.bullet.clipboard")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No hay lecturas registradas")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    ForEach(userReadings) { reading in
                        ReadingRow(reading: reading)
                    }
                    .onDelete(perform: deleteReading)
                }
            }
            .navigationTitle("Historial")
        }
    }
    
    private func deleteReading(at offsets: IndexSet) {
        for index in offsets {
            dataService.deleteReading(userReadings[index])
        }
    }
}

struct ReadingRow: View {
    let reading: BloodPressureReading
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(reading.date, style: .date)
                    .font(.headline)
                Spacer()
                Text(reading.date, style: .time)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Sistólica")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(reading.systolic)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(systolicColor(reading.systolic))
                }
                
                VStack(alignment: .leading) {
                    Text("Diastólica")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(reading.diastolic)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(diastolicColor(reading.diastolic))
                }
                
                VStack(alignment: .leading) {
                    Text("Pulso")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(reading.pulse)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(.vertical, 5)
    }
    
    private func systolicColor(_ value: Int) -> Color {
        if value < 120 {
            return .green
        } else if value < 140 {
            return .orange
        } else {
            return .red
        }
    }
    
    private func diastolicColor(_ value: Int) -> Color {
        if value < 80 {
            return .green
        } else if value < 90 {
            return .orange
        } else {
            return .red
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(AuthenticationService())
            .environmentObject(DataService())
    }
}
