import SwiftUI

struct ContentView: View {
    
    @Binding var showContent: Bool
    
    @State private var BlueDices: [Dice] = []
    @State private var RedDices: [Dice] = []
    @State private var Numerator: [Dice] = []
    @State private var Denominator: [Dice] = []
    
    @State private var correct: String = "green"
    @State private var wrong: String = "red"
    
    @State private var initialBlueDicesQt = 4
    @State private var initialRedDicesQt = 4
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
        Text("\(Text("We gonna use the").coloredText(.white)) \(Text("blue dices").coloredText(Color(hex: "0094FF"))) \(Text("to").coloredText(.white)) \(Text("put all the possibilities we want").coloredText(Color(hex: "0094FF"))) \(Text("in the").coloredText(.white)) \(Text("blue box").coloredText(Color(hex: "0094FF")))")
    ],[
        Text("\(Text("And the").foregroundColor(.white)) \(Text("red dices").foregroundColor(Color(hex: "F03131"))) \(Text("to put").foregroundColor(.white)) \(Text("all the possibilities").foregroundColor(Color(hex: "F03131"))) \(Text("inside the").foregroundColor(.white)) \(Text("red box").foregroundColor(Color(hex: "F03131")))")
    ],[
        Text("\(Text("Let's say that we want to calculate the probability of").foregroundColor(.white)) \(Text("numbers greater than 2").foregroundColor(Color(hex: "0094FF"))) \(Text("in a dice of").foregroundColor(.white)) \(Text("4 sizes").foregroundColor(Color(hex: "F03131")))")

    ],[
        Text("\(Text("If you hold the dice we can drag and drop it!\n Put all the").foregroundColor(.white)) \(Text("red dices").foregroundColor(Color(hex: "F03131"))) \(Text("that represent").foregroundColor(.white)) \(Text("all the possibilities").foregroundColor(Color(hex: "F03131"))) \(Text("in a dice of").foregroundColor(.white)) \(Text("4 sizes").foregroundColor(Color(hex: "F03131"))) \(Text("in the").foregroundColor(.white)) \(Text("red box!\n").foregroundColor(Color(hex: "F03131"))) \(Text("In this case the numbers").foregroundColor(.white)) \(Text("1, 2, 3, 4").foregroundColor(Color(hex: "F03131")))")
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
                    DiceBoardView(tasks: BlueDices, backgroundColor: .blue)
                        .padding(.leading, 70)
                    DiceBoardView(tasks: RedDices, backgroundColor: .red)
                    VStack() {
                        if auxIndex < 3 {
                            BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
                            BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
                        } else {
                            BoardView(title: "Numerator", tasks: Numerator, backgroundColor: .blue)
                            
                                .dropDestination(for: String.self) {
                                    droppedDice,  location in
                                    print(droppedDice)
                                    
                                    if auxIndex == 3 {
                                        return false
                                    }
                                    
                                    // Its not possible to use a red dice in a blue section
                                    if droppedDice[0].contains("red"){
                                        return false
                                    }
                                    
                                    // its not possible to drop the same dice in the same section
                                    for i in 0..<Numerator.count {
                                        if Numerator[i].imageName == droppedDice[0] {
                                            return false
                                        }
                                    }
                                    
                                    
                                    // Setup dice
                                    let firstDigit = Int(String(droppedDice[0].first!))
                                    
                                    if !finalNumeratorArray.contains(firstDigit!) {
                                        return false
                                    }
                                    
                                    let team = "blue"
                                    Numerator.append(Dice(image: [Image(droppedDice[0])], imageName: droppedDice[0], value: firstDigit!, team: team))
                                    
                                    // Find dice in blue, update the numerator stats and remove it
                                    for i in 0..<BlueDices.count {
                                        if BlueDices[i].imageName == droppedDice[0] {
                                            actualNumeratorArray.append(BlueDices[i].value)
                                            actualNumeratorArray.sort()
                                            BlueDices.remove(at: i)
                                            break
                                        }
                                    }
                                    checkIfIsCorrect()
                                    
                                    return true
                                }
                            
                            
                            BoardView(title: "Denominator", tasks: Denominator, backgroundColor: .red)
                                .dropDestination(for: String.self) {
                                    droppedDice,  location in
                                    print(droppedDice)
                                    
                                    // Its not possible to use a blue dice in a red section
                                    if droppedDice[0].contains("blue") {
                                        return false
                                    }
                                    
                                    // its not possible to drop the same dice in the same section
                                    for i in 0..<Denominator.count {
                                        if Denominator[i].imageName == droppedDice[0] {
                                            return false
                                        }
                                    }
                                    
                                    // Setup dice
                                    let firstDigit = Int(String(droppedDice[0].first!))
                                    
                                    if !finalDenominatorArray.contains(firstDigit!) {
                                        return false
                                    }
                                    
                                    let team = "red"
                                    Denominator.append(Dice(image: [Image(droppedDice[0])], imageName: droppedDice[0], value: firstDigit!, team: team))
                                    
                                    // Find dice in red, update the numerator stats and remove it
                                    for i in 0..<RedDices.count {
                                        if RedDices[i].imageName == droppedDice[0] {
                                            actualDenominatorArray.append(RedDices[i].value)
                                            actualDenominatorArray.sort()
                                            RedDices.remove(at: i)
                                            break
                                        }
                                    }
                                    checkIfIsCorrect()

                                    return true
                                }
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
                            //    Text("numeratorState")
//                                    .foregroundColor(actualNumeratorArray == finalNumeratorArray ? .green : .red)
//                                Text("Numerator: \(Numerator.count)")
//                                Text("Denominator: \(Denominator.count)")
//        //                        Spacer().frame(height: 50)
//                                Text("denominatorState")
//                                    .foregroundColor(actualDenominatorArray == finalDenominatorArray ? .green : .red)
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

                        Image("NormalMage")
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
                            self.showContent.toggle()
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
