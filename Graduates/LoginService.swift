//
//  LoginService.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI
import Firebase

class LoginService {
    let database = RealtimeDatabase.getInstance()
    
    func makeNewUserWith(model: RegisterViewModel) {
        if !model.arePasswordsSame() {
            model.isLoading = false
            model.alertMsg = "Passwords are different. Try again"
            model.alert.toggle()
            return
        }
        
        Auth.auth().createUser(withEmail: model.email, password: model.password) { [self] (res, err) in
            
            model.isLoading = false
            
            if let error = err {
                model.alertMsg = error.localizedDescription
                model.alert.toggle()
                return
            }
            
            // Success
            
            database.save(model: model)
            
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
            } else {
                print(model.Stored_User)
                print(model.Stored_Password)
            }
            
            // Else Goto Home...
            
            withAnimation{model.logged = true}
        }
    }
    
    func forgotPassword() {
    }
    
    func logOut() {
        database.clearAll()
        UserDefaults.standard.set(false, forKey: "status")
    }
}
