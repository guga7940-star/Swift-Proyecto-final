import SwiftUI

struct LoginView: View {
    var viewModel: UserViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    
    let valRed = Color(red: 1.0, green: 0.275, blue: 0.333)
    let valDark = Color(red: 0.06, green: 0.1, blue: 0.14)
    let valText = Color(red: 0.925, green: 0.91, blue: 0.882)
    
    var body: some View {
        NavigationStack {
            ZStack {
                valDark.ignoresSafeArea()
                
                VStack {
                    Divider().background(Color.white.opacity(0.1))
                    Spacer()
                    Divider().background(Color.white.opacity(0.1))
                }
                
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/100px-Valorant_logo_-_pink_color_version.svg.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    // Efecto de sombra roja brillante
                                    .shadow(color: valRed.opacity(0.8), radius: 10, x: 0, y: 0)
                            } else {
                                Image(systemName: "shield.fill")
                                    .resizable()
                                    .frame(width: 60, height: 70)
                                    .foregroundStyle(valRed)
                            }
                        }
                        
                        Text(isRegistering ? "NUEVO AGENTE" : "INICIAR MISIÓN")
                            .font(.system(size: 30, weight: .heavy, design: .default))
                            .textCase(.uppercase)
                            .foregroundStyle(.white)
                            .tracking(2)
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(valRed)
                            TextField("", text: $email, prompt: Text("CORREO").foregroundColor(.gray))
                                .foregroundStyle(.white)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .overlay(
                            Rectangle()
                                .stroke(email.isEmpty ? Color.gray.opacity(0.3) : valRed, lineWidth: 1)
                        )
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(valRed)
                            SecureField("", text: $password, prompt: Text("CONTRASEÑA").foregroundColor(.gray))
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .overlay(
                            Rectangle()
                                .stroke(password.isEmpty ? Color.gray.opacity(0.3) : valRed, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    if let errorMessage = viewModel.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text(errorMessage)
                        }
                        .foregroundStyle(valRed)
                        .font(.caption.bold())
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(valRed)
                            .scaleEffect(1.5)
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
                            Text(isRegistering ? "REGISTRARSE" : "ENTRAR")
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(valRed)
                                .foregroundColor(.white)
                                .cornerRadius(4) // Bordes casi rectos
                                .shadow(color: valRed.opacity(0.4), radius: 5, x: 0, y: 5)
                        }
                        .padding(.horizontal)
                        .disabled(email.isEmpty || password.isEmpty)
                        .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isRegistering.toggle()
                            viewModel.errorMessage = nil
                        }
                    }) {
                        Text(isRegistering ? "¿YA TIENES CUENTA? // ACCEDER" : "¿NO TIENES CUENTA? // RECLUTAR")
                            .font(.caption.bold())
                            .foregroundStyle(.white.opacity(0.7))
                            .padding(.bottom, 30)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView(viewModel: UserViewModel())
}
