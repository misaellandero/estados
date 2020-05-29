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
    static let gradientStart = Color(.cyan)
    static let gradientEnd = Color(.blue)
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
     @State private var WrongAnimationAmount = 0.0
     @State private var GoodAnimationAmount = 0.0
     @State private var TheOthersAnimationAmount = 1.0
    
     @State private var paises = ["Campeche",
     "Chiapas",
     "Chihuahua",
     "Ciudad de México",
     "Coahuila",
     "Colima",
     "Durango",
     "Guanajuato",
     "Guerrero",
     "Hidalgo",
     "Jalisco",
     "México",
     "Michoacán",
     "Morelos",
     "Nayarit",
     "Nuevo León",
     "Oaxaca",
     "Puebla",
     "Querétaro",
     "Quintana Roo",
     "San Luis Potosí",
     "Sinaloa",
     "Sonora",
     "Tabasco",
     "Tamaulipas",
     "Tlaxcala",
     "Veracruz",
     "Yucatán",
     "Zacatecas",
     "Aguascalientes",
     "Baja California",
     "Baja California Sur"].shuffled()
    
    @State private var respuestaCorrecta = Int.random(in: 0...2)
    @State private var mostrarPuntuajeMasAlto = false
    @State private var tituloPuntaje = ""
    @State private var textoPuntaje = ""
    @State private var puntaje = 0
    @State private var points = 3
    @State private var MaxPoints = 3
    @State private var puntajeLimite = 30
    @State private var mostrarPuntos = false
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.black
                .edgesIgnoringSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all).blur(radius: 5)
                
                VStack(spacing: 30){
                    
                    VStack {
                        Text("Elige la bandera de")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Text(self.paises[self.respuestaCorrecta])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    ForEach(0..<3){ number in
                        Button(action:{
                            self.BanderaSeleccionada(number)
                        }){
                            Bandera(imagen: self.paises[number])
                        }
                        .modifier(Shake(animatableData: CGFloat(self.WrongAnimationAmount)))
                        .buttonStyle(PlainButtonStyle())
                        .rotation3DEffect( .degrees(self.GoodAnimationAmount), axis: (x: 0, y: 1, z: 0))
                    }
                     
                               VStack {
                                       Text("Tu Puntaje es ")
                                           .foregroundColor(.white)
                                           .font(.largeTitle)
                                Text("\(self.puntaje) puntos")
                                           .foregroundColor(.white)
                                           .font(.largeTitle)
                                           .fontWeight(.black)
                               }
                                       
                                }
                if self.mostrarPuntos {
                
                    ZStack{
                                Badge()
                                VStack{
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
                                        }
                                      
                                    }
                                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.8)
                                     Text("Correcta")
                                        .font(.largeTitle)
                                        .bold()
                                    Button(action: {
                                        self.hacerPregunta()
                                        self.mostrarPuntos.toggle()
                                    }){
                                        HStack{
                                            Text("Siguiente")
                                            Image(systemName: "play.circle.fill")
                                        }
                                        .foregroundColor(.blue)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                                .foregroundColor(.white)
                               
                            }
                            .shadow(color: .black, radius: 1)
                    
                }
               
            }
        }
        .alert(isPresented: $mostrarPuntuajeMasAlto){
                   Alert(title: Text(tituloPuntaje), message: Text("\(textoPuntaje) tu puntaje es \(self.puntaje)"), dismissButton:.default(Text("Continuar")){
                       
                            self.hacerPregunta()
                       })
                   
                   
               }
        
       
    }
    func BanderaSeleccionada(_ numero: Int)  {
        
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
            textoPuntaje = "Has elegido \(paises[numero])"
            
        }
        
       
    }
    
    func hacerPregunta(){
            self.points = 3
            self.paises.shuffle()
            self.GoodAnimationAmount = 0
            self.WrongAnimationAmount = 0
            self.TheOthersAnimationAmount = 1.0
            respuestaCorrecta = Int.random(in: 0...2)
        
    }
}

 

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
