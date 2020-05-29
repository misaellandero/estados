//
//  GameView.swift
//  estados
//
//  Created by Francisco Misael Landero Ychante on 24/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI
struct HexagonParameters {
    struct Segment {
        let useWidth: (CGFloat, CGFloat, CGFloat)
        let xFactors: (CGFloat, CGFloat, CGFloat)
        let useHeight: (CGFloat, CGFloat, CGFloat)
        let yFactors: (CGFloat, CGFloat, CGFloat)
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let points = [
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.60, 0.40, 0.50),
            useHeight: (1.00, 1.00, 0.00),
            yFactors:  (0.05, 0.05, 0.00)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 0.00),
            xFactors:  (0.05, 0.00, 0.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.20 + adjustment, 0.30 + adjustment, 0.25 + adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 0.00),
            xFactors:  (0.00, 0.05, 0.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.70 - adjustment, 0.80 - adjustment, 0.75 - adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.40, 0.60, 0.50),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.95, 0.95, 1.00)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.95, 1.00, 1.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.80 - adjustment, 0.70 - adjustment, 0.75 - adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (1.00, 0.95, 1.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.30 + adjustment, 0.20 + adjustment, 0.25 + adjustment)
        )
    ]
}
struct Badge: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: xOffset + width * 0.95,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                HexagonParameters.points.forEach {
                    path.addLine(
                        to: .init(
                            x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                            y: height * $0.useHeight.0 * $0.yFactors.0
                        )
                    )
                    
                    path.addQuadCurve(
                        to: .init(
                            x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                            y: height * $0.useHeight.1 * $0.yFactors.1
                        ),
                        control: .init(
                            x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                            y: height * $0.useHeight.2 * $0.yFactors.2
                        )
                    )
                }
            }
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
        }
    }
    static let gradientStart = Color(.systemPink)
    static let gradientEnd = Color(.systemRed)
}


struct Bandera: View{
    var animationAmount = 0.0
    var imagen : String
    var body: some View{
        Image(imagen)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black, radius: 1)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

 
struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var WrongAnimationAmount = 0.0
    @State private var GoodAnimationAmount = 0.0
    @State private var TheOthersAnimationAmount = 1.0
    @State public var items : [ItemCard]
    @State private var respuestaCorrecta = Int.random(in: 0...2)
    @State private var mostrarPuntuajeMasAlto = false
    @State private var tituloPuntaje = ""
    @State private var textoPuntaje = ""
    @State private var puntaje = 0
    @State private var points = 3
    @State private var MaxPoints = 3
    @State public  var intentosMaximos : Int
    @State private var intentos = 0
    @State private var mostrarPuntos = false
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.black
                .edgesIgnoringSafeArea(.all)
                BackGround(width: 400)
                .blur(radius: 5)
                .accessibility(label: self.mostrarPuntos ? Text("Respuesta correcta obtuviste \(self.points == 1 ? "un punto" : "\(self.points) puntos") ") : Text("Elije la bandera de \(self.items[self.respuestaCorrecta].nombreCompleto)"))
                
