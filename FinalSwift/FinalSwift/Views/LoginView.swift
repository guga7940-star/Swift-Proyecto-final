import SwiftUI

struct LoginView: View {
    var viewModel: UserViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                // Título
                VStack(spacing: 10) {
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.blue)
                    
                    Text(isRegistering ? "Crear Cuenta" : "Iniciar Sesión")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top, 40)
                
                // Campos
                VStack(spacing: 15) {
                    TextField("Correo electrónico", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
                
                // Mensaje de Error
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                // Botón o Spinner
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button(action: {
                        Task {
                            if isRegistering {
                                await viewModel.register(email: email, password: password)
                            } else {
                                await viewModel.login(email: email, password: password)
                            }
                        }
                    }) {
                        Text(isRegistering ? "Registrarme" : "Entrar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(email.isEmpty || password.isEmpty)
                }
                
                Spacer()
                Button(action: {
                    // ⚠️ MODO DE PRUEBA: Entrar directo sin contraseña
                    viewModel.bypassLogin()
                    
                    /* CÓDIGO REAL (COMENTADO POR AHORA)
                    Task {
                        if isRegistering {
                            await viewModel.register(email: email, password: password)
                        } else {
                            await viewModel.login(email: email, password: password)
                        }
                    }
                    */
                }) {
                    Text(isRegistering ? "Registrarme" : "Entrar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                // Cambiar modo
                Button(action: {
                    withAnimation {
                        isRegistering.toggle()
                        viewModel.errorMessage = nil
                    }
                }) {
                    Text(isRegistering ? "¿Ya tienes cuenta? Inicia sesión" : "¿No tienes cuenta? Regístrate")
                        .font(.subheadline)
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(viewModel: UserViewModel())
}
