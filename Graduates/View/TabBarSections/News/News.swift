//
//  News.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI

struct News: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("news1"), Color("news2")]), startPoint: .leading, endPoint: .trailing)

            Text("News")
        }
    }
}

