//
//  NewPostModel.swift
//  Graduates
//
//  Created by Игорь Клюжев on 05.01.2021.
//

import SwiftUI

class NewPostModel : ObservableObject {
    
    @Published var postTxt = ""
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    // disabling all controls while posting...
    @Published var isPosting = false
    
//    let uid = Auth.auth().currentUser!.uid
    
    func post(updateId: String, present : Binding<PresentationMode>){
        
    }
}
