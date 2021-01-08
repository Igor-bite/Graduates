//
//  Settings.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .font(.headline)
                }.padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white.opacity(0.8)))
                
                Spacer()
                
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(10)
            .ignoresSafeArea(.all, edges: .top)
            
            Spacer()
            
            Text("Settings")
            
            Spacer()
        }
        .background(Color.yellow)
        .ignoresSafeArea()
    }
}
