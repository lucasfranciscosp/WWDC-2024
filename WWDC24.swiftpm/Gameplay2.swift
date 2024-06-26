import SwiftUI

struct Gameplay2: View {
    
    @Binding var showContent: Bool
    @State private var showAnimationWarrior = false
    
    @State private var BlueDices: [Dice] = []
    @State private var RedDices: [Dice] = []
    @State private var Numerator: [Dice] = []
    @State private var Denominator: [Dice] = []
    
    @State private var correct: String = "green"
    @State private var wrong: String = "red"
    
    @State private var initialBlueDicesQt: [Int] = [1, 2, 3, 4, 7, 10]
    @State private var initialRedDicesQt: [Int] = [1, 3, 5, 6, 9, 12, 2, 4]
    @State private var initialNumeratorQt  = 0
    @State private var initialDenominatorQt = 0
    
    @State private var finalNumerator = 4
    @State private var finalDenominator = 6
    
    @State private var actualNumeratorArray: [Int] = []
    @State private var actualDenominatorArray: [Int] = []
    
    @State private var finalNumeratorArray: [Int] = [1, 2, 3, 4]
    @State private var finalDenominatorArray: [Int] = [1, 2, 3, 4, 5, 6]
    
    @State var auxIndex: Int = 0
    @State var face = "magenormal"
    @State var waiting: Bool = false
    
    @State var textsWithColors: [[Text]] = [[
        Text("\(Text("To use my skill I'll roll a").coloredText(.white)) \(Text("6-sided").coloredText(Color(hex: "F03131"))) \(Text("dice and I want to take numbers").coloredText(.white)) \(Text("less or equal to 4").coloredText(Color(hex: "0094FF")))")
    ],[
        Text("\(Text("Good! This is the right probability!                                                                                        ").foregroundColor(.white))")
    ], [
        Text("\(Text("Good! This is the right probability!                                                                                        ").foregroundColor(.white))")
    ]
    ]

    
    var body: some View {

        ZStack {
            Rectangle()
                .fill(Color(hex: "956646"))
                .ignoresSafeArea()
            Image("backdices")
                .resizable()
                .frame(width: 1135, height: 500)
                .padding(.bottom, 200)
            VStack {
                HStack(spacing: 20) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxHeight: 450)
                            .frame(maxWidth: 350)
                            .foregroundColor(.blue)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 12) {
                            ForEach(BlueDices, id: \.self) { dice in
                                Image(dice.imageName)
                                    .frame(minWidth: 50, minHeight: 50)
                                    .onTapGesture {
                                        if !waiting {
                                            checkIfIsCorrect()
                                            withAnimation(Animation.spring(duration: 0.5)) {
                                                moveDice(from: dice, source: &BlueDices, destination: &Numerator)
                                            }
                                            checkIfIsCorrect()
                                        }
                                    }
                                    .disabled((finalNumeratorArray == actualNumeratorArray && finalDenominatorArray == actualDenominatorArray))
                            }
                        }
                        .frame(maxHeight: 450)
                        .frame(maxWidth: 350)
                        .padding(.vertical)
                    }
                    
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 12)
//                            .frame(maxWidth: 70, maxHeight: 450)
//                            .foregroundColor(auxIndex < 1 ? Color.blue.opacity(0.0) : .blue)
//                        VStack {
//                            ForEach(BlueDices, id: \.self){ dice in
//                                Image(dice.imageName)
//                                    .opacity(auxIndex < 1 ? 0.0 : 1.0)
//                                    .onTapGesture {
//                                        // checkIfIsCorrect()
//                                        withAnimation(Animation.spring(duration: 0.5)) {
//                                            moveDice(from: dice, source: &BlueDices, destination: &Numerator)
//                                        }
//                                        checkIfIsCorrect()
//                                    }
//                                    .disabled(auxIndex < 1)
//                            }
//                        }
//
//                    }
//                    .padding(.leading, 70)
//                    ZStack {
//
//                        RoundedRectangle(cornerRadius: 12)
//                            .frame(maxWidth: 70, maxHeight: 450)
//                            .foregroundColor(auxIndex < 0 ? Color.red.opacity(0.5) : .red)
//                        VStack {
//                            ForEach(RedDices, id: \.self){ dice in
//                                Image(dice.imageName)
//                                    .opacity(auxIndex < 0 ? 0.5 : 1.0)
//                                    .onTapGesture {
//                                        withAnimation(Animation.spring(duration: 0.5)) {
//                                            moveDice(from: dice, source: &RedDices, destination: &Denominator)
//
//                                        }
//                                        checkIfIsCorrect()
//                                    }
//                                    .disabled(auxIndex < 0)
//                            }
//                        }
//
//                    }
                    
