import SwiftUI

struct Gameplay1: View {
    
    @Binding var showContent: Bool
    @State private var showAnimationWarrior = false
    
    @State private var BlueDices: [Dice] = []
    @State private var RedDices: [Dice] = []
    @State private var Numerator: [Dice] = []
    @State private var Denominator: [Dice] = []
    
    @State private var correct: String = "green"
    @State private var wrong: String = "red"
    
    @State private var initialBlueDicesQt = 6
    @State private var initialRedDicesQt = 6
    @State private var initialNumeratorQt  = 0
    @State private var initialDenominatorQt = 0
    
    @State private var finalNumerator = 2
    @State private var finalDenominator = 6
    
    @State private var actualNumeratorArray: [Int] = []
    @State private var actualDenominatorArray: [Int] = []
    
    @State private var finalNumeratorArray: [Int] = [1, 2]
    @State private var finalDenominatorArray: [Int] = [1, 2, 3, 4, 5, 6]
    
    @State var auxIndex: Int = 0
    
    let textsWithColors: [[Text]] = [[
        Text("\(Text("To use my ability I have to take numbers").coloredText(.white)) \(Text("less than 3\n").coloredText(Color(hex: "0094FF"))) \(Text("in a dice of").coloredText(.white)) \(Text("6 sides").coloredText(Color(hex: "F03131")))")
    ],[
        Text("\(Text("Nice! The probability is correct!                                                                                        ").foregroundColor(.white))")
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

                        BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
                        BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
                        
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
                    Image("dialogueboxwarrior")
                            .resizable()
                            .frame(width: 1234, height: 216)
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                            .scaleEffect(0.92)

                        Image("warriornormal")
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
                    populateBlueDices(total: initialBlueDicesQt)
                    populateRedDices(total: initialRedDicesQt)
                    populateNumeratorDices(total: initialNumeratorQt)
                    populateDenominatorDices(total: initialDenominatorQt)
                    }
            .padding()
            
        }
        .fullScreenCover(isPresented: $showAnimationWarrior) {
                AnimationWarrior()
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) {
                    showContent.toggle()
                }
            }
        }
    }
    
    func populateNumeratorDices(total: Int) {
        for i in 1..<total+1 {

            let dice = Dice(image: [Image("\(i)blued6")], imageName: "\(i)blued6", value: i, team: "blue")
            self.actualNumeratorArray.append(dice.value)
            self.Numerator.append(dice)
            self.Numerator.shuffle()
        }
    }
    
    func populateDenominatorDices(total: Int) {
        for i in 1..<total+1 {

            let dice = Dice(image: [Image("\(i)redd6")], imageName: "\(i)redd6", value: i, team: "red")
            self.actualDenominatorArray.append(dice.value)
            self.Denominator.append(dice)
            self.Denominator.shuffle()
        }
    }
    
    func populateRedDices(total: Int) {
        for i in 1..<total+1 {

            let dice = Dice(image: [Image("\(i)redd6")], imageName: "\(i)redd6", value: i, team: "red")
            self.RedDices.append(dice)
            self.RedDices.shuffle()
        }
    }
    
    func populateBlueDices(total: Int) {
        for i in 1..<total+1 {

            let dice = Dice(image: [Image("\(i)blued6")], imageName: "\(i)blued6", value: i, team: "blue")
            self.BlueDices.append(dice)
            self.BlueDices.shuffle()
        }
    }
}

