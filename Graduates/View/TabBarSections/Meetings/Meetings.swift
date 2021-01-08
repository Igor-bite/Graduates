//
//  Meetings.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI

struct Meetings: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("meet1"), Color("meet2")]), startPoint: .leading, endPoint: .trailing)

            Text("Встречи")
        }
    }
}

struct Meetings_Previews: PreviewProvider {
    static var previews: some View {
        Meetings()
    }
}
