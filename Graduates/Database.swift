//
//  Database.swift
//  Graduates
//
//  Created by Игорь Клюжев on 11.01.2021.
//

import SwiftUI
import Firebase

class RealtimeDatabase {
    private static var instance: RealtimeDatabase?
    
    private var ref : DatabaseReference

    private init() {
        ref = Database.database().reference()
    }
    
    static func getInstance() -> RealtimeDatabase {
        if let database = RealtimeDatabase.instance {
            return database
        } else {
            RealtimeDatabase.instance = RealtimeDatabase()
            return RealtimeDatabase.instance!
        }
    }
    
    private var user = User()
    
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
    
    func getCurUserSurname() -> String {
        if user.surname != "" {
            return self.user.surname
        }
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let surname = value?["surname"] as? String ?? ""
            
            self.user.surname = surname
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return self.user.surname
    }
    
    func getCurUserCountry() -> String {
        if user.country != "" {
            return self.user.country
        }
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let country = value?["country"] as? String ?? ""
            
            self.user.country = country
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return self.user.country
    }
    
    func getCurUserUniversity() -> String {
        if user.university != "" {
            return self.user.university
        }
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let university = value?["university"] as? String ?? ""
            
            self.user.university = university
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return self.user.university
    }
    
    func clearAll() {
        user.clear()
    }
}

class User {
    var name = ""
    var surname = ""
    var country = ""
    var university = ""
    
    func clear() {
        name = ""
        surname = ""
        country = ""
        university = ""
    }
}
