import SwiftUI

struct ContentView: View {
    
    var apple1 = AppleOne()
    
    var body: some View {
        ScrollView {
            VStack {
               Button(action: {
                   apple1.cpu.singleStep()
               }) {
                   Text("Step")
               }
                
            }
        }
    }
}



