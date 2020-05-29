//
//  ContentView.swift
//  estados
//
//  Created by Francisco Misael Landero Ychante on 24/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct ButtonCancel: View {
    var body: some View {
         Image(systemName: "xmark")
        .padding()
        .opacity(0.8)
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .background(Color.black.opacity(0.4).blur(radius: 10))
        .cornerRadius(50)
        
    }
}

struct cardsView: View {
    var width : CGFloat
    var items : [ItemCard]
    var body: some View{
        
            ScrollView(.horizontal) {
                HStack(spacing: 30) {
                    
                    CardView(title: "Nivel 1", subtitle: "10 estados", image: "estados3", points: 30, width: width * 0.7, items: self.items, limit: 10)
                        .padding()
                    CardView(title: "Nivel 2", subtitle: "20 estados", image: "estados2", points: 30, width: width * 0.7, items: self.items, limit: 20 )
                        .padding()
                    CardView(title: "Nivel 3", subtitle: "32 estados", image: "estados1", points: 30, width: width * 0.7 , items: self.items, limit: 32 )
                        .padding()
                     
                }
                .padding()
            }
       
    }
}

struct BackGround: View {
   
    var width : CGFloat
    
    var body: some View {
        ZStack{
            Color.black
                       .edgesIgnoringSafeArea(.all)
                   
                   LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                       .edgesIgnoringSafeArea(.all)
                       .blur(radius: 5)
                   
                   Image("escudos")
                       .resizable()
                       .scaledToFill()
                       .edgesIgnoringSafeArea(.all)
                       .frame(width: width * 2.3)
                       .opacity(0.05)
                       .rotationEffect(.degrees(-20))
        }
        .accessibility(removeTraits: .isImage)
    }
}

