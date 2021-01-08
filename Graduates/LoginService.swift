//
//  LoginService.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI
import Firebase

class LoginService {    
    func makeNewUserWith(model: LoginViewModel) {
        Auth.auth().createUser(withEmail: model.email, password: model.password) { (res, err) in
            
            model.isLoading = false
            
            if let error = err {
                model.alertMsg = error.localizedDescription
                model.alert.toggle()
                return
            }
            
            // Success
            
            // Else Goto Home...
            
            withAnimation{model.logged = true}
        }
    }
    
    func verifyUser(model: LoginViewModel) {
        Auth.auth().signIn(withEmail: model.email, password: model.password) { (res, err) in
            
            model.isLoading = false
            
            if let error = err{
                model.alertMsg = error.localizedDescription
                model.alert.toggle()
                return
            }
            
            // Success
            
            // Promoting User For Save data or not...
            
            if model.Stored_User == "" || model.Stored_Password == ""{
                model.store_Info.toggle()
                return
            }
            
            // Else Goto Home...
            
            withAnimation{model.logged = true}
        }
    }
    
    func forgotPassword() {
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "status")
    }
}
