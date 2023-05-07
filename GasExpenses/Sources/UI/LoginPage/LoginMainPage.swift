//
//  LoginPage.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct LoginMainPage: View {

    let loginService: JWTService

    @State var userCredentials: User = .init(username: "",
                                             password: "",
                                             email: "")
    @State var shouldRemmemberUser: Bool = false
    @State var isLoading: Bool = false
    @State var shouldShowAlert: Bool = false
    @State var errorMessage: LocalizedStringKey = ""
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
                    .tint(.ui.action)
            } else {
                VStack {
                    TitleAndIconHeaderView<EmptyView>(title: "login")
                    Spacer()
                    TitleAndTextField(title: "login",
                                      textFieldValue: $userCredentials.username)
                    TitleAndSecureField(title: "password",
                                      textFieldValue: $userCredentials.password)
                    Toggle("remmember.me", isOn: $shouldRemmemberUser)
                        .tint(.ui.action)

                    Spacer()

                    ButtonPrimary {
                        Text("login")
                    } action: {
                        onLogin()
                    }

                    .tint(.ui.action)
                    .buttonStyle(.borderedProminent)

                    NavigationLink(destination: SignupPage()) {
                        Text("sign.up")
                    }
                    .tint(.ui.action)
                }
                .alert(errorMessage, isPresented: $shouldShowAlert, actions: {
                    Button("ok") {}
                })
                .padding()
            }
        }
        .onAppear {
            do {
                if let rememberedUserData = UserDefaults.standard.data(forKey: "user.credentials") {
                    let rememberedUser = try JSONDecoder().decode(User.self, from: rememberedUserData)
                    userCredentials = rememberedUser
                    onLogin()
                }
            } catch {

            }
        }
    }

    private func onLogin() {
        Task {
            do {
                isLoading = true
                userManager.user = userCredentials
                _ = try await AccessTokenManager.shared.getJWTToken()
                if shouldRemmemberUser {
                    try remmemberUser()
                }
                isLoading = false
                userManager.isUserLoggedIn = true
            } catch {
                handleError(error)
            }
        }
    }

    private func remmemberUser() throws {
        let data = try JSONEncoder().encode(userCredentials)
        UserDefaults.standard.set(data, forKey: "user.credentials")
    }

    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkEngineError {
            switch networkError {
            case .decodeError:
                errorMessage = "error.generic"
            case .unauthorized:
                errorMessage = "error.unauthorized"
            case .notFound:
                errorMessage = "error.notfound"
            case .serverUnavailable:
                errorMessage = "error.server.unvailable"
            case .other:
                errorMessage = "error.generic"
            }
        } else {
            errorMessage = "error.generic"
        }

        shouldShowAlert = true
        isLoading = false
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginMainPage(loginService: JWTService())
    }
}
