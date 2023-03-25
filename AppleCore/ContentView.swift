import SwiftUI

struct ContentView: View {
    
    @StateObject var apple1 = AppleOne()
    @State private var debugTokens = [String]()
    
    var body: some View {
        
        VStack {
            
            VStack (alignment: .leading){
                ScrollView {
                    ForEach(debugTokens, id:\.self) { s in
                        Text(s)
                            .foregroundColor(.green)
                            .frame(maxWidth:.infinity, alignment: .leading)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1,contentMode: .fit)
            .border(Color.red)
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom))
            .padding()
            
            Spacer()
            HStack {
                Button(action: {
                    let s = apple1.cpu.step()
                    debugTokens.append(s)
                }) {
                    Image("key_normal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 50)
                        .shadow(radius: 5)
                }
            }
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


