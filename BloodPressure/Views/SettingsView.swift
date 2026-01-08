import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Usuario")) {
                    HStack {
                        Text("Nombre de usuario")
                        Spacer()
                        Text(authService.currentUser?.username ?? "")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Información")) {
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("Acerca de")
                        }
                    }
                    
                    NavigationLink(destination: GuidelinesView()) {
                        HStack {
                            Image(systemName: "book")
                            Text("Guía de Valores")
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square")
                            Text("Cerrar Sesión")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Ajustes")
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Cerrar Sesión"),
                    message: Text("¿Estás seguro de que deseas cerrar sesión?"),
                    primaryButton: .destructive(Text("Cerrar Sesión")) {
                        authService.logout()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Monitor de Tensión Arterial")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Versión 1.0")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Esta aplicación te permite registrar y monitorear tus lecturas de presión arterial de manera sencilla.")
                    .padding(.top, 10)
                
                Text("Características:")
                    .font(.headline)
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("• Registro de 3 lecturas con cálculo automático de la media")
                    Text("• Historial completo de mediciones")
                    Text("• Estadísticas de tus valores")
                    Text("• Sistema de inicio de sesión seguro")
                }
                .padding(.leading, 10)
            }
            .padding()
        }
        .navigationTitle("Acerca de")
    }
}

struct GuidelinesView: View {
    var body: some View {
        List {
            Section(header: Text("Presión Arterial Sistólica")) {
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Text("Normal: < 120 mmHg")
                }
                HStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 10, height: 10)
                    Text("Elevada: 120-139 mmHg")
                }
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                    Text("Alta: ≥ 140 mmHg")
                }
            }
            
            Section(header: Text("Presión Arterial Diastólica")) {
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Text("Normal: < 80 mmHg")
                }
                HStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 10, height: 10)
                    Text("Elevada: 80-89 mmHg")
                }
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                    Text("Alta: ≥ 90 mmHg")
                }
            }
            
            Section(header: Text("Recomendaciones")) {
                Text("• Toma tus lecturas a la misma hora cada día")
                Text("• Descansa 5 minutos antes de medir")
                Text("• No consumas cafeína 30 minutos antes")
                Text("• Siéntate con la espalda apoyada")
                Text("• Mantén el brazo a la altura del corazón")
            }
        }
        .navigationTitle("Guía de Valores")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthenticationService())
    }
}
