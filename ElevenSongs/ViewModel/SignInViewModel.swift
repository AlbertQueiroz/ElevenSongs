//
//  SignInViewModel.swift
//  ElevenSongs
//
//  Created by Albert on 04/09/24.
//

import Foundation

public final class SignInViewModel: ObservableObject {
    @Published public var username: String = ""
    @Published public var password: String = ""
    @Published public var isLoginSuccessful: Bool = false
    @Published public var showAlert: Bool = false

    var credentials = [
        "username": "elevenlabs",
        "password": "elevenlabs1234"
    ]

    func handleLogin() {
        if username == credentials["username"],
           password == credentials["password"] {
            isLoginSuccessful = true
            showAlert = false
        } else {
            isLoginSuccessful = false
            showAlert = true
        }
    }
}
