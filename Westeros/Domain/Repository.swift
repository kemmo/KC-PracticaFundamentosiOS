//
//  Repository.swift
//  Westeros
//
//  Created by Jorge Vinaches on 13/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    typealias SeasonFilter = (Season) -> Bool
    
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    var seasons: [Season] { get }
    func season(named: String) -> Season?
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")

        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse, wikiUrl: URL(string: "https://es.wikipedia.org/wiki/Robb_Stark")!)
        let arya = Person(name: "Arya", house: starkHouse, wikiUrl: URL(string: "https://es.wikipedia.org/wiki/Arya_Stark")!)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Tyrion_Lannister")!)
        let cersei = Person(name: "Cersei", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Cersei_Lannister")!)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Jaime_Lannister")!)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse, wikiUrl:  URL(string: "https://es.wikipedia.org/wiki/Daenerys_Targaryen")!)
        
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first

        return house
    }
    
    func house(safeNamed name: HouseName) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.rawValue.uppercased() }.first
        
        return house
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        return Repository.local.houses.filter(filteredBy)
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let firstEpisodeSeasonOne = Episode(title: "Winter Is Coming", issueDate: Date.init(dateString: "2011-04-17"), summary: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard \"Ned\" Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.", season: nil)
        let seasonOne = Season(name: "Season 1", releaseDate: Date.init(dateString: "2011-04-17"), firstEpisode: firstEpisodeSeasonOne)
        
        let firstEpisodeSeasonTwo = Episode(title: "The North Remembers", issueDate: Date.init(dateString: "2012-04-01"), summary: "Mientras Robb Stark y su ejército del Norte continúan en guerra contra los Lannister, Tyrion llega a Desembarco del Rey para aconsejar Joffrey y moderar los excesos del joven rey. En la isla de Rocadragón, Stannis Baratheon planea de una invasión para reclamar el trono de su difunto hermano, aliándose con Melisandre, una extraña sacerdotisa que rinde culto a un dios extraño. Al otro lado del mar, Daenerys, sus tres jóvenes dragones y su khalasar caminata a través del desierto en busca de aliados, o agua. En el Norte, Bran preside un Invernalia, mientras que más allá del Muro, Jon Nieve y la Guardia de la Noche deben lidiar con una salvaje.", season: nil)
        let seasonTwo = Season(name: "Season 2", releaseDate: Date.init(dateString: "2012-04-01"), firstEpisode: firstEpisodeSeasonTwo)
        
        let firstEpisodeSeasonThree = Episode(title: "Valar Dohaeris", issueDate: Date.init(dateString: "2013-03-31"), summary: "Samwell Tarly, el lord comandante Mormont y un grupo reducido de la Guardia de la Noche logran salvarse del ataque de los espectros. Jon llega al campamento de los salvajes y habla con Mance Rayder. Tyrion tiene una conversación con su padre y le hace una demanda. Margaery Tyrell comienza a cimentar su camino como futura reina. Robb y su ejército llegan a un devastado Harrenhal. Daenerys desembarca en Astapor y recibe varias sorpresas.", season: nil)
        let seasonThree = Season(name: "Season 3", releaseDate: Date.init(dateString: "2013-03-31"), firstEpisode: firstEpisodeSeasonThree)
        
        let firstEpisodeSeasonFour = Episode(title: "Two Swords", issueDate: Date.init(dateString: "2014-04-06"), summary: "Tywin Lannister regala a su hijo Jaime, nuevo comandante de la Guardia Real, una espada de acero valyrio. Tyrion y Bronn reciben al díscolo príncipe Oberyn Martell, que busca venganza por las afrentas pasadas a su casa. Sansa, mientras tanto, recibe un regalo inesperado de Dontos Hollard. En el norte, Ygritte y Tormund se reúnen con nuevos refuerzos. En el Castillo Negro, Jon Nieve es sometido a juicio por su tiempo entre los salvajes. En su camino a Meereen, Daenerys descubre que no será bien recibida. En las Tierras de los Ríos, el Perro y Arya Stark tienen un encontronazo con soldados Lannister en una taberna.", season: nil)
        let seasonFour = Season(name: "Season 4", releaseDate: Date.init(dateString: "2014-04-06"), firstEpisode: firstEpisodeSeasonFour)
        
        let firstEpisodeSeasonFive = Episode(title: "The Wars to Come", issueDate: Date.init(dateString: "2015-04-12"), summary: "En un flashback se muestra a Cersei de niña preguntándole a una adivina por su futuro. En Desembarco del Rey Cersei critica a Jaime por liberar a Tyrion y provocar indirectamente la muerte de su padre. Mientras, en Pentos, Varys lleva a salvo a Tyrion y le revela su trabajo secreto junto con Illyrio Mopatis para llevar a Daenerys al trono de hierro. Varys invita a Tyrion a unirse a su lucha y él acepta. En Meereen, los Hijos de la Arpía, un grupo de resistencia, asesina a uno de los Inmaculados. Danaerys es informada que la misión en Yunkai ha sido exitosa, los amos han entregado el control a un consejo conformado por esclavos, pero a cambio piden la reapertura de las arenas de combate. Más tarde visita a sus dragones Viserion y Rhaegal pero ellos parecen desconocerla y la intentan atacar. En el Valle, Brienne le informa a Podrick que no lo requiere más, dado que su misión de buscar a las hermanas Stark ha fallado, por otro lado, Sansa y Baelish ven como entrena Robyn Arryn antes de marcharse a un lugar en el que Baelish asegura los Lannister no los encontrarán. Stannis le pide a Jon convencer a Mance Rayder de arrodillarse ante el rey y entregar su ejército de salvajes para atacar Invernalia que está ocupada por Roose Bolton y a su vez les daría ciudadanía y tierras para vivir, sin embargo, Mance rechaza la oferta y es mandado a morir en la hoguera. Jon, incapaz de ver como Rayder sufre con las llamas decide darle una muerte rápida clavándole una flecha en el pecho.", season: nil)
        let seasonFive = Season(name: "Season 5", releaseDate: Date.init(dateString: "2015-04-12"), firstEpisode: firstEpisodeSeasonFive)
        
        let firstEpisodeSeasonSix = Episode(title: "The Red Woman", issueDate: Date.init(dateString: "2016-04-24"), summary: "El futuro de Jon nieve pende de un hilo en el Muro tras el violento ataque de los amotinados; Melissandre tiene que tomar una decisión complicada. Daenerys continúa su huida después de abandonar las tierras de Meereen donde le llevan ante el nuevo Khal. En Braavos, Arya hace frente a su difícil situación e intenta sobrevivir. Tyrion se las arregla como puede en Meereen tras la marcha de sus compañeros que van en busca de Daenerys. Mientras tanto, Jaime consigue traer de vuelta a Myrcella a Desembarco del Rey.", season: nil)
        let seasonSix = Season(name: "Season 6", releaseDate: Date.init(dateString: "2016-04-24"), firstEpisode: firstEpisodeSeasonSix)
        
        let firstEpisodeSeasonSeven = Episode(title: "Dragonstone", issueDate: Date.init(dateString: "2017-07-16"), summary: "En Los Gemelos, Arya Stark envenena a los Frey restantes implicados en la \"Boda Roja\". En Desembarco del Rey, Cersei Lannister y Jaime Lannister tratan con Euron Greyjoy intentando hacer una alianza. En Invernalia, Jon Nieve perdona a los Karstark y a los Umber haciendo que le juren lealtad, y Sansa Stark advierte a Jon de la inminente ira de Cersei. En Antigua, Samwell Tarly comienza su entrenamiento, y un enfermo Jorah Mormont le pregunta por la llegada de Daenerys. Bran Stark llega al Muro y es recibido por Edd el Penas. Sandor Clegane con la Hermandad sin Estandartes se refugia en la casa de un granjero. En Rocadragón, Daenerys Targaryen y Tyrion Lannister junto con su ejército llegan a Rocadragón y exploran el castillo abandonado que fue antes habitado por Stannis Baratheon.", season: nil)
        let seasonSeven = Season(name: "Season 7", releaseDate: Date.init(dateString: "2017-07-16"), firstEpisode: firstEpisodeSeasonSeven)
        
        let _ = Episode(title: "The Kingsroad", issueDate: Date.init(dateString: "2011-04-24"), summary: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.", season: seasonOne)
        let _ = Episode(title: "Lord Snow", issueDate: Date.init(dateString: "2011-05-01"), summary: "Ned se une al Consejo Privado del Rey en Desembarco del Rey, la capital de los Siete Reinos, y descubre la mala administración que sufre Poniente. Catelyn decide ir de incógnito al sur para alertar a su esposo de los Lannister. Arya inicia su entrenamiento con la espada. Bran despierta tras su caída y no recuerda nada. Jon se entrena para adaptarse a su nueva vida en el Muro. Daenerys comienza a asumir su rol como khaleesi de Drogo y se enfrenta a Viserys.", season: seasonOne)
        let _ = Episode(title: "Cripples, Bastards, and Broken Things", issueDate: Date.init(dateString: "2011-05-08"), summary: "Ned busca pistas para tratar de explicar la muerte de Jon Arryn. Robert celebra un torneo en honor a Ned. Jon toma medidas para proteger a Samwell Tarly, otro recluta de la Guardia de la Noche, de los abusos del resto de sus compañeros. Viserys, frustrado, se enfrenta a su hermana. Sansa sueña con una vida como reina de Joffrey Baratheon, el heredero al trono. Catelyn, de camino a Invernalia, acude a los aliados de su padre para apresar a Tyrion al creerle culpable del intento de asesinato de Bran.", season: seasonOne)
        
        let _ = Episode(title: "The Night Lands", issueDate: Date.init(dateString: "2012-04-08"), summary: "A raíz de una purga sangrienta en la capital, Tyrion castiga Cersei por alejar a los súbditos del Rey. En el camino hacia el norte, Arya comparte un secreto con Gendry. Por su parte, después de nueve años como prisionero de los Stark, Theon Greyjoy se reúne con su padre Balon, que quiere restaurar el antiguo reino de las Islas del Hierro. Davos convence a Salladhor Saan, un pirata, para unir fuerzas con Stannis y Melisandre de cara a una invasión naval de Desembarco del Rey.", season: seasonTwo)
        let _ = Episode(title: "Dark Wings, Dark Words", issueDate: Date.init(dateString: "2013-04-07"), summary: "Bran Stark encuentra a dos nuevos acompañantes en su camino al Muro. Sansa conversa con Olenna Tyrell, quien le pide que le diga la verdad sobre Joffrey. Shae le comunica a Tyrion la amenaza que para Sansa significa lord Baelish. Los salvajes continúan su marcha al Sur, al igual que los supervivientes de la Guardia de la Noche. Robb recibe dos malas noticias y, en las Tierras de la Corona, Jaime roba una de las espadas de Brienne e intenta escapar.", season: seasonThree)
        let _ = Episode(title: "The Lion and the Rose", issueDate: Date.init(dateString: "2014-04-13"), summary: "Ramsay Nieve recibe a su padre lord Roose Bolton en Fuerte Terror. Al norte del Muro, Bran emplea sus habilidades como cambiapieles. En Rocadragón, Melisandre ordena quemar vivos en una hoguera a varios hombres de Stannis Baratheon. Desembarco del Rey celebra la boda del rey Joffrey Baratheon con Margaery Tyrell, pero Joffrey es envenenado durante esta y muere.", season: seasonFour)
        let _ = Episode(title: "The House of Black and White", issueDate: Date.init(dateString: "2015-04-12"), summary: "En Desembarco del Rey, Cersei recibe una estatua con el collar de su hija Myrcella y Jaime se dispone a ir por ella a Dorne, pidiendo la ayuda de Bronn. En el muro, Stannis le pide a Jon que se arrodille ante él y le jure lealtad; a cambio será reconocido como Jon Stark y se le otorgará Invernalia, sin embargo él rechaza la oferta, mientras tanto los hermanos de la Guardia de la Noche eligen al próximo Lord Comandante. En el Valle, Brienne y Podrick encuentran a Sansa con Petyr; tras la negación de Sansa por obtener la protección de Brienne, ella se dispone a seguir su caravana. En Braavos, Arya llega a la Casa de Negro y Blanco, pero se le niega la entrada y más tarde encuentra a Jaqen H'ghar. En Dorne, Ellaria le pide a Doran vengarse de la muerte de su hermano Oberyn torturando a Myrcella, pero él termina negándose a tal solicitud. Tyrion y Varys comienzan su viaje a Volantis. En Meereen, Daario y los Inmaculados encuentran un miembro de los Hijos de la Arpía, sin embargo, Mossador lo asesina antes de recibir su juicio, por tal motivo Daenerys ordena su ejecución pública, lo que genera un motín entre los amos y los esclavos liberados. Por la noche, Daenerys descubre que Drogon regresó a Meereen pero se marcha antes de que ella pueda tocarlo.", season: seasonFive)
        let _ = Episode(title: "Home", issueDate: Date.init(dateString: "2016-05-01"), summary: "Más allá del Muro, Bran comienza su entrenamiento con el Cuervo de Tres Ojos, mientras que un joven Tommen es aconsejado por Jaime en Desembarco del Rey. Ramsay sigue con su peculiar modus operandi en el Norte y propone un plan tras la huida de Sansa y Theon. Éste último vuelve con su hermana Yara, en quien recae ahora el destino de los Greyjoy en Pyke.", season: seasonSix)
        let _ = Episode(title: "Stormborn", issueDate: Date.init(dateString: "2017-07-23"), summary: "Daenerys comienza a pensar estrategias junto a sus aliados. Melisandre llega a Rocadragón y pide a Daenerys que convoque a el Rey del Norte Jon Nieve. Sam intenta curar de psoriagrís a Jorah. Cersei entabla alianzas con los Tarly. Jon Nieve decide acudir a la llamada de Daenerys dejando Invernalia en manos de Sansa. Arya decide cambiar su rumbo hacia Invernalia, reencontrándose con su viejo amigo Pastel Caliente y su loba huargo Nymeria. Euron ataca la flota de su sobrina Yara.", season: seasonSeven)
        
        return [seasonSeven, seasonSix, seasonFive, seasonFour, seasonThree, seasonTwo, seasonOne].sorted()
    }
    
    func season(named: String) -> Season? {
        let season = seasons.filter{ $0.name.uppercased() == named.uppercased() }.first
        
        return season
    }
    
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
}
