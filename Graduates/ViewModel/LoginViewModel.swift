//
//  LoginViewModel.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI
import LocalAuthentication
import Firebase

class LoginViewModel : ObservableObject {
    var loginService = LoginService()
    
    @Published var email = ""
    @Published var password = ""
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Data....
    
    @AppStorage("stored_User") var Stored_User = ""
    
    @AppStorage("stored_Password") var Stored_Password = ""
    
    @AppStorage("status") var logged = false
    
    @Published var store_Info = false
    
    // Loading Screen...
    @Published var isLoading = false
    
    // Getting BioMetricType....
    
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        var error: NSError?
                
        if email != "" && email == Stored_User && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            return true
        } else {
            print(error?.localizedDescription)
        }
    
        return false
    }
    
    // authenticate User...
    
    func authenticateUser(){
        
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(email)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            // Settig User Password And Logging IN...
            DispatchQueue.main.async {
                self.password = self.Stored_Password
                self.verifyUser()
            }
        }
    }
    
    // Verifying User...
    
    func verifyUser(){
        isLoading = true
        loginService.verifyUser(model: self)
    }
    
    func addLikeNewUser(){
        isLoading = true
        loginService.makeNewUserWith(model: self)
    }
}

