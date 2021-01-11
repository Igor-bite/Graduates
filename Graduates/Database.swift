//
//  Database.swift
//  Graduates
//
//  Created by Игорь Клюжев on 11.01.2021.
//

import SwiftUI
import Firebase

class RealtimeDatabase {
    
    // ToDo - реализовать паттерн одиночка
    
    var ref = Database.database().reference()
    
    var user = User()
    
    func save(model: RegisterViewModel) {
        if let user = Auth.auth().currentUser {
            self.ref.child("users").child(user.uid).setValue(["name": model.name , "surname" : model.surname , "country" : model.country , "university" : model.university])
        }
    }
    
    func getCurUserName() -> String {
        if user.name != "" {
            return self.user.name
        }
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            
            self.user.name = username
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return self.user.name
    }
}

class User {
    var name = ""
    var surname = ""
    var country = ""
    var university = ""
}
