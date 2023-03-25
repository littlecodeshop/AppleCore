//
//  CPU6502.swift
//  AppleCore
//
//  Created by LittleCodeShop on 06/03/2023.
//

import Foundation

enum AddressingMode : String, Codable {
    
    case indY   //= "(Indirect),Y"
    case zpgX   //= "ZeroPage,X"
    case ind    //= "Indirect"
    case absX   //= "Absolute,X"
    case rel    //= "Relative"
    case impl   //= "Implied"
    case abs    //= "Absolute"
    case zpgY   //= "ZeroPage,Y"
    case acc    //= "Accumulator"
    case xInd   //= "(Indirect,X)"
    case absY   //= "Absolute,Y"
    case zpg    //= "ZeroPage"
    case imm    //= "Immediate"
    
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
            fmt = "#$%02X"
        }
        
        return fmt
    }
    
}

enum Mnemonic : String, Codable {
    case   DEY
    case   TXA
    case   PLA
    case   CLC
    case   TSX
    case   SEI
    case   BMI
    case   ROL
    case   CLV
    case   STY
    case   STX
    case   SED
    case   NOP
    case   BNE
    case   BVC
    case   ROR
    case   ADC
    case   CPX
    case   BCS
    case   BIT
    case   BRK
    case   STA
    case   PHP
    case   SBC
    case   CMP
    case   LDX
    case   JMP
    case   ASL
    case   BCC
    case   EOR
    case   INC
    case   INX
    case   TAY
    case   AND
    case   BPL
    case   TYA
    case   CLI
    case   RTS
    case   BVS
    case   LSR
    case   DEX
    case   RTI
    case   PHA
    case   ORA
    case   TXS
    case   PLP
    case   BEQ
    case   DEC
    case   TAX
    case   LDY
    case   SEC
    case   INY
    case   CPY
    case   CLD
    case   JSR
    case   LDA
    
}

struct Opcode : Codable {
    
    let code: String
    let description: String
    let mnemonic: Mnemonic
    let bytes: Int
    let mode: AddressingMode
    
    func execute() {
        
        
        
    }
    
    
}

class CPU6502  {
    
    // flag masks
    struct CPUStatus {
        static let carry: UInt8 = 0b00000001
        static let zero: UInt8 = 0b00000010
        static let interruptDisable: UInt8 = 0b00000100
        static let decimalMode: UInt8 = 0b00001000
        static let breakCommand: UInt8 = 0b00010000
        static let unused: UInt8 = 0b00100000
        static let overflow: UInt8 = 0b01000000
        static let negative: UInt8 = 0b10000000
    }
    
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
                    val.mnemonic
                })
                
                
                
                
                
            } catch {
                fatalError("no opcodes")
            }
        }
        
    }
    
    func step() -> String {
        
        guard let opcode = opcodes[fetch(PC)] else {
            fatalError("INVALID OPCODE")
        }
        
        
        let s = "\(opcode.mnemonic) \(String(format: opcode.mode.format, fetch(PC+1), fetch(PC+2)))"
       
        
        
        cycle(opcode: opcode)
        
        //increment PC
        PC += UInt16(opcode.bytes)
       
        return s
    }
    
    func cycle(opcode: Opcode) {
        
        var assignment : UInt8 = 0
        var decodedAddress : UInt16 = 0
        
        
        
        switch opcode.mode {
        case AddressingMode.indY:
            break
        case AddressingMode.zpgX:
            break
        case AddressingMode.ind:
            break
        case AddressingMode.absX:
            break
        case AddressingMode.rel:
            break
        case AddressingMode.impl:
            break
        case AddressingMode.abs:
            
            let LL = UInt16(fetch(PC+2))
            let HH = UInt16(fetch(PC+1))<<8
            
            var address = HH | LL
            decodedAddress = address
            assignment = fetch(address)
            
            break
        case AddressingMode.zpgY:
            break
        case AddressingMode.acc:
            break
        case AddressingMode.xInd:
            break
        case AddressingMode.absY:
            break
        case AddressingMode.zpg:
            break
        case AddressingMode.imm:
            assignment = fetch(PC+1)
            break
        }
        
        switch opcode.mnemonic {
        case   .DEY: break
        case   .TXA: break
        case   .PLA: break
        case   .CLC: break
        case   .TSX: break
        case   .SEI: break
        case   .BMI: break
        case   .ROL: break
        case   .CLV: break
        case   .STY: break
        case   .STX: break
        case   .SED: break
        case   .NOP: break
        case   .BNE: break
        case   .BVC: break
        case   .ROR: break
        case   .ADC: break
        case   .CPX: break
        case   .BCS: break
        case   .BIT: break
        case   .BRK: break
        case   .STA: break
        case   .PHP: break
        case   .SBC: break
        case   .CMP: break
        case   .LDX: break
        case   .JMP: break
        case   .ASL: break
        case   .BCC: break
        case   .EOR: break
        case   .INC: break
        case   .INX: break
        case   .TAY: break
        case   .AND: break
        case   .BPL: break
        case   .TYA: break
        case   .CLI: break
        case   .RTS: break
        case   .BVS: break
        case   .LSR: break
        case   .DEX: break
        case   .RTI: break
        case   .PHA: break
        case   .ORA: break
        case   .TXS: break
        case   .PLP: break
        case   .BEQ: break
        case   .DEC: break
        case   .TAX: break
        case   .LDY: break
        case   .SEC: break
        case   .INY: break
        case   .CPY: break
        case   .CLD: break
        case   .JSR: break
        case   .LDA: // AC <- value
            AC = assignment
            break
        }
        
    }
    
    
    
    
}


