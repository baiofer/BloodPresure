import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var username = ""
    @State private var password = ""
    @State private var showingRegister = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .padding(.bottom, 30)
                
                Text("Monitor de Tensión Arterial")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    TextField("Usuario", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                Button(action: login) {
                    Text("Iniciar Sesión")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Button(action: { showingRegister = true }) {
                    Text("¿No tienes cuenta? Regístrate")
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $showingRegister) {
                RegisterView()
                    .environmentObject(authService)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func login() {
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Por favor, completa todos los campos"
            showAlert = true
            return
        }
        
        if authService.login(username: username, password: password) {
            // Login successful
        } else {
            alertMessage = "Usuario o contraseña incorrectos"
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationService())
    }
}
