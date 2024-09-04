//
//  SignInView.swift
//  ElevenSongs
//
//  Created by Albert on 04/09/24.
//
import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel

    public init(viewModel: SignInViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Image(.emptyState)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 164)
                    .padding(.bottom, 24)
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.bold)
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                    .padding(.bottom, 20)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                    .padding(.bottom, 20)

                Button(action: {
                    viewModel.handleLogin()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(5)
                }
                NavigationLink(
                    destination: TabBarView(),
                    isActive: $viewModel.isLoginSuccessful
                ) {
                    EmptyView()
                }
            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("Invalid username or password. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    SignInView()
}
