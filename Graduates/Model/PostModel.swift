//
//  PostModel.swift
//  Graduates
//
//  Created by Игорь Клюжев on 05.01.2021.
//

import SwiftUI

struct PostModel: Identifiable {
    var id: String
    var title : String
    var pic: String
    var time : Date
    var user: UserModel
}
