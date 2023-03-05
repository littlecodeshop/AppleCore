//
//  AppleOne.swift
//  AppleCore
//
//  Created by LittleCodeShop on 05/03/2023.
//

import Foundation

struct CPU6502 {
    
    var PC : UInt16 // 16 bits program counter
    var AC : UInt8  // Accumulator
    var X  : UInt8  // X register
    var Y  : UInt8  // Y register
    var SP : UInt8  // Stack pointer
    var ST : UInt8  // Status register [NV-BDIZC]
    
    
    
    init() {
        SP     = 0xFF;
        AC     = 0x00;
        X      = 0x00;
        Y      = 0x00;
        ST     = 0x00;
        PC     = 0xFF00; // will start running woz monitor
    }
    
    func step() {
        
    }
    
}

class AppleOne {
    
    var ram : Data
    var rom : Data
    var cpu = CPU6502()
    
    func write(_ address: UInt16, value: UInt8){
        switch address {
        case let x where (0x0000..<0x0FFF).contains(x): // we write to ram
            ram[Data.Index(x)] = value
        case let x where (0xD010...0xD012).contains(x): // we write to I/O
            break // we will implement this later
        case let x where x >= 0xFF00: // writing to rom should do nothing
            break
        default: // any other address would be invalid to
            break
        }
    }
    
    func read(_ address: UInt16) -> UInt8 {
        switch address {
        case let x where (0x0000..<0x0FFF).contains(x): // reading from ram
            return ram[Data.Index(address)]
        case let x where (0xD010...0xD012).contains(x): // we read from I/O
            break // we will implement later
        case let x where x >= 0xFF: // reading from rom
            return rom[Data.Index(address - 0xFF00)]
        default:
            // any other address is not connected, if cpu tries to read
            // not sure what it would return let's put something we can spot
            return 0xAB
        }
        return 0xAB
    }
    
    init(){
        ram = Data(count: 0xFFF) // create an array of 4kb
        let filepath = Bundle.main.path(forResource: "woz", ofType: "bin")!
        rom = try! Data(contentsOf: URL(fileURLWithPath: filepath)) // load the woz monitor
        
    }
}
