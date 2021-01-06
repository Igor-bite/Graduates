//
//  Register.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI

struct Register : View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var LoginModel = LoginViewModel()
    
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
                
                HStack{
                    
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("EMAIL", text: $LoginModel.email)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack{
                    
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    SecureField("PASSWORD", text: $LoginModel.password)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    
                    Button(action: LoginModel.addLikeNewUser, label: {
                        Text("SIGN UP")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(LoginModel.email != "" && LoginModel.password != "" ? 1 : 0.5)
                    .disabled(LoginModel.email != "" && LoginModel.password != "" ? false : true)
                    .alert(isPresented: $LoginModel.alert, content: {
                        Alert(title: Text("Error"), message: Text(LoginModel.alertMsg), dismissButton: .destructive(Text("Ok")))
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
            
            if LoginModel.isLoading{

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
