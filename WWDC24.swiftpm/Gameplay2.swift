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
    @State private var initialRedDicesQt: [Int] = [1, 3, 5, 6, 9, 12]
    @State private var initialNumeratorQt  = 0
    @State private var initialDenominatorQt = 0
    
    @State private var finalNumerator = 4
    @State private var finalDenominator = 8
    
    @State private var actualNumeratorArray: [Int] = []
    @State private var actualDenominatorArray: [Int] = [2, 4, 7, 8]
    
    @State private var finalNumeratorArray: [Int] = [1, 2, 3, 4]
    @State private var finalDenominatorArray: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
    
    @State var auxIndex: Int = 0
    
    let textsWithColors: [[Text]] = [[
        Text("\(Text("To use my ability I have to take numbers").coloredText(.white)) \(Text("less than or equal then 4").coloredText(Color(hex: "0094FF"))) \(Text("in a dice of").coloredText(.white)) \(Text("8 sides").coloredText(Color(hex: "F03131")))")
    ],[
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
                            .frame(maxWidth: 70, maxHeight: 450)
                            .foregroundColor(.blue)
                        VStack {
                            ForEach(BlueDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .onTapGesture {
                                        checkIfIsCorrect()
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &BlueDices, destination: &Numerator)
                                        }
                                        checkIfIsCorrect()
                                    }
                            }
                        }
                        
                    }
                    .padding(.leading, 70)
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxWidth: 70, maxHeight: 450)
                            .foregroundColor(.red)
                        VStack {
                            ForEach(RedDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .onTapGesture {
                                        checkIfIsCorrect()
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &RedDices, destination: &Denominator)
                                            
                                        }
                                        checkIfIsCorrect()
                                    }
                            }
                        }
                    
                    }                    //DiceBoardView(tasks: RedDices, backgroundColor: .red)
                    VStack() {

                        VStack(alignment: .leading) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(maxHeight: 205)
                                    .foregroundColor(.blue) // Using the specified background color
                                
                                LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 12) {
                                    ForEach(Numerator, id: \.self) { task in
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
                        VStack(alignment: .leading) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(maxHeight: 205)
                                    .foregroundColor(.red) // Using the specified background color
                                
                                LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 12) {
                                    ForEach(Denominator, id: \.self) { task in
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
                    VStack {
                        HStack (spacing: 20) {
                            Image("equal")
                            VStack(spacing: 50) {
                                if actualNumeratorArray == finalNumeratorArray {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                }
                                Image("\(Numerator.count)blue")
                                Image("linedivisor")
                                    .resizable()
                                    .frame(width: 129, height: 2)
                                Image("\(Denominator.count)red")
                                if actualDenominatorArray == finalDenominatorArray {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.trailing)
                            .padding(.trailing)
                        }
                        
                        
                            
                    }
                    .padding(.trailing, 40)
                    
                }
                .padding(.top)
            
                ZStack {
                    Image("dialogueboxmage")
                            .resizable()
                            .frame(width: 1234, height: 216)
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                            .scaleEffect(0.92)

                        Image("magenormal")
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
                }
            }
            // Se for vermelho, verifique se o valor existe no final do denominador
            else {
                if finalDenominatorArray.contains(value) {
                    isAllowedToMove = true
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
            self.auxIndex = textsWithColors.count - 1
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

