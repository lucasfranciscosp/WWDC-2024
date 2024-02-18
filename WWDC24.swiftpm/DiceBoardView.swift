//
//  DiceBoardView.swift
//  WWDC24
//
//  Created by Lucas Francisco on 02/02/24.
//

import SwiftUI

struct DiceBoardView: View {
    let tasks: [Dice]
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: 70, maxHeight: 450)
                    .foregroundColor(backgroundColor) // Usando a cor de fundo especificada
                    
                    VStack(spacing: 6) {
                        ForEach(tasks, id: \.self) { task in
                            Image(task.imageName)
                                .frame(minWidth: 20, minHeight: 20)
                                .scaleEffect(0.80)
                                .foregroundStyle(.white)
                                // .draggable(task.imageName)
                                //.highPriorityGesture(DragGesture())
                                
                        }
                    }
                .padding(.vertical)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .padding(.trailing)
    }
}
