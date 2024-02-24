import AVFoundation
import SwiftUI

struct StoryView: View {
    @State var index: Int = 1
    @State private var showTutorial: Bool = false
    @State private var showGameplay1: Bool = false
    @State private var showGameplay2: Bool = false
    @State private var showGameplay3: Bool = false

    var audioPlayers: [AVAudioPlayer] = []
    
    let audioURLs = [
        Bundle.main.url(forResource: "intro", withExtension: "mp3"),
        Bundle.main.url(forResource: "battle", withExtension: "mp3"),
        Bundle.main.url(forResource: "dingdong", withExtension: "mp3"),
    ]
    
    init() {
        // Carrega o arquivo de áudio
        for i in 0..<audioURLs.count {
            if let path = audioURLs[i]?.path {
                let url = URL(fileURLWithPath: path)
                do {
                    var audioPlayer: AVAudioPlayer!
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.numberOfLoops = -1 // Para repetir indefinidamente
                    if i == 2 {
                        audioPlayer.numberOfLoops = 0
                    }
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
            Image("story\(index)")
                .ignoresSafeArea()
            Image("text")
                .resizable()
                .frame(width: 1097, height: 167)
                .padding(.leading)
                .padding(.top, 600)
                .onAppear {
                    // Inicia a reprodução da música quando a visualização aparece
                    audioPlayers[0].play()
                }
                .onDisappear {
                    // Pausa a reprodução da música quando a visualização desaparece
                    audioPlayers[0].pause()
                }
                .onTapGesture {
                    print(audioURLs)
                    print(self.index, "meu índice de story é isso aqui")
                    if self.index == 12 { //12
                        self.showTutorial.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.index += 1
                        }
                    } else if self.index == 14 {
                        self.showGameplay1.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.index += 1
                        }
                    } else if self.index == 16 {
                        self.showGameplay2.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.index += 1
                        }
                    } else if self.index == 18 { //15
                        self.showGameplay3.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.index += 1
                        }
                    }  else {
                        if self.index == 5 {
                            audioPlayers[0].pause()
                            audioPlayers[1].play()
                        }else if self.index == 19 {
                            audioPlayers[2].play()
                        }
                        self.index += 1
                    }
                }
        }
        .fullScreenCover(isPresented: $showTutorial) {
            ContentView(showContent: $showTutorial)
        }
        .fullScreenCover(isPresented: $showGameplay1) {
            Gameplay1(showContent: $showGameplay1)
        }
        .fullScreenCover(isPresented: $showGameplay2) {
            Gameplay2(showContent: $showGameplay2)
        }
        .fullScreenCover(isPresented: $showGameplay3) {
            Gameplay3(showContent: $showGameplay3)
        }
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
}
