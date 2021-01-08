//
//  ContentView.swift
//  Graduates
//
//  Created by Игорь Клюжев on 02.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack {
            if logged {
                Home()
            } else {
                Login()
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

