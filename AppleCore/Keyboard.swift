//
//  Keyboard.swift
//  AppleCore
//
//  Created by LittleCodeShop on 11/03/2023.
//

import SwiftUI

struct Keyboard: View {
    
    let row1 = ["ESC","1","2","3","1","2","3","1","2","3","1","2","3"]
    
    var body: some View {
        VStack(spacing:0) {
            HStack(spacing:0) {
                ForEach(row1,id:\.self) { k in
                    ZStack {
                        Image("key_normal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(k).bold()
                    }.shadow(radius: 3,y:3)
                }
            }
            HStack(spacing:0) {
                ForEach(row1,id:\.self) { k in
                    ZStack {
                        Image("key_normal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(k).bold()
                    }.shadow(radius: 3,y:3)
                }
            }
            HStack(spacing:0) {
                ForEach(row1,id:\.self) { k in
                    ZStack {
                        Image("key_normal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(k).bold()
                    }.shadow(radius: 3,y:3)
                }
            }
            HStack(spacing:0) {
                ForEach(row1,id:\.self) { k in
                    ZStack {
                        Image("key_normal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(k).bold()
                    }.shadow(radius: 3,y:3)
                }
            }
            HStack(spacing:0) {
                ForEach(row1,id:\.self) { k in
                    ZStack {
                        Image("key_normal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(k).bold()
                    }.shadow(radius: 3,y:3)
                }
            }
           
        }.ignoresSafeArea()
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
