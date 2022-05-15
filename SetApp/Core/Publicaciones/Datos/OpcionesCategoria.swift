//
//  OpcionesCategoria.swift
//  SetApp
//
//  Created by Emilio Roman on 2/5/22.
//

import Foundation
import SwiftUI
 
enum TiposCategoria: String, CaseIterable {
    
    case monitor = "Monitor"
    case teclado = "Teclado"
    case raton = "Raton"
    case sonido = "Sonido"
    case audio = "Audio"
    case camara = "Camara"
    case pc = "PC"
    case accesorios = "Accesorios"
    case otro = "Otro"
    
    var tiposCategoria: String{
        
        return rawValue.capitalized
    }
}

enum NumValoracion: String, CaseIterable {
    
    case uno = "1"
    case dos = "2"
    case tres = "3"
    case cuatro = "4"
    case cinco = "5"
    case seis = "6"
    case siete = "7"
    case ocho = "8"
    case nueve = "9"
    case diez = "10"
    
    var numValoracion: String{
        
        return rawValue.capitalized
    }
}
 
enum NombreMarcas: String, CaseIterable {
    
    case life = "1Life"
    case go = "3Go"
    //A
    case asus = "Asus"
    case aoc = "AOC"
    case acer = "Acer"
    case apple = "Apple"
    case aukey = "Aukey"
    case adata = "Adata"
    case approx = "Approx"
    case activv = "Activv"
    //B
    case benq = "Benq"
    case bluestork = "Bluestork"
    //C
    case corsair = "Corsair"
    case cherry = "Cherry"
    case coolermaster = "Cooler Master"
    case coolbox = "CoolBox"
    case conceptronic = "Conceptronic"
    case cool = "Cool"
    case canyon = "Canyon"
    //D
    case dell = "Dell"
    case droxio = "Droxio"
    //E
    case eizo = "Eizo"
    case evga = "EVGA"
    case energysystem = "Energy System"
    case ewent = "Ewent"
    case enuc = "E-nuc"
    case equip = "Equip"
    //F
    case fujitsu = "Fujitsu"
    case forgeon = "Forgeon"
    case fury = "Fury"
    //G
    case gigabyte = "Gigabyte"
    case gigacrysta = "GigaCrysta"
    case iggual = "Iggual"
    case gskill = "G.Skill"
    case genesis = "Genesis"
    //H
    case hp = "Hp"
    case huawei = "Huawei"
    case hannspree = "Hannspree"
    case hisense = "Hisense"
    case hyperx = "HyperX"
    case havit = "Havit"
    case hiditec = "Hiditec"
    case hama = "Hama"
    //I
    case iiyama = "Iiyama"
    case innjoo = "Innjoo"
    //J
    //K
    case keepout = "Keep Out"
    case krom = "Krom"
    case kensington = "Kensington"
    case konix = "Konix"
    //L
    case lg = "LG"
    case lenovo = "Lenovo"
    case lopower = "LC-Power"
    case logitech = "Logitech"
    case llink = "L-link"
    case leotec = "Leotec"
    //M
    case msi = "MSI"
    case millenium = "Millenium"
    case marsgaming = "Mars Gaming"
    case microsoft = "Microsoft"
    case moongaming = "MoonGaming"
    case mountain = "Mountain"
    case maillon = "Maillon"
    //N
    case newskill = "Newskill"
    case nec = "NEC"
    case nilox = "Nilox"
    case ngs = "NGS"
    case nox = "NOX"
    case natec = "Natec"
    //Ñ
    //O
    case ozone = "Ozone"
    case optoma = "Optoma"
    case owlotech = "Owlotech"
    //P
    case philips = "Philips"
    case pccom = "PcCom"
    case phoenix = "Phoenix"
    case prestigio = "Prestigio"
    case prixton = "Prixton"
    //Q
    //R
    case razer = "Razer"
    case redragon = "Redragon"
    case rapoo = "Rapoo"
    case riello = "Riello"
    //S
    case samsung = "Samsung"
    case sony = "Sony"
    case secretlab = "Secretlab"
    case schneider = "Schneider"
    case steelseries = "Steelseries"
    case subblim = "Subblim"
    case sharkoon = "Sharkoon"
    case silverht = "SilverHT"
    case spriritofgamer = "Spirit Of Gamer"
    case scorpion = "Scorpion"
    //T
    case tempest = "Tempest"
    case trust = "Trust"
    case thermaltaqe = "Thermaltaqe"
    case tacens = "Tacens"
    case thunderx3 = "Thunder X3"
    case tronsmart = "Tronsmart"
    case talius = "Talius"
    case targus = "Targus"
    case tesoro = "Tesoro"
    //U
    case unykach = "UNYKAch"
    case unicview = "Unicview"
    //V
    case viewsonic = "Viewsonic"
    case v7 = "V7"
    //W
    case woxter = "Woxter"
    case wellyenjoyit = "Well enjoy it"
    //X
    case xiaomi = "Xiaomi"
    //Y
    //Z
    case zalman = "Zalman"
    
    var nombreMarcas: String{
        
        return rawValue.capitalized
    }
}
