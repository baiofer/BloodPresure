import SwiftUI

struct ReadingInputView: View {
    @EnvironmentObject var authService: AuthenticationService
    @EnvironmentObject var dataService: DataService
    @StateObject private var viewModel = ReadingViewModel()
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Introduce 3 lecturas de presión arterial")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    
                    ForEach(Array(viewModel.readings.enumerated()), id: \.element.id) { index, reading in
                        ReadingCard(reading: binding(for: index), number: index + 1)
                    }
                    
                    Button(action: saveReadings) {
                        Text("Guardar Media")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Button(action: {
                        viewModel.resetReadings()
                    }) {
                        Text("Limpiar")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Registro de Presión")
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func binding(for index: Int) -> Binding<Reading> {
        Binding(
            get: { viewModel.readings[index] },
            set: { viewModel.readings[index] = $0 }
        )
    }
    
    private func saveReadings() {
        guard let average = viewModel.calculateAverage() else {
            alertTitle = "Error"
            alertMessage = "Por favor, introduce las 3 lecturas con valores válidos"
            showAlert = true
            return
        }
        
        guard let userId = authService.currentUser?.id else {
            alertTitle = "Error"
            alertMessage = "No se pudo identificar al usuario"
            showAlert = true
            return
        }
        
        let reading = BloodPressureReading(
            systolic: average.systolic,
            diastolic: average.diastolic,
            pulse: average.pulse,
            userId: userId
        )
        
        dataService.saveReading(reading)
        
        alertTitle = "Éxito"
        alertMessage = "Lectura guardada exitosamente\n\nMedia:\nSistólica: \(average.systolic) mmHg\nDiastólica: \(average.diastolic) mmHg\nPulso: \(average.pulse) lpm"
        showAlert = true
        
        viewModel.resetReadings()
    }
}

struct ReadingCard: View {
    @Binding var reading: Reading
    let number: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Lectura \(number)")
                    .font(.headline)
                Spacer()
                Text(reading.time, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Sistólica")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("120", text: $reading.systolic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    Text("Diastólica")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("80", text: $reading.diastolic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    Text("Pulso")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("70", text: $reading.pulse)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .onAppear {
            reading.time = Date()
        }
    }
}

struct ReadingInputView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingInputView()
            .environmentObject(AuthenticationService())
            .environmentObject(DataService())
    }
}
