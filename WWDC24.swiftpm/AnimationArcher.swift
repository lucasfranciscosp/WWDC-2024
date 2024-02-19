import SwiftUI

struct AnimationArcher: View {
    @State private var currentFrameIndex = 0
    @State private var shadowX: CGFloat = 360
    @State private var shadowY = 565
    let frameNames = ["yasmin1", "yasmin2","yasmin3", "yasmin3", "yasmin4", "yasmin5", "yasmin6"]
    
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
                .position(x: shadowX, y: 565)
                .opacity(0.8)
                .blur(radius: 2)
            
            Image(frameNames[currentFrameIndex])
                .resizable()
                .scaleEffect(0.5)
                .position(x: 475,y: 415)
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
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            // Atualiza o índice do frame
            if currentFrameIndex == 3 {
                shadowX = 450
            }
            if currentFrameIndex != 6 {
                currentFrameIndex = (currentFrameIndex + 1) % frameNames.count
            }
            
        }
    }
}
