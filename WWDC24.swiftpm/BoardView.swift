//
//  BoardView.swift
//  WWDC24
//
//  Created by Lucas Francisco on 02/02/24.
//

import SwiftUI

struct BoardView: View {
    let title: String
    let tasks: [Dice]
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxHeight: 205)
                    .foregroundColor(backgroundColor) // Using the specified background color
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 12) {
                    ForEach(tasks, id: \.self) { task in
                        Image(task.imageName)
                            .frame(minWidth: 50, minHeight: 50)
                            .foregroundStyle(.white)
                            .draggable(task.imageName)
                            .highPriorityGesture(DragGesture())
                    }
                }
                .padding(.vertical)
            }
            .padding(.vertical)
        }
    }
}


