//
//  Settings.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    private var database = RealtimeDatabase.getInstance()
    
    var body: some View {
        VStack(alignment: .leading) {
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
            
            if self.database.getCurUserName() == "" {
                ActivityIndicator(shouldAnimate: true)
            } else {
                HStack(spacing: 10){

                    Text("Name")
                        .font(.largeTitle)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()


                    Text(self.database.getCurUserName())
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
            }
            
            if self.database.getCurUserSurname() == "" {
                ActivityIndicator(shouldAnimate: true)
            } else {
                HStack(spacing: 10){

                    Text("Surname")
                        .font(.largeTitle)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()


                    Text(self.database.getCurUserSurname())
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
            }
            
            if self.database.getCurUserCountry() == "" {
                ActivityIndicator(shouldAnimate: true)
            } else {
                HStack(spacing: 10){

                    Text("Country")
                        .font(.largeTitle)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()


                    Text(self.database.getCurUserCountry())
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
            }
            
            if self.database.getCurUserUniversity() == "" {
                ActivityIndicator(shouldAnimate: true)
            } else {
                HStack(spacing: 10){

                    Text("University")
                        .font(.largeTitle)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()


                    Text(self.database.getCurUserUniversity())
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .background(Color.yellow)
        .ignoresSafeArea()
    }
}

struct ActivityIndicator: UIViewRepresentable {
    var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
