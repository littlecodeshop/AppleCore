import SwiftUI

struct ContentView: View {
    
    var apple1 = AppleOne()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(apple1.rom.indices, id :\.self){ i in
                    Text("\(String(format:"%02X",i)) \(String(format:"%02X", apple1.rom[i]))")
                }
                
            }
        }
    }
}



