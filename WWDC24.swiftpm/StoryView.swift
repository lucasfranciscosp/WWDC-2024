//
//  StoryView.swift
//  WWDC24
//
//  Created by Lucas Francisco on 15/02/24.
//

import SwiftUI

struct StoryView: View {
    
    @State var index: Int = 1
    @State private var showTutorial: Bool = false
    @State private var showGameplay1: Bool = false
    @State private var showGameplay2: Bool = false
    @State private var showGameplay3: Bool = false
    
    var body: some View {
        ZStack {
            Image("story\(index)")
                .ignoresSafeArea()
            Image("text")
                .resizable()
                .frame(width: 1097, height: 167)
                .padding(.leading)
                .padding(.top, 600)
                .onTapGesture {
                    if self.index == 12 {
                        self.showTutorial.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.index += 1
                        }
                    } else if self.index == 14 {
                        self.showGameplay1.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.index += 1
                        }
                    } else if self.index == 13 {
                        self.showGameplay2.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.index += 1
                        }
                    } else if self.index == 15 { //15
                        self.showGameplay3.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.index += 1
                        }
                    }  else {
                        self.index += 1
                    }
                }
                //.background(Color.clear)
        }
        
        .fullScreenCover(isPresented: $showTutorial) {
            ContentView(showContent: $showTutorial)
                //.background(TransparentBackground())
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

class GlobalVariables: ObservableObject {
    @Published var isFullScreenCovered = false
}
