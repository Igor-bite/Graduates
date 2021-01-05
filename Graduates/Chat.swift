//
//  Chat.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI

struct Chat: View {
//    @StateObject var homeData = HomeModel()
    @AppStorage("current_user") var user = ""
    @State var scrolled = false
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                
                Text("Мессенджер")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
//            .background(Color.blue)
            
            ScrollViewReader{reader in
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
