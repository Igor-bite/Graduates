//
//  Home.swift
//  Graduates
//
//  Created by Игорь Клюжев on 06.01.2021.
//

import SwiftUI

// TabItems

var tabItems = ["Новости", "Вакансии", "Чаты", "Встречи"]

struct Home : View {
    @State var index = 0
    @State var show = false
    @AppStorage("status") var logged = false
    @State var logOutAlert = false

    @State var selected = "Вакансии"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var centerX : CGFloat = 0
    
    var database = RealtimeDatabase()
    
    var body: some View {
        
        ZStack {
            Color("news2")
                .opacity(0.8)
                .ignoresSafeArea(.all)
            
            // MENU
            
            HStack{

                VStack(alignment: .leading, spacing: 12) {

                    Image(systemName: "person.circle.fill")
                        .foregroundColor(Color("green"))
                        .scaleEffect(CGSize(width: 4, height: 4))
                        .padding()

                    Text("Привет,")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    Text(self.database.getCurUserName())
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)

                    leftMenuRow(imageName: "person.crop.circle.badge.plus", title: "Заявки", rowNum: 1, show: $show, index: $index).padding(.top, 25)

                    leftMenuRow(imageName: "person.3.fill", title: "Друзья", rowNum: 2, show: $show, index: $index)

                    leftMenuRow(imageName: "gearshape", title: "Настройки", rowNum: 3, show: $show, index: $index)

                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical,30)
                        .foregroundColor(.black)

                    Button(action: {

//                        logged = false
                        
                        self.logOutAlert = true
                    }) {

                        HStack(spacing: 10){

                            Image(systemName: "clear.fill")
                                .foregroundColor(Color.red)


                            Text("Выйти")
                                .font(.headline)
                                .foregroundColor(Color.red)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 0)
                }
                .padding(.top,25)
                .padding(.horizontal,20)

                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            // MAIN VIEW
            ZStack {
                VStack(spacing: 0) {
                    TabView(selection: $selected) {
                        
                        News()
                            .tag(tabItems[0])
                           .ignoresSafeArea(.all, edges: .top)

                        Vacancies()
                            .tag(tabItems[1])
                            .ignoresSafeArea(.all, edges: .top)

                        Chat()
                            .tag(tabItems[2])
                            .ignoresSafeArea(.all, edges: .top)

                        Meetings()
                            .tag(tabItems[3])
                            .ignoresSafeArea(.all, edges: .top)
                    }

                    HStack(spacing: 0) {
                        ForEach(tabItems, id: \.self) { value in

                            GeometryReader { reader in

                                TabBarButton(selected: $selected, value: value, centerX: $centerX, rect: reader.frame(in: .global))
                                // setting First Initial Curve
                                    .onAppear(perform: {

                                        if value != tabItems.first{
                                            centerX = reader.frame(in: .global).midX
                                        }
                                    })

                            }
                            .frame(width: 70, height: 50)

                            if value != tabItems.last{
                                Spacer(minLength: 0)
                            }

                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top)
                    // For Smaller iPhones - padding 10, with notch - no padding
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(Color.white.clipShape(AnimatedShape(centerX: centerX)))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .padding(.top, -15)
                }

                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                self.show.toggle()
                            }
                        } label: {
                            if (self.show) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .padding(10)
                            } else {
                                Image(systemName: "line.horizontal.3")
                                    .foregroundColor(.black)
                                    .padding(10)
                            }
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white.opacity(0.8)))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "circle.grid.cross")
                                .foregroundColor(.black)
                                .padding(10)
                        }
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white.opacity(0.8)))
                    }
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(10)
                    .ignoresSafeArea(.all, edges: .top)
                    
                    Spacer()
                }
                
                Color.black.opacity(self.show ? 0.3 : 0)
                
            }
            .cornerRadius(UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 && !self.show ? 0 : 30)
            // Shrinking And Moving View Right Side When Menu Button Is Clicked...
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
            // Rotating Slighlty...
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
            .ignoresSafeArea(.all)
            .disabled(self.show ? true : false)
            .onTapGesture {
                if (self.show) {
                    withAnimation {
                        self.show.toggle()
                    }
                }
            }
            .alert(isPresented: $logOutAlert, content: {
                Alert(title: Text("Are you sure?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Yes"), action: {
                    logged = false
                }))
            })
        }
    }
}

struct TabBarButton : View {
    
    @Binding var selected : String
    var value: String
    @Binding var centerX : CGFloat
    var rect : CGRect
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()) {
                selected = value
                centerX = rect.midX
            }
        }, label: {
            
            VStack {
                
                Image(value)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 26, height: 26)
                    .foregroundColor(selected == value ? Color.red : .gray)
                
                Text(value)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.black)
                    .opacity(selected == value ? 1 : 0)
            }
            // Default frame from reading mid x axis from curve
            .padding(.top)
            .frame(width: 70, height: 50)
            .offset(y: selected == value ? -15 : 0)
        })
    }
}

// Custom shape

struct AnimatedShape : Shape {
    
    var centerX : CGFloat
    
//  animating path
    var animatableData: CGFloat {
        
        get{return centerX}
        set{centerX = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path {path in
            
            path.move(to: CGPoint(x: 0, y: 15))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 15))
            
            path.move(to: CGPoint(x: centerX - 35, y: 15))
            
            path.addQuadCurve(to: CGPoint(x: centerX + 35, y: 15), control: CGPoint(x: centerX, y: -30))
        }
    }
}


struct leftMenuRow : View {
    var imageName: String
    var title: String
    var rowNum: Int
    @Binding var show : Bool
    @Binding var index : Int
    @State var isPresented = false
        
    var body : some View {
        
        
//        NavigationLink(destination: Settings()) {// self.index != 1 ? (self.index == 2 ? Friends() : settings()) : Requests()) {
//            HStack(spacing: 10){
//
//                Image(systemName: imageName)
//                    .foregroundColor(self.index == self.rowNum ? Color("green") : Color.white)
//
//
//                Text(title)
//                    .foregroundColor(self.index == self.rowNum ? Color.blue : Color.white)
//            }
//            .frame(width: 120, height: 20, alignment: .leading)
//            .padding(.vertical, 10)
//            .padding(.horizontal)
//            .background(self.index == self.rowNum ? Color("green").opacity(0.2) : Color.clear)
//            .cornerRadius(10)
//        }
//        .onTapGesture {
//            self.index = self.rowNum
//
//            withAnimation{
//
//                self.show.toggle()
//            }
//        }
        
        
        Button(action: {

            self.index = self.rowNum

            withAnimation{

                self.show.toggle()
                self.isPresented.toggle()
            }

        }) {

            HStack(spacing: 10){

                Image(systemName: imageName)
                    .foregroundColor(self.index == self.rowNum ? Color("green") : Color.white)


                Text(title)
                    .foregroundColor(self.index == self.rowNum ? Color.blue : Color.white)
            }
            .frame(width: 120, height: 20, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(self.index == self.rowNum ? Color("green").opacity(0.2) : Color.clear)
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $isPresented) {
            switch(self.index) {
            case 1:
                Requests()
                
            case 2:
                Friends()
                
            case 3:
                Settings()
                
            default:
                Settings()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
