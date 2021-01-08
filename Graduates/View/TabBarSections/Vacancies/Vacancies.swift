//
//  Vacancies.swift
//  Graduates
//
//  Created by Игорь Клюжев on 03.11.2020.
//

import SwiftUI

struct Vacancies: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("vac1"), Color("vac2")]), startPoint: .leading, endPoint: .trailing)

            Text("Вакансии")
        }
    }
}

struct Vacancies_Previews: PreviewProvider {
    static var previews: some View {
        Vacancies()
    }
}
