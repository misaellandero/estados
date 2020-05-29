//
//  ReferenceView.swift
//  estados
//
//  Created by Francisco Misael Landero Ychante on 15/05/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct ItemCard: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var capital : String
    var nombreCompleto : String
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct imageCard : View {
    var SVwidth : CGFloat
    var itemHeigth : CGFloat
    var name : String
    var body: some View{
        Image(name)
        .resizable()
        .scaledToFill()
        .clipped()
        .background(Color.white)
    }
}

struct cardButton: View {
    var name : String
    var capital: String
    var description: String
    var SVwidth : CGFloat
    var body: some View{
        ZStack{
            VStack{
                VisualEffectView(effect: UIBlurEffect(style: .extraLight))
                    .frame(height: SVwidth * 0.25)
                Spacer()
            }
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text(capital.uppercased())
                            .font(.body)
                            .foregroundColor(.black)
                        Text(name)
                            .font(.title)
                            .foregroundColor(.black)
                            .bold()
                    }
                    .padding()
                    
                    Spacer()
                }
                Spacer()
               
                    HStack{
                        VStack(alignment: .leading){
                          Text(description)
                            .lineLimit(2)
                            .font(.body)
                            .foregroundColor(.white)
                        }
                        .padding()
                        Spacer()
                    }
            
                
            }.frame(width: self.SVwidth)
        }
        
    }
}

struct Header: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Republica Méxicana")
                    .font(.footnote)
                    .foregroundColor(.white)
                Text("Estados")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
            Spacer()
        }
    .padding()
    }
}

struct ReferenceView: View {
    
    @State var expendedItem = ItemCard( name: "Demo", description: "Demo", capital: "Demo", nombreCompleto: "Demo")
    
    var items : [ItemCard]
    let itemHeigth: CGFloat =  500
    let imageHeigth : CGFloat = 500
    
    let SVwidth = UIScreen.main.bounds.width - 40
    
    
    @State var extendedScreen_start_point = CGRect(x:0, y: 0, width: 100, height: 100)
    @State var extendedScreen_return_point = CGRect(x:0, y: 0, width: 100, height: 100)
    @State var extendedScreen_show = false
    @State var extendedScreen_willHide = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                BackGround(width: 400)
                ScrollView{
                       
                    //Titulo
                    Header()
                    
                    // Inicio Tajetas
                    ForEach(self.items, id: \.id) { item in
                        GeometryReader{
                            geo -> AnyView in
                            return AnyView(
                                ZStack{
                                    /*Color(.white)
                                    .frame(width: self.SVwidth + 10, height: self.itemHeigth)*/
                                    
                                    imageCard(SVwidth: geometry.size.width - 40, itemHeigth: self.imageHeigth, name: item.name)
                                    .frame(width: geometry.size.width - 40 , height: self.itemHeigth)
                                    
                                    LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                    
                            
                                    Button(action: {
                                        self.expendedItem = item
                                        
                                        // corregir el alto en sheet
                                        let globaly = geometry.frame(in: .global).minY
                                        
                                        let x = geo.frame(in: .global).minX
                                        let y = geo.frame(in:  .global).minY
                                        
                                        
                                
                                        let thisRect = CGRect(x: x, y: y - globaly , width: geometry.size.width - 40, height: self.itemHeigth)
                                        self.extendedScreen_start_point = thisRect
                                        self.extendedScreen_return_point = thisRect
                                        
                                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ (timer) in
                                            self.extendedScreen_show = true
                                            self.extendedScreen_start_point = CGRect(x: 0, y: 0, width: geometry.size.width , height: geometry.size.height)
                                            
                                        }
                                        
                                    }){
                                        cardButton(name: item.nombreCompleto  , capital: item.name , description: item.description, SVwidth: geometry.size.width - 40)
                                    }
                                
                                }
                                .cornerRadius(15)
                                .shadow(radius: 11, x: 0, y:4)
                            )
                        }
                        .frame(height: self.itemHeigth)
                        .padding(20)
                        //.padding(.leading)
                        //.padding(.trailing)
                    }
                    
