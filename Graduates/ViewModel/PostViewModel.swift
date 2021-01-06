//
//  PostViewModel.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI
//import Firebase

class PostViewModel : ObservableObject{
    @Published var posts : [PostModel] = []
    @Published var noPosts = false
    @Published var newPost = false
    @Published var updateId = ""
    
    init() {
        getAllPosts()
    }
    
    func getAllPosts(){
        
    }
        
    func deletePost(id: String){
        
    }
    
    func editPost(id: String){
        
    }
}
