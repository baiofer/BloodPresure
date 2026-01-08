import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authService: AuthenticationService
    @StateObject private var dataService = DataService()
    
    var body: some View {
        TabView {
            ReadingInputView()
                .environmentObject(authService)
                .environmentObject(dataService)
                .tabItem {
                    Label("Registrar", systemImage: "plus.circle.fill")
                }
            
            HistoryView()
                .environmentObject(authService)
                .environmentObject(dataService)
                .tabItem {
                    Label("Historial", systemImage: "list.bullet")
                }
            
            StatisticsView()
                .environmentObject(authService)
                .environmentObject(dataService)
                .tabItem {
                    Label("Estadísticas", systemImage: "chart.bar.fill")
                }
            
            SettingsView()
                .environmentObject(authService)
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthenticationService())
    }
}
