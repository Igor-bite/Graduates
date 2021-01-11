//
//  Register.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI

struct Register : View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var RegisterModel = RegisterViewModel()
    
    @State var startAnimate = false
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                Spacer(minLength: 0)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //Dynamic Frame...
                    .padding(.horizontal,35)
                    .padding(.vertical)
                Spacer()
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please sign up if you don't have an account")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
                
                ScrollView(.vertical, showsIndicators: true) {
                    registrationField(title: "NAME", imageName: "textbox", isSecure: false, RegisterModelProperty: $RegisterModel.name)
                    registrationField(title: "SURNAME", imageName: "textbox", isSecure: false, RegisterModelProperty: $RegisterModel.surname)
                    registrationField(title: "COUNTRY", imageName: "globe", isSecure: false, RegisterModelProperty: $RegisterModel.country)
                    registrationField(title: "UNIVERSITY", imageName: "studentdesk", isSecure: false, RegisterModelProperty: $RegisterModel.university)

                    registrationField(title: "EMAIL", imageName: "envelope", isSecure: false, RegisterModelProperty: $RegisterModel.email)
                    registrationField(title: "PASSWORD", imageName: "lock", isSecure: true, RegisterModelProperty: $RegisterModel.password)
                    registrationField(title: "REPEAT PASSWORD", imageName: "lock", isSecure: true, RegisterModelProperty: $RegisterModel.passwordAgain)
                }
                
                HStack(spacing: 15){
                    
                    Button(action: RegisterModel.register, label: {
                        Text("SIGN UP")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(RegisterModel.isFull() ? 1 : 0.5)
                    .disabled(RegisterModel.isFull() ? false : true)
                    .alert(isPresented: $RegisterModel.alert, content: {
                        Alert(title: Text("Error"), message: Text(RegisterModel.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })

                }
                .padding(.top)
                
                HStack(spacing: 5){
                    Text("Already have an account?")
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Login")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("green"))
                    })
                }
                .padding(.vertical)
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .animation(startAnimate ? .easeOut : .none)
            
            if RegisterModel.isLoading{

                Loading_Screen()
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startAnimate.toggle()
            }
        })
    }
}

struct registrationField : View {
    var title: String
    var imageName: String
    var isSecure: Bool
    @Binding var RegisterModelProperty: String
    
    var body: some View {
        HStack{
            
            Image(systemName: imageName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 35)
            
            if isSecure {
                SecureField(title, text: $RegisterModelProperty)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
            } else {
                TextField(title, text: $RegisterModelProperty)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(RegisterModelProperty == "" ? 0 : 0.12))
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top)
    }
}