struct ContentView: View {
    @State private var showhingRefernce = false
    var items : [ItemCard] = [
        
        ItemCard( name: "Camp", description : "Escudo con corona española, dividido en cuatro partes, arriba a la izquierda un castillo con tres torres, arriba a la derecha un barco con tres velas, abajo a la izquierda otro castillo con tres torres, arriba a la derecha otro barco con tres velas.", capital : "San Francisco de Campeche", nombreCompleto: "Campeche"),
                               
        ItemCard(name: "Chih", description : "Escudo gótico que termina en punta, dividido en tres secciones, arriba tres cerros que dominan el paisaje de la capital que son El Coronel, Santa Rosa y Grande  baja de ellos unas minas, una sección de un acueducto y un árbol de mezquite. En el centro un mosaico de 8 piezas de color plata y 8 rojos que representan los votos empatados a favor de fundar la ciudad capital, sobre el mosaico un conquistador viendo de frente a un indio tarahumara. Abajo una el frente de una catedral. Con el lema Valentía, Lealtad, Hospitalidad", capital : "Chihuahua" ,nombreCompleto: "Chihuahua"),
        
        ItemCard(name: "CDMX", description : "Escudo con un castillo de tres puentes, con león al lado izquierdo y otro al lado derecho, todo de oro y al rededor en el borde diez hojas de tuna o nopales.", capital : "No aplica", nombreCompleto: "Ciudad de México"),
        
        ItemCard(name: "Coah", description : "Escudo de pergamino,  dividido en tres partes arriba a la izquierda un pobre con dos lobos, arriba a la derecha un león  apoyado en un pilar con la frase Más Arriba o Más Allá, abajo un bosque de nogales acompañado de un sol y un rio.", capital : "Saltillo",nombreCompleto: "Coahuila de Zaragoza"),
        
        ItemCard(name: "Col", description : "Escudo con yelmo, en el centro un brazo doblado, con la mano torcida y agua en el hombro. A los lados adornado por serpientes, y jaguares apoyados sobre caracoles marinos y en medio una palmera y los volcanes de colina. Con el lema el temple del brazo es vigor en la tierra.", capital : "Colima", nombreCompleto : "Colima" ),
        
        
        ItemCard(name: "Dgo", description : "Escudo de pergamino con corona española, en el centro un árbol de roble con muchas hojas y dos lobos corriendo, dos rama de palma a cada lado formado una guirnalda y abajo un moño rojo.", capital : "Victoria de Durango", nombreCompleto : "Durango" ),
        
        ItemCard(name: "Gto", description : "Escudo con corona española, una mujer de planta con los ojos vendados levantando un copa de oro, y una hostia arriba y en la otra mano una cruz y una rama de laurel.", capital : "Guanajuato" ,nombreCompleto : "Guanajuato"),
        
        ItemCard(name: "Gro", description : "Escudo con un penacho, en el centro un guerrero Caballero Jaguar vestido de oro con un escudo con plumas y una macana de color madera.", capital : "Chilpancingo de los Bravo",nombreCompleto : "Guerrero"),
        
        ItemCard(name: "Hgo", description : "Escudo con dos banderas, dividido en tres partes,  la bandera de izquierda una imagen de la virgen de Guadalupe representando la usada por hidalgo en la independencia, del lado derecho la bandera nacional,  arriba a la izquierda una campana arria a la derecha un gorro rojo adornado con laureles, en el centro una montaña abajo  un tambo de guerra y frente a el tres minas.", capital : "Pachuca de Soto",nombreCompleto : "Hidalgo"),
        
        ItemCard(name: "Jal", description: "Escudo con yelmo, en el centro un pino con las raíces expuestas, sobre el pino se apoyan dos leones, el escudo esta decorado con plumas de color oro bandera en la punta del yelmo con la cruz de Jerusalén. ", capital : "Guadalajara" ,nombreCompleto : "Jalisco"),
        
        ItemCard(name: "Méx", description : "Escudo con el escudo nacional, dividido en tres partes, arriba a la izquierda un volcán y la pirámide del sol, arriba a la derecha representación de la batalla del mont de las cruces, abajo surcos d e agricultura y sobre ellos un libro y arroba del libro un pico, una hoz, un pico, una pala y un matraz, y abajo 18 abejas. con el lema Patria, Libertad, Trabajo y Cultura.", capital : "Toluca de Lerdo", nombreCompleto : "México"),
        
        ItemCard(name: "Mich", description : "Escudo con jeroglífico nahuatl de pescadores, divido en 4 partes, arriba izquierda un jinete en su caballo que representa a Jose Maria méreles y pavón, arriba a la izquierda tres coronas indigenas de oro regias.  Abajo a la izquierda un engrane una fabrica y al fondo un  mar, abajo a la derecha un libro abierto, al fondo la universidad de Tiripetio. Con el lema Heredamos libertad, Legaremos justicia social.", capital : "Morelia", nombreCompleto : "Michoacán de Ocampo"),
        
        ItemCard(name: "Mor", description : "Escudo con una terraza de la que crece una mata de maíz arria una estrella y en medio un lema que dice Tierra y Libertad. Con el lema La tierra es de quienes la trabajan con sus manos.", capital : "Cuernavaca", nombreCompleto : "Morelos"),
        
        ItemCard(name: "Nay", description : "Escudo dividido en tres partes con un agita en la cima, arriba a la izquierda una caña dorada de maíz, arriba a la derecha un arco y flecha , abajo una montaña. Y en el centro escudo mas pequeño con siete huellas de pies, y en el centro un águila.", capital : "Tepic", nombreCompleto : "Nayarit"),
        
        ItemCard(name: "NL", description : "Escudo con yelmo dividido en cuatro partes arriba a la izquierda el cerro de la silla con un sol y un naranjo, arriba a la izquierda un león rojo con una corona, abajo a la izquierda el antiguo templo de San Francisco, abajo a la derecha una fabrica con siete chimeneas, en el centro una cadena, arriba tres abejas doradas de cada lado y al pie una cinta con los colores nacionales y el lema Siempre Ascendiendo.", capital : "Monterrey", nombreCompleto : "Nuevo León"),
        
        ItemCard(name: "Oax", description : "Escudo de pergamino con el escudo nacional, dividido en un ovalo de tres partes, arriba a la izquierda el perfil de un indígena con la flor y fruto del árbol de huaje, arriba a la derecha el perfil de uno de los palacios del centro arqueológico de milla y a su derecha la cruz dominicana, abajo dos brazos rompiendo unas cadenas. Al rededor del borde siete estrellas doradas, con el lema EL RESPETO AL DERECHO AJENO ES LA PAZ", capital : "Oaxaca de Juárez", nombreCompleto : "Oaxaca"),
        
        ItemCard(name: "Pue", description : "Escudo dividido en cuatro partes, arriba a la izquierda una fábrica textil, arriba a la derecha una presa, abajo a la izquierda un brazo agarrando un arma representando las luchas por la libertad sobre una llama de fuego, derecha abajo un par de manos sosteniendo una mazorca sobre un campo de maíz. ", capital : "Puebla de Zaragoza", nombreCompleto : "Puebla"),
        
        ItemCard(name: "Qro", description : "Escudo de Queretaro dividido en tres partes, arriba eclipse de sol con dos estrellas a cada lado, abajo izquierda una imagen del apostó Santiago en un caballo de guerra una espada en una mano y el estandarte real de España en la otra, derecha abajo una vid cargada de uvas y cinco espigas de trigo.", capital : "Santiago de Querétaro", nombreCompleto : "Querétaro"),
        
        ItemCard(name: "QR", description : "Escudo con un sol de once rayos de oro, dividido en tres partes, arriba a la izquierda caracol de oro, estrella de cinco puntas de plata. Abajo tres pinos.", capital : "Chetumal", nombreCompleto : "Quintana Roo"),
        
        ItemCard(name: "SLP", description: "Escudo con una imagen del rey de Francia San Luis Potosí, sobre un cerro.", capital : "San Luis Potosí", nombreCompleto : "San Luis Potosí"),
        
        ItemCard(name: "Sin", description : "Escudo con forma de pitahaya con un águila devorando una serpiente encima, dividido en cuatro partes, arriba a la izquierda hay un glifo náhuatl  que representa una montaña curva la derecha de esta montaña, una mano azul sostiene una serpiente del mismo color adornada con siete estrellas. En conjunto, son una representación de Huitzilopochtli, arriba a la derecha  una torre y una muralla. Tras la punta de la torre, se observa una nube blanca. Tras las almenas de la muralla se asoma una barra amarilla sobre la que flota una media luna con las puntas hacia abajo. Bajo la torre, hay tres flechas rotas. Abajo a la izquierda una flama de color naranja donde se derrite un rosario, abajo a la derecha una cabeza de venado, dos isletas  y un ancla.", capital : "Culiacán Rosales",nombreCompleto : "Sinaloa"),
        
        ItemCard(name: "Son", description : "Escudo dividido en dos partes, arriba dividido en tres triángulos cada uno con un color de la bandera, el primero una montaña cruzada con un pico y una pala, el segundo un danzante ejecutando el venado, el ultimo tres haces de espigas y una hoz. Abajo a la izquierda una cabeza de toro, el de la derecha una isla y un tiburón.", capital : "Hermosillo" ,nombreCompleto : "Sonora"),
        
        ItemCard(name: "Tab", description : "Escudo con corona dividido en 5 partes, arriba a la izquierda cuatro torres, arriba a la derecha un brazo con un escudo y una espada, abajo a la izquierda una mujer indígena, abajo a la derecha un león.", capital : "Villahermosa",nombreCompleto : "Tabasco"),
        
        ItemCard(name: "Tamps", description : "Escudo en dos partes, arriba en tres cuarto, primero una plan de maíz, en el cuadro de en medio l Escudo de Armas de Don José de Escandón y Heguera Conde de Sierra Gorda, en el tercer el cuadro un toro de raza cebú, abajo en el fondo  un cerro, abajo se ve un barco camaronero en el mar, en medio una tractor blanco, a la derecha se ve una torre de petróleo y un tanque blanco.", capital : "Ciudad Victoria", nombreCompleto : "Tamaulipas"),
        
        ItemCard(name: "Tlax", description : "Escudo con dos coronas y las iniciales I.K.F  un castillo dorado con una bandera de un águila abajo dos huesos causados y de cada lado una calavera.", capital : "Tlaxcala de Xicohténcatl", nombreCompleto : "Tlaxcala"),
        
        ItemCard(name: "Ver", description : "Escudo con una cruz dividió en dos secciones, arriba un castillo dorado y abajo dos columnas blancas sobre un  con la inscripción plus ultra al rededor 13 estrellas", capital : "Xalapa-Enríquez", nombreCompleto : "Veracruz de Ignacio de la Llave"),
        
        ItemCard(name: "Yuc", description : "Escudo con un venado saltando sobre los montes y un sol arriba a la derecha al rededor dos arcos mayas y dos espadañas coloniales", capital : "Mérida", nombreCompleto : "Yucatán"),
        
        ItemCard(name: "Zac", description : "Escudo de pergamino, Un gran cerro con una cruz en la cima, al centro una imagen de la virgen maria. En la falda del cerro hay cuatro retratos de personas en el campo de plata en memoria de Juan de Tolosa, Diego de Ibarra, Baltazar Temiño de Bañuelos y el capitán Cristóbal de Oñate, principales fundadores, mineros y pobladores del estado", capital : "Zacatecas",nombreCompleto : "Zacatecas"),
        
        ItemCard(name: "Ags", description : "Escudo con yelmo dividido en 3 partes, arriba una fuente, una imagen de la virgen y una boca con una cadena rota de oro, Abajo izquierda racimo de uvas sobre una presa, abajo a la derecha una abeja dentro de un engrane.  Con el lema en latin Tierra Buena, Gente Buena, Agua Clara y Cielo Claro.", capital : "Aguascalientes", nombreCompleto : "Aguascalientes"),
        
        ItemCard(name: "BC", description : "Escudo con timbre de un sol, un hombre y una mujer unidos de la mano sostienen rayos de luz solar, la mujer en la otra mano sostiene una probeta y una escuadra, la otra mano del hombre un libro, en el fondo un campo de siembra una serranía  y un engrane junto a una fábrica, abajo hay un desierto y el rio colorado, frente a todo un fraile misionera con las dos manos levantadas.  Con el lema Trabajo y Justicia Social.", capital : "Mexicali", nombreCompleto : "Baja California"),
        
        ItemCard(name: "BCS",description : "Escudo de forma francesa, dividido en dos partes, en el centro un ostra , un lado es color rojo y otro oro, al rededor en los bordes cuatro peces en un fondo color azul.", capital : "La Paz", nombreCompleto : "Baja California Sur")
    ]
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack{
                BackGround(width: geometry.size.width)
                VStack{
                    Text("Estados de México")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    cardsView(width: geometry.size.width, items: self.items)
                    Button(action:{
                        self.showhingRefernce.toggle()
                    }){
                        Image(systemName: "book")
                        Text("Biblioteca")
                           
                    }
                    .foregroundColor(.white)
                    .sheet(isPresented: self.$showhingRefernce) {
                        ReferenceView(items: self.items)
                    }
                    
                    Button(action:{}){
                        Image(systemName: "gear")
                        Text("Ajustes")
                    }.foregroundColor(.white)
                }
                .layoutPriority(1)
                
           /*if self.showhingRefernce {
               ReferenceView(items: self.items)
                .transition(.identity)
                .animation(.easeIn)
            
               VStack{
                   HStack{
                       Spacer()
                       Button(action : {
                           self.showhingRefernce.toggle()
                       }){
                           ButtonCancel()
                       }.accessibility(label: Text("Salir del juego"))
                       .transition(.scale)
                   }
                   Spacer()
               }
               .padding()
               .layoutPriority(1)
                
               
           }*/
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
