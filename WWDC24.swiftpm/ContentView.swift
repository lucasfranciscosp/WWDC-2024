import SwiftUI

struct ContentView: View {
    
    @Binding var showContent: Bool
    
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
        Text("\(Text("We gonna use the").coloredText(.white)) \(Text("blue dices").coloredText(Color(hex: "0094FF"))) \(Text("to").coloredText(.white)) \(Text("put all the \npossibilities we want").coloredText(Color(hex: "0094FF"))) \(Text("in the").coloredText(.white)) \(Text("blue box").coloredText(Color(hex: "0094FF")))")
    ],[
        Text("\(Text("And the").foregroundColor(.white)) \(Text("red dices").foregroundColor(Color(hex: "F03131"))) \(Text("to put").foregroundColor(.white)) \(Text("all the possibilities").foregroundColor(Color(hex: "F03131"))) \(Text("inside the").foregroundColor(.white)) \(Text("red box").foregroundColor(Color(hex: "F03131")))")
    ],[
        Text("\(Text("Let's say that we want to calculate the probability of").foregroundColor(.white)) \(Text("numbers greater than 2").foregroundColor(Color(hex: "0094FF"))) \(Text("in a dice of").foregroundColor(.white)) \(Text("4 sizes").foregroundColor(Color(hex: "F03131")))")

    ],[
        Text("\(Text("Touch the").foregroundColor(.white)) \(Text("red dices").foregroundColor(Color(hex: "F03131"))) \(Text("that represent").foregroundColor(.white)) \(Text("all the possibilities").foregroundColor(Color(hex: "F03131"))) \(Text("in a dice of").foregroundColor(.white)) \(Text("4 sizes").foregroundColor(Color(hex: "F03131"))) \(Text("in the").foregroundColor(.white)) \(Text("red box!").foregroundColor(Color(hex: "F03131"))) \(Text("In this case the numbers").foregroundColor(.white)) \(Text("1, 2, 3, 4").foregroundColor(Color(hex: "F03131")))")
    ],[
        Text("\(Text("Well done! Now since we want numbers greater than 2, lets use the").foregroundColor(.white)) \(Text("blue dices").foregroundColor(Color(hex: "0094FF"))) \(Text("that represent it inside the").foregroundColor(.white)) \(Text("blue box").foregroundColor(Color(hex: "0094FF"))) \(Text("in this case we should use").foregroundColor(.white)) \(Text("3 and 4").foregroundColor(Color(hex: "0094FF")))")
    ], [
        Text("\(Text("Nice! Since we finished the last exercise, let's defeat that insulting boss guys!").foregroundColor(.white))")
    ], [
        Text("\(Text("Nice! Since we finished the last exercise, let's defeat that insulting boss guys!").foregroundColor(.white))")
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
                            .foregroundColor(auxIndex < 3 ? Color.blue.opacity(0.5) : .blue)
                        VStack {
                            ForEach(BlueDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .opacity(auxIndex < 4 ? 0.5 : 1.0)
                                    .onTapGesture {
                                        checkIfIsCorrect()
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &BlueDices, destination: &Numerator)
                                        }
                                        checkIfIsCorrect()
                                    }
                                    .disabled(auxIndex < 4)
                            }
                        }
                        
                    }
                    .padding(.leading, 70)
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(maxWidth: 70, maxHeight: 450)
                            .foregroundColor(auxIndex < 3 ? Color.red.opacity(0.5) : .red)
                        VStack {
                            ForEach(RedDices, id: \.self){ dice in
                                Image(dice.imageName)
                                    .opacity(auxIndex < 3 ? 0.5 : 1.0)
                                    .onTapGesture {
                                        withAnimation(Animation.spring(duration: 0.5)) {
                                            moveDice(from: dice, source: &RedDices, destination: &Denominator)
                                            
                                        }
                                        checkIfIsCorrect()
                                    }
                                    .disabled(auxIndex < 3)
                            }
                        }
                    
                    }                    //DiceBoardView(tasks: RedDices, backgroundColor: .red)
                    VStack() {

                        BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
                            .opacity(auxIndex < 4 ? 0.5 : 1.0)
                        BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
                            .opacity(auxIndex < 3 ? 0.5 : 1.0)
                        
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
                                        .opacity(auxIndex < 4 ? 0.5 : 1.0)
                                }
                                Image("\(Numerator.count)blue")
                                    .opacity(auxIndex < 4 ? 0.5 : 1.0)
                                Image("linedivisor")
                                    .resizable()
                                    .frame(width: 129, height: 2)
                                Image("\(Denominator.count)red")
                                    .opacity(auxIndex < 3 ? 0.5 : 1.0)
                                if actualDenominatorArray == finalDenominatorArray {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                        .opacity(auxIndex < 3 ? 0.5 : 1.0)
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
                        
                    Image("arrow")
                        .offset(x: 520, y: 60)
                        .opacity(auxIndex < 3 || auxIndex >= 5 ? 1.0 : 0.0)
                        
                    
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
                .onTapGesture {
                    if self.auxIndex != textsWithColors.count - 1 && self.auxIndex != 3 && self.auxIndex != 4{
                        if self.auxIndex == 5 {
                            showContent.toggle()
                        }
                        self.auxIndex += 1
                    }
                    
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
        if self.auxIndex == 3 && actualDenominatorArray == finalDenominatorArray{
            auxIndex += 1
        }
        if self.auxIndex == 4 && actualNumeratorArray == finalNumeratorArray{
            auxIndex += 1
        }
        if actualNumeratorArray == finalNumeratorArray && actualDenominatorArray == finalDenominatorArray {
            
            print("aquii")
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
