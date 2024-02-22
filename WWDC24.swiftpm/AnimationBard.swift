import SwiftUI
import AVFoundation

struct AnimationBard: View {
    @State private var currentFrameIndex = 0
    @State private var shadowX: CGFloat = 360
    @State private var shadowY = 565
    let frameNames = ["gus1", "gus2", "gus2", "gus2", "gus3"]
    var audioPlayers: [AVAudioPlayer] = []
    
    let audioURLs = [
        Bundle.main.url(forResource: "bark", withExtension: "mp3")
    ]
    
    init() {
        // Carrega o arquivo de áudio
        for i in 0..<audioURLs.count {
            if let path = audioURLs[i]?.path {
                let url = URL(fileURLWithPath: path)
                do {
                    var audioPlayer: AVAudioPlayer!
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.numberOfLoops = 1
                    audioPlayer.prepareToPlay()
                    audioPlayers.append(audioPlayer)
                } catch {
                    print("Erro ao carregar o arquivo de áudio")
                }
            }
        }
        
    }
    
    
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
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            // Atualiza o índice do frame
            if currentFrameIndex != 4 {
                currentFrameIndex = (currentFrameIndex + 1) % frameNames.count
            } else {
                audioPlayers[0].play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    audioPlayers[0].pause()
                }
            }
            
        }
    }
}