                VStack(spacing: 30){
                    
                    VStack {
                        
                        Text("Elige la bandera de")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Text(self.items[self.respuestaCorrecta].nombreCompleto)
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.black)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(value: Text("Elige la bandera de \(self.items[self.respuestaCorrecta].name)"))
                    
                    ForEach(0..<3){ number in
                        Button(action:{
                            self.BanderaSeleccionada(number)
                        }){
                            Bandera(imagen: self.items[number].name)
                        }
                        .modifier(Shake(animatableData: CGFloat(self.WrongAnimationAmount)))
                        .buttonStyle(PlainButtonStyle())
                        .rotation3DEffect( .degrees(self.GoodAnimationAmount), axis: (x: 0, y: 1, z: 0))
                        .accessibility(label: Text(self.items[number].description))
                    }
                     
                               VStack {
                                       Text("Tu Puntaje total es ")
                                           .foregroundColor(.white)
                                           .font(.largeTitle)
                                Text("\(self.puntaje) puntos")
                                           .foregroundColor(.white)
                                           .font(.largeTitle)
                                           .fontWeight(.black)
                               }
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("Tu Puntaje total es \(self.puntaje == 1 ? "un punto" : "\(self.puntaje) puntos") "))
                    
                }
                .blur(radius: self.mostrarPuntos ? 10: 0)
                .disabled(self.mostrarPuntos)
                if self.mostrarPuntos {
                    ZStack{
                        Badge()
                            .frame(width: 400, height: 400)
                        VStack{
                                    Group{
                                        Text("Respuesta")
                                                                           .font(.largeTitle)
                                                                           HStack{
                                                                               ForEach(0..<self.points) { point in
                                                                                   Image(systemName: "star.fill")
                                                                                   .resizable()
                                                                                   .aspectRatio(contentMode: .fit)
                                                                               }
                                                                               ForEach(0..<(self.MaxPoints - self.points)) { point in
                                                                                   Image(systemName: "star")
                                                                                   .resizable()
                                                                                   .aspectRatio(contentMode: .fit)
                                                                                       .accessibility(removeTraits: .isImage )
                                                                               }.accessibility(label: Text("\(self.points == 1 ? "Una Estrella" : "\(self.points) estrellas")"))
                                                                               
                                                                             
                                                                           }
                                                                           .frame(width: min(geometry.size.width, geometry.size.height) * 0.8)
                                                                            Text("Correcta")
                                                                               .font(.largeTitle)
                                                                               .bold()
                                    }.accessibility(label: Text("Respuesta correcta obtuviste \(self.points == 1 ? "un punto" : "\(self.points) puntos") "))
                                   
                                    
                                    Button(action: {
                                        self.hacerPregunta()
                                        self.mostrarPuntos.toggle()
                                    }){
                                        HStack{
                                            Text("Siguiente")
                                            Image(systemName: "play.circle.fill")
                                        }
                                        .foregroundColor(.pink)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                    .accessibility(label: Text("Continuar Juego"))
                                }
                        .foregroundColor(.white)
                       
                    }
                    .shadow(color: .black, radius: 1)
                    
                }
                
                VStack{
                    HStack{
                        Button(action : {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            ButtonCancel()
                        }.accessibility(label: Text("Salir del juego"))
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .layoutPriority(1)
            }
            
        }
        .alert(isPresented: $mostrarPuntuajeMasAlto){
                   Alert(title: Text(tituloPuntaje), message: Text("\(textoPuntaje) Tu puntaje fue \(self.puntaje)"), dismissButton:.default(Text("Continuar")){
                    
                        self.presentationMode.wrappedValue.dismiss()
                    
                       })
                   
                   
               }
        
       
    }
    
    func BanderaSeleccionada(_ numero: Int)  {
         
        if intentos >= intentosMaximos {
         mostrarPuntuajeMasAlto.toggle()
         return
        } else {
            self.intentos +=  1
        }
        
        if numero == respuestaCorrecta{
            tituloPuntaje = "Respuesta correcta"
            textoPuntaje = "¡Bien Hecho!"
            self.puntaje += self.points
           
            self.GoodAnimationAmount += 360
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                                 self.GoodAnimationAmount += 360
            }
            
            withAnimation {
                self.TheOthersAnimationAmount -= 0.75
                self.mostrarPuntos.toggle()
            }
        
           
        }else{
           
            withAnimation{
                self.WrongAnimationAmount += 4
                if self.points > 0 {
                    self.points -= 1
                }
                
            }
           
            tituloPuntaje = "Respuesta incorrecta"
            textoPuntaje = "Has elegido \(self.items[numero].name)"
            
        }
        
       
    }
    
    func hacerPregunta(){
            self.points = 3
            self.items.shuffle()
            self.GoodAnimationAmount = 0
            self.WrongAnimationAmount = 0
            self.TheOthersAnimationAmount = 1.0
            respuestaCorrecta = Int.random(in: 0...2)
        
    }
}

 

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(items: [ItemCard(name: "Hidalgo", description: "Prueba", capital: "Pachuca", nombreCompleto: "Demo")], intentosMaximos: 1)
    }
}
