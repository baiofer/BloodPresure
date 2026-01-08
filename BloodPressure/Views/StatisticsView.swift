import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var authService: AuthenticationService
    @EnvironmentObject var dataService: DataService
    
    var userReadings: [BloodPressureReading] {
        guard let userId = authService.currentUser?.id else { return [] }
        return dataService.getReadings(for: userId)
    }
    
    var averageSystolic: Double {
        guard !userReadings.isEmpty else { return 0 }
        return Double(userReadings.map { $0.systolic }.reduce(0, +)) / Double(userReadings.count)
    }
    
    var averageDiastolic: Double {
        guard !userReadings.isEmpty else { return 0 }
        return Double(userReadings.map { $0.diastolic }.reduce(0, +)) / Double(userReadings.count)
    }
    
    var averagePulse: Double {
        guard !userReadings.isEmpty else { return 0 }
        return Double(userReadings.map { $0.pulse }.reduce(0, +)) / Double(userReadings.count)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if userReadings.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "chart.bar")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                            Text("No hay datos para mostrar")
                                .foregroundColor(.secondary)
                        }
                    } else {
                        VStack(spacing: 15) {
                            StatCard(
                                title: "Promedio Sistólica",
                                value: String(format: "%.0f", averageSystolic),
                                unit: "mmHg",
                                color: .red,
                                icon: "arrow.up.circle.fill"
                            )
                            
                            StatCard(
                                title: "Promedio Diastólica",
                                value: String(format: "%.0f", averageDiastolic),
                                unit: "mmHg",
                                color: .blue,
                                icon: "arrow.down.circle.fill"
                            )
                            
                            StatCard(
                                title: "Promedio Pulso",
                                value: String(format: "%.0f", averagePulse),
                                unit: "lpm",
                                color: .green,
                                icon: "heart.fill"
                            )
                            
                            HStack {
                                Text("Total de lecturas:")
                                    .font(.headline)
                                Spacer()
                                Text("\(userReadings.count)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Estadísticas")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let unit: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            
            HStack(alignment: .lastTextBaseline) {
                Text(value)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(color)
                Text(unit)
                    .font(.title3)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .environmentObject(AuthenticationService())
            .environmentObject(DataService())
    }
}
