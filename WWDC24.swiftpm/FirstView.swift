import SwiftUI

struct FirstView: View {
    // State para controlar a navegação para a próxima view
    @State private var isShowingNextView = false
    
    var body: some View {
        ZStack {
            Image("story0") // Certifique-se de ter uma imagem chamada "backgroundImage" em seu Assets.xcassets
                .ignoresSafeArea()
            
            // Botão para navegar para a próxima view
            Button(action: {
                // Define isShowingNextView como true para navegar para a próxima view
                isShowingNextView = true
            }) {
                Image("playbutton")
                    .position(x: UIScreen.main.bounds.width / 2 - 20, y: UIScreen.main.bounds.height - 350)
                    .padding()
            }
            .padding()
        }
        // Navegação para a próxima view quando isShowingNextView é true
        .fullScreenCover(isPresented: $isShowingNextView) {
            // Aqui você deve colocar o nome da sua próxima view
            StoryView()
        }
    }
}