                    //DiceBoardView(tasks: RedDices, backgroundColor: .red)
//                    VStack() {
//
//                        BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
//                            .opacity(auxIndex < 1 ? 0.0 : 1.0)
//                        BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
//                            .opacity(auxIndex < 0 ? 0.5 : 1.0)
//
//                    }
                    VStack {
                        HStack (spacing: 20) {
//                            Image("equal")
//                                .opacity(auxIndex < 0 ? 0.5 : 1.0)
                            VStack(spacing: 45) {
                                if actualNumeratorArray == finalNumeratorArray {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 32))
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 32))
                                        .foregroundColor(.red)
                                }
                                Image("\(Numerator.count)blue")
                                Image("linedivisor")
                                    .resizable()
                                    .frame(width: 129, height: 2)
                                Image("\(Denominator.count)red")
                                    .opacity(auxIndex < 0 ? 0.5 : 1.0)
                                if actualDenominatorArray == finalDenominatorArray {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 32))
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                        .font(.system(size: 32))
                                }
                            }
//                            .padding(.trailing)
//                            .padding(.trailing)
                        }
                        
                        
                            
                    }
                    .padding(.trailing, 40)
                    .padding(.leading, 40)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxHeight: 450)
                            .frame(maxWidth: 350)
                            .foregroundColor(.red) // Using the specified background color
                        
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 12) {
                            ForEach(RedDices, id: \.self) { dice in
                                Image(dice.imageName)
                                    .frame(minWidth: 50, minHeight: 50)
                                    .onTapGesture {
                                        if !waiting {
                                            checkIfIsCorrect()
                                            withAnimation(Animation.spring(duration: 0.5)) {
                                                moveDice(from: dice, source: &RedDices, destination: &Denominator)
                                            }
                                            checkIfIsCorrect()
                                        }
                                    }
                                    .disabled((finalNumeratorArray == actualNumeratorArray && finalDenominatorArray == actualDenominatorArray))
                            }
                        }
                        .frame(maxHeight: 450)
                        .frame(maxWidth: 350)
                        .padding(.vertical)
                    }
                    
                }
                .padding(.top)
            
            
                ZStack {
                    Image("dialogueboxmage")
                            .resizable()
                            .frame(width: 1234, height: 216)
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                            .scaleEffect(0.92)

                        Image(face)
                            .frame(width: 1366 - 125, height: 0)
                            .scaleEffect(0.25)
                            .offset(x: -400)
                    
                        HStack {
                            ForEach(Array(textsWithColors[auxIndex].enumerated()), id: \.offset) { index, text in
                                text
                                    .font(.custom("Breathe Fire III", size: 36))
                            }
                        }


                        .padding(.leading, 350)
                        .padding(.trailing, 150)
                        .offset(x: 50)
                    
                        
                }
                
            }
            
            
            .onAppear {
                    populateBlueDices(list: initialBlueDicesQt)
                    populateRedDices(list: initialRedDicesQt)
                    populateNumeratorDices(list: actualNumeratorArray)
                    populateDenominatorDices(list: actualDenominatorArray)
                    }
            .padding()
            
        }
        .fullScreenCover(isPresented: $showAnimationWarrior) {
                AnimationMage()
        }
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
        
    }
    
    func moveDice(from dice: Dice, source: inout [Dice], destination: inout [Dice]) {
        if let index = source.firstIndex(of: dice) {
            let removedDice = source[index]
            let value = removedDice.value
            
            var isAllowedToMove = false
            
            // Se for azul, verifique se o valor existe no numerador
            if removedDice.imageName.contains("blue") {
                if finalNumeratorArray.contains(value) {
                    isAllowedToMove = true
                    checkIfIsCorrect()
                } else {
                    if dice.value < 7 {
                        textsWithColors[textsWithColors.count - 1] = [Text("\(Text("The number").foregroundColor(.white)) \(Text("\(dice.value)").foregroundColor(Color(hex: "0094FF"))) \(Text("it's not what a favorable case").foregroundColor(.white))")]
                        auxIndex = 2
                        face = "magesad"
                        waiting = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            face = "magenormal"
                            auxIndex = 0
                            waiting = false
                        }
                    } else {
                        textsWithColors[textsWithColors.count - 1] = [Text("\(Text("The number").foregroundColor(.white)) \(Text("\(dice.value)").foregroundColor(Color(hex: "0094FF"))) \(Text("it's not possible to take in a").foregroundColor(.white)) \(Text("6-sided dice!").foregroundColor(Color(hex: "F03131")))")]
                        auxIndex = 2
                        face = "magesad"
                        waiting = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            face = "magenormal"
                            auxIndex = 0
                            waiting = false
                        }
                    }
                }
            }
            // Se for vermelho, verifique se o valor existe no final do denominador
            else {
                if finalDenominatorArray.contains(value) {
                    isAllowedToMove = true
                    checkIfIsCorrect()
                } else {
                    textsWithColors[textsWithColors.count - 1] = [Text("\(Text("The number").foregroundColor(.white)) \(Text("\(dice.value)").foregroundColor(Color(hex: "F03131"))) \(Text("it's not a possibility in a").foregroundColor(.white)) \(Text("6-sided dice").foregroundColor(Color(hex: "F03131")))")]
                    auxIndex = 2
                    face = "magesad"
                    waiting = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        waiting = false
                        face = "magenormal"
                        auxIndex = 0
                    }
                    
                }
            }
            
            // Se permitido mover, execute a animação e a lógica de movimento
            if isAllowedToMove {
                withAnimation(Animation.spring(duration: 0.5)) {
                    source.remove(at: index)
                    
                    if removedDice.imageName.contains("blue") {
                        actualNumeratorArray.append(value)
                        actualNumeratorArray.sort()
                    } else {
                        actualDenominatorArray.append(value)
                        actualDenominatorArray.sort()
                    }
                    // Adicione uma imagem vazia no lugar do dado removido
                    let emptyDice = Dice(image: [Image("empty")], imageName: "empty", value: 0, team: "empty")
                    source.insert(emptyDice, at: index)
                    
                    destination.append(removedDice)
                }
            }
        }
        
    }

    
    func sumIndex() {
        self.auxIndex += 1
    }
            
    func checkIfIsCorrect() {
        if actualNumeratorArray == finalNumeratorArray && actualDenominatorArray == finalDenominatorArray {
            self.auxIndex = textsWithColors.count - 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showAnimationWarrior = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showContent.toggle()
                }
            }
        }
    }
    
    func populateNumeratorDices(list: [Int]) {
        for i in 0..<list.count {

            let dice = Dice(image: [Image("\(list[i])blued6")], imageName: "\(list[i])blued6", value: list[i], team: "blue")
            //self.actualNumeratorArray.append(dice.value)
            self.Numerator.append(dice)
            self.Numerator.shuffle()
        }
    }
    
    func populateDenominatorDices(list: [Int]) {
        for i in 0..<list.count {

            let dice = Dice(image: [Image("\(list[i])redd6")], imageName: "\(list[i])redd6", value: list[i], team: "red")
            // self.actualDenominatorArray.append(dice.value)
            self.Denominator.append(dice)
            self.Denominator.shuffle()
        }
    }
    
    func populateRedDices(list: [Int]) {
        for i in 0..<list.count {

            let dice = Dice(image: [Image("\(list[i])redd6")], imageName: "\(list[i])redd6", value: list[i], team: "red")
            self.RedDices.append(dice)
            self.RedDices.shuffle()
        }
    }
    
    func populateBlueDices(list: [Int]) {
        for i in 0..<list.count {

            let dice = Dice(image: [Image("\(list[i])blued6")], imageName: "\(list[i])blued6", value: list[i], team: "blue")
            self.BlueDices.append(dice)
            self.BlueDices.shuffle()
        }
    }
}

