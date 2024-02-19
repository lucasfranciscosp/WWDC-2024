import SwiftUI

struct AnimationWarrior: View {
    @State private var currentFrameIndex = 0
    let frameNames = ["lucas1", "lucas2", "lucas3", "lucas2", "lucas1"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "956646"))
                .ignoresSafeArea()
            Image("sofabattle")
                .resizable()
                .scaleEffect(0.9)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            Image("lucasshadow")
                .position(x: 360, y: 565)
                .opacity(0.8)
                .blur(radius: 2)
            
            Image(frameNames[currentFrameIndex])
                .resizable()
                .scaleEffect(0.50)
                .position(x: 400,y: 400)
             //   .scaledToFit()
                //.frame(width: 400, height: 400) // ajuste o tamanho conforme necessário
            Image("lucasshadow")
                .position(x: 870, y: 610)
                .scaleEffect(0.8)
                .opacity(0.8)
                .blur(radius: 2)
            Image("dogrpg")
                .scaleEffect(0.35)
                .position(x: 800, y: 475)
        }
        .onAppear {
            // Inicia a animação
            startAnimating()
        }
    }
    
    func startAnimating() {
        // Animação usando um Timer
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            // Atualiza o índice do frame
            currentFrameIndex = (currentFrameIndex + 1) % frameNames.count
        }
    }
}
