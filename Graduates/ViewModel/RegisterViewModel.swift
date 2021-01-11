//
//  RegisterViewModel.swift
//  Graduates
//
//  Created by Игорь Клюжев on 11.01.2021.
//

import SwiftUI
import LocalAuthentication
import Firebase

class RegisterViewModel : ObservableObject {
    var loginService = LoginService()
    
    @Published var name = ""
    @Published var surname = ""
    @Published var country = ""
    @Published var university = ""
//    @Published var language = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Data....
    
    @AppStorage("status") var logged = false
    
    @Published var store_Info = false
    
    // Loading Screen...
    @Published var isLoading = false
    
    // Verifying User...
    
    func register(){
        isLoading = true
        loginService.makeNewUserWith(model: self)
    }
    
    func isFull() -> Bool {
        if (name != "" && surname != "" && country != "" && university != "" && email != "" && password != "" && passwordAgain != "") {
            
            return true
        }
        return false
    }
    
    func arePasswordsSame() -> Bool {
        if password == passwordAgain {
            return true
        }
        
        return false
    }
}


