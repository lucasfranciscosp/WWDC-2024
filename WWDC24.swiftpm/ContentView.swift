import SwiftUI

struct ContentView: View {
    
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
    @State private var finalDenominator = 4
    
    @State private var actualNumeratorArray: [Int] = []
    @State private var actualDenominatorArray: [Int] = []
    
    @State private var finalNumeratorArray: [Int] = [3, 4]
    @State private var finalDenominatorArray: [Int] = [1, 2, 3, 4]
    
    @State var auxIndex: Int = 0
    
    let textsWithColors: [[Text]] = [[
        Text("\(Text("I'm gonna throw a dice of").coloredText(.white)) \(Text("4 sides!").coloredText(Color(hex: "F03131")))")
    ],[
        Text("\(Text("Tap the").foregroundColor(.white)) \(Text("numbers 1, 2, 3, 4").foregroundColor(Color(hex: "F03131"))) \(Text("since them represent").foregroundColor(.white)) \(Text("all the possibilities").foregroundColor(Color(hex: "F03131"))) \(Text("in a dice of").foregroundColor(.white)) \(Text("4 sides!").foregroundColor(Color(hex: "F03131"))) \(Text("We can notice that the denominator increases for every possibility").foregroundColor(.white))")
    ],[
        Text("\(Text("Great! Now, to use my skill I need to take").foregroundColor(.white)) \(Text("numbers greater than 2").foregroundColor(Color(hex: "0094FF"))) \(Text("on the same").foregroundColor(.white)) \(Text("4 sided dice!").foregroundColor(Color(hex: "F03131"))) \(Text("In this case tap the numbers").foregroundColor(.white)) \(Text("3 and 4").foregroundColor(Color(hex: "0094FF"))) \(Text("as the others blue dices are not favorable cases or possibilities").foregroundColor(.white))")
    ], [
        Text("\(Text("Nice! Now I'll use my skill!").foregroundColor(.white))")
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
                            .foregroundColor(auxIndex < 2 ? Color.blue.opacity(0.5) : .blue)
                        VStack {
                            ForEach(BlueDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .opacity(auxIndex < 2 ? 0.5 : 1.0)
                                    .onTapGesture {
                                        // checkIfIsCorrect()
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &BlueDices, destination: &Numerator)
                                        }
                                        checkIfIsCorrect()
                                    }
                                    .disabled(auxIndex < 2)
                            }
                        }
                        
                    }
                    .padding(.leading, 70)
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxWidth: 70, maxHeight: 450)
                            .foregroundColor(auxIndex < 1 ? Color.red.opacity(0.5) : .red)
                        VStack {
                            ForEach(RedDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .opacity(auxIndex < 1 ? 0.5 : 1.0)
                                    .onTapGesture {
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &RedDices, destination: &Denominator)
                                            
                                        }
                                        checkIfIsCorrect()
                                    }
                                    .disabled(auxIndex < 1)
                            }
                        }
                    
                    }                    //DiceBoardView(tasks: RedDices, backgroundColor: .red)
                    VStack() {

                        BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
                            .opacity(auxIndex < 2 ? 0.5 : 1.0)
                        BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
                            .opacity(auxIndex < 1 ? 0.5 : 1.0)
                        
                    }
                    VStack {
                        HStack (spacing: 20) {
                            Image("equal")
                                .opacity(auxIndex < 1 ? 0.5 : 1.0)
                            VStack(spacing: 50) {
                                if actualNumeratorArray == finalNumeratorArray {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 32))
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 36))
                                        .foregroundColor(.red)
                                        .opacity(auxIndex < 2 ? 0.5 : 1.0)
                                }
                                Image("\(Numerator.count)blue")
                                    .opacity(auxIndex < 2 ? 0.5 : 1.0)
                                Image("linedivisor")
                                    .resizable()
                                    .frame(width: 129, height: 2)
                                    .opacity(auxIndex < 1 ? 0.5 : 1.0)
                                Image("\(Denominator.count)red")
                                    .opacity(auxIndex < 1 ? 0.5 : 1.0)
                                if actualDenominatorArray == finalDenominatorArray {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 32))
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                        .font(.system(size: 36))
                                        .opacity(auxIndex < 1 ? 0.5 : 1.0)
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
                        Image("dialogueboxbard")
                                .resizable()
                                .frame(width: 1234, height: 216)
                                .aspectRatio(contentMode: .fit)
                                .edgesIgnoringSafeArea(.all)
                                .scaleEffect(0.92)
                        
                    Image("arrow")
                        .offset(x: 520, y: 60)
                        .opacity(auxIndex < 1 ? 1.0 : 0.0)
                        
                        Image("bardnormal")
                            .frame(width: 1366 - 125, height: 0)
                            //.scaleEffect(0.25)
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
                .onTapGesture {
                    if self.auxIndex == 0 {
                        self.auxIndex += 1
                        print(self.auxIndex)
                        print("estou debugando aqui")
                    }
                    
                }
                
            }
            .fullScreenCover(isPresented: $showAnimationWarrior) {
                    AnimationBard()
            }
            .transaction({ transaction in
                transaction.disablesAnimations = true
            })
            
            .onAppear {
                    populateBlueDices(total: initialBlueDicesQt)
                    populateRedDices(total: initialRedDicesQt)
                    populateNumeratorDices(total: initialNumeratorQt)
                    populateDenominatorDices(total: initialDenominatorQt)
                    }
            .padding()
        }
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
        print(self.auxIndex, "estou checando")
        if self.auxIndex == 1 && actualDenominatorArray == finalDenominatorArray{
            auxIndex += 1
        } else if self.auxIndex == 2 && actualNumeratorArray == finalNumeratorArray{
            auxIndex += 1
            self.auxIndex = textsWithColors.count - 1
            print("deu certo denominador")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showAnimationWarrior = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}


public struct MyFont {
    public static func registerFonts() {
        registerFont(bundle: Bundle.main , fontName: "BreatheFireIii-PKLOB", fontExtension: ".ttf") //change according to your ext.
    }
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

extension Text {
    func coloredText(_ color: Color) -> Text {
        self.foregroundColor(color)
    }
}
