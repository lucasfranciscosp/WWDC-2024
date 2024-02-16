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
                    if self.index == 9 {
                        self.showTutorial.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.index += 1
                        }
                    } else {
                        self.index += 1
                    }
                }
                //.background(Color.clear)
        }
        
        .fullScreenCover(isPresented: $showTutorial) {
            ContentView(showContent: $showTutorial)
        }
    }
}

class GlobalVariables: ObservableObject {
    @Published var isFullScreenCovered = false
}
