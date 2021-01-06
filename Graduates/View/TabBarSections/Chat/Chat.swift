//
//  Chat.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI

struct Chat: View {
    @AppStorage("status") var logged = true
    var body: some View {
//        Text("Chat")
        
        Button("Log Out") {
            logged = false
        }
        .padding()
        .foregroundColor(Color.white)
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
