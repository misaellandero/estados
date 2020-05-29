//
//  CardView.swift
//  estados
//
//  Created by Francisco Misael Landero Ychante on 25/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct playButton: View {
    var body: some View {
        HStack{
            Text("Jugar")
            Image(systemName: "play.circle.fill")
        }
        .foregroundColor(.pink)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct CardView: View {

    //MARK: - PROPIEDADES
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Puntajes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Puntajes.id, ascending: true)]) var scores: FetchedResults<Puntajes>
    var granadient: [Color] = [Color(.systemPink) , Color.pink]
    var title : String
    var subtitle: String
    var image: String
    var points : Int
    var width : CGFloat
    var items : [ItemCard]
    var limit : Int
    @State private var showGameView = false
    //MARK: -CUERPO
    
    var body: some View {
            ZStack{
                VStack{
                    Text(self.title)
                        .font(.largeTitle)
                        .bold()
                    Text(self.subtitle)
                        .italic()
                    Image(self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
                    Text("Puntaje Maximo")
                    .bold()
                    Text("\(points) puntos")
                    Button(action: {
                        self.showGameView.toggle()
                    }){
                       playButton()
                    }.sheet(isPresented: $showGameView) {
                        GameView(items:self.gameArray(limit: self.limit), intentosMaximos: self.limit)
                    }
                    
                    
                }
                .padding()
                .foregroundColor(.white)
                .shadow(radius: 8)
                .background(LinearGradient(gradient: Gradient(colors: self.granadient), startPoint: .top, endPoint: .bottom) )
                .cornerRadius(16)
                .frame(width: width)
            }
    }
    func gameArray(limit: Int) -> [ItemCard] {
         let arryaGame = Array(self.items[..<limit])
        return arryaGame.shuffled()
    }
    
   
    
    func getScore() -> Int {
        var puntaje = 0
        if let score =  self.scores.first(where: { $0.id == "1" }) {
            puntaje = Int(score.puntos)
        } else {
            puntaje = 0
        }
        return puntaje
    }
}

struct CardView_Previews: PreviewProvider { 
    static var previews: some View {
        CardView(title: "Prueba", subtitle: "Prueba", image: "Prueba", points: 30, width: 100, items: [ItemCard(name: "Hidalgo", description: "Prueba", capital: "Pachuca", nombreCompleto: "Prueba")], limit: 1)
    }
}
