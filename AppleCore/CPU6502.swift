//
//  CPU6502.swift
//  AppleCore
//
//  Created by LittleCodeShop on 06/03/2023.
//

import Foundation

enum AddressingMode : String, Codable {
    
    case indY = "(Indirect),Y"
    case zpgX = "ZeroPage,X"
    case ind = "Indirect"
    case absX = "Absolute,X"
    case rel = "Relative"
    case impl = "Implied"
    case abs = "Absolute"
    case zpgY = "ZeroPage,Y"
    case acc = "Accumulator"
    case xInd = "(Indirect,X)"
    case absY = "Absolute,Y"
    case zpg = "ZeroPage"
    case imm = "Immediate"
    
    var format : String  {
        
        var fmt : String!
        
        switch self {
            
        case .indY:
            fmt =  "(%02X),Y"
        case .zpgX:
            fmt = "%02X"
        case .ind:
            fmt =  "(%02X%02X)"
        case .absX:
            fmt =  "%02X%02X,X"
        case .rel:
            fmt =  "%02X"
        case .impl:
            fmt =  ""
        case .abs:
            fmt =  "%02X%02X"
        case .zpgY:
            fmt =  "%02X,Y"
        case .acc:
            fmt =  " A"
        case .xInd:
            fmt =  ""
        case .absY:
            fmt =  "%02X%02X,Y"
        case .zpg:
            fmt = "%02X%02X"
        case .imm:
            fmt = "#%02X"
        }
        
        return fmt
    }
    
}

struct Opcode : Codable {
    
    let code: String
    let description: String
    let mnemonic: String
    let bytes: Int
    let mode: String
    
}

class CPU6502 {
    
    
    var PC : UInt16 // 16 bits program counter
    var AC : UInt8  // Accumulator
    var X  : UInt8  // X register
    var Y  : UInt8  // Y register
    var SP : UInt8  // Stack pointer
    var ST : UInt8  // Status register [NV-BDIZC]
    
    var fetch : (UInt16) -> UInt8 = {_ in
        return 0xBA
    }
    var store : (UInt16, UInt8) -> Void = {_,_ in }
    
    var opcodes = [UInt8:Opcode]()
    
    init() {
        SP     = 0xFF;
        AC     = 0x00;
        X      = 0x00;
        Y      = 0x00;
        ST     = 0x00;
        PC     = 0xFF00; // will start running woz monitor
        
        //load the instructions
        
        if let filepath = Bundle.main.path(forResource: "opcodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let decoder = JSONDecoder()
                let tmp = try decoder.decode([Opcode].self, from: data)
                tmp.forEach { o in
                    opcodes[UInt8(o.code.dropFirst(2), radix: 16)!] = o
                }
                
                let os = Set(opcodes.map { (key, val) in
                    val.mode
                })
                os.forEach { o in
                    print(o)
                }
                
            } catch {
                fatalError("no opcodes")
            }
        }
        
    }
    
    func singleStep() {
        
        guard let opcode = opcodes[fetch(PC)], let addressingMode = AddressingMode(rawValue: opcode.mode) else {
            fatalError("INVALID OPCODE")
        }
        
        
        
        print("\(opcode.mnemonic) \(String(format: addressingMode.format, fetch(PC+1), fetch(PC+2)))")
        PC += UInt16(opcode.bytes)
        
        switch opcode.mode {
        case AddressingMode.indY.rawValue:
            break
        case AddressingMode.zpgX.rawValue:
            break
        case AddressingMode.ind.rawValue:
            break
        case AddressingMode.absX.rawValue:
            break
        case AddressingMode.rel.rawValue:
            break
        case AddressingMode.impl.rawValue:
            break
        case AddressingMode.abs.rawValue:
            break
        case AddressingMode.zpgY.rawValue:
            break
        case AddressingMode.acc.rawValue:
            break
        case AddressingMode.xInd.rawValue:
            break
        case AddressingMode.absY.rawValue:
            break
        case AddressingMode.zpg.rawValue:
            break
        case AddressingMode.imm.rawValue:
            break
        default:
            fatalError("unknown addressing mode")
        }
        
        
    }
    
    
}