                    // Fin Tarjetas
                     
                    
                }
                .layoutPriority(1)
                .blur(radius: self.extendedScreen_show ? 50 : 0)
                
                GeometryReader{geo -> AnyView in
                    let item = self.expendedItem
                    
                    return AnyView(
                    
                        ZStack{
                            ScrollView{
                                VStack(spacing:0){
                                    ZStack{
                                        /*Color(.white)
                                        .frame(width: self.SVwidth + 10, height: self.itemHeigth)*/
                                        
                                        imageCard(SVwidth: geometry.size.width - 40, itemHeigth: self.itemHeigth, name: item.name)
                                         .frame(width: self.extendedScreen_show ? UIScreen.main.bounds.width : geometry.size.width - 40, height: self.itemHeigth)
                                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                        .animation(Animation.easeInOut(duration: 0.1))
                                       
                                    ZStack{
                                    VStack{
                                        VisualEffectView(effect: UIBlurEffect(style: .extraLight))
                                            .frame(height: (geometry.size.width - 40) * 0.25)
                                            .opacity(self.extendedScreen_show ? 0.0 : 1.0)
                                        .animation(Animation.easeInOut(duration: 0.6))
                                        Spacer()
                                    }
                                        VStack{
                                            HStack{
                                                VStack(alignment: .leading){
                                                    
                                                    Text(item.name.uppercased())
                                                        .font(self.extendedScreen_show ?  .title :  .body)
                                                        .foregroundColor(.black)
                                                    Text(item.nombreCompleto)
                                                        .font(self.extendedScreen_show ? .largeTitle : .title)
                                                        .foregroundColor(.black)
                                                        .bold()
                                                }
                                                .padding()
                                                
                                                Spacer()
                                            }
                                            .offset(y:self.extendedScreen_show ? 44: 0)
                                            Spacer()
                                            HStack{
                                                VStack(alignment: .leading){
                                                  Text(item.description)
                                                    .lineLimit(2)
                                                    .font(.body)
                                                    .foregroundColor(.white)
                                                }
                                                .padding()
                                                Spacer()
                                            }
                                            
                                        }.frame(width: self.extendedScreen_start_point.width)
                                    }
                                    }
                                    .frame(height: self.itemHeigth)
                                    .zIndex(1)
                                    .animation(Animation.easeInOut(duration: 0.6))
                                    
                                    if self.extendedScreen_show {
                                        ZStack{
                                            VisualEffectView(effect: UIBlurEffect(style: .extraLight))
                                            .frame(minHeight: self.extendedScreen_show ? geometry.size.height : 0)
                                            
                                            VStack{
                                                Spacer()
                                                Text("Capital")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                Text(item.capital)
                                                    .font(.title)
                                                    .foregroundColor(.gray)
                                                
                                                
                                                Group{
                                                   
                                                    HStack{
                                                       Text(item.description)
                                                        .foregroundColor(.black)
                                                    }
                                                    
                                                    Image(item.name)
                                                          .resizable()
                                                          .scaledToFit()
                                                          .cornerRadius(20)
                                                            .frame(width: geometry.size.width - 40, height: self.itemHeigth)
                                                    
                                                    
                                                    
                                                }.padding()
                                                 
                                               
                                                Spacer()
                                            }
                                            
                                        }
                                        .animation(Animation.easeInOut(duration: 0.6))
                                    }
                                    
                                    
                                        
                                
                                    
                                   
                                }
                            .cornerRadius(self.extendedScreen_show ? 0 : 5 )
                                
                                
                            }
                            .frame(width: self.extendedScreen_start_point.width, height: self.extendedScreen_start_point.height)
                            .background(Color.clear)
                            .cornerRadius(self.extendedScreen_show ? 0 : 15 )
                            .animation(.easeInOut(duration: self.extendedScreen_show ? 0.3 : 0.3))
                            .offset(x: self.extendedScreen_start_point.minX, y: self.extendedScreen_start_point.minY)
                            .layoutPriority(1)
                            
                           
                            
                        VStack{
                                HStack{
                                    Spacer()
                                    Button(action:{
                                        self.extendedScreen_willHide = true
                                        self.extendedScreen_start_point = self.extendedScreen_return_point
                                        
                                        self.extendedScreen_show = false
                                        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false){
                                            (timer) in
                                            self.extendedScreen_willHide = false
                                        }
                                        
                                    }){
                                        
                                            Image(systemName:"xmark.circle.fill")
                                                .font(.title)
                                                .foregroundColor(.black)
                                                .padding()
                                                //.transition(.opacity)
                                                //.opacity(self.extendedScreen_show ? 1 : 0.0)
                                    }
                                    .offset(x: self.extendedScreen_show ? 0: -10, y:self.extendedScreen_show ? 0: 100 )
                                    .opacity(self.extendedScreen_show ? 1.0 : 0.0)
                                    .animation(Animation.easeInOut(duration: 0.3))
                                }
                                Spacer()
                            }
                            .padding()}
                    )
                }
                .edgesIgnoringSafeArea(.top)
                .opacity(self.extendedScreen_show ? 1 : 0.0)
                .animation(
                Animation.easeInOut(duration: 0.10)
                    .delay(self.extendedScreen_willHide ? 0.5 : 0 )
                )
                if !self.extendedScreen_show {
                    VStack{
                        HStack{
                            Spacer()
                            Button(action : {
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                ButtonCancel()
                            }.accessibility(label: Text("Salir del juego"))
                            .transition(.scale)
                        }
                        Spacer()
                    }
                    .padding()
                    .layoutPriority(1)
                }
                
            }
        }
        
    }
}

struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView( items: [ItemCard(name: "Hidalgo", description: "Prueba", capital: "Pachuca", nombreCompleto: "Demo")])
    }
}
