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
        
        ZStack {
            LinearGradient(gradient: .init(colors: [.blue, Color("green")]), startPoint: .leading, endPoint: .trailing)
            
            Text("Chat")
        }
        
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
