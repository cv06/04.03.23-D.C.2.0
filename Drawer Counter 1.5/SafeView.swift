import SwiftUI

struct SafeViewModel {
    var enteredTexts: [String] = Array(repeating: "0", count: 12)
    var totalValue: Double = 0.0
}

struct SafeView: View {
    @Binding var selectedDrawerView: DrawerView
    @ObservedObject var drawerData: DrawerData
    @State private var viewModel = SafeViewModel()
    
    private let slimRedColor = Color(red: 0.89, green: 0.0, blue: 0.20)
    private let whiteColor = Color.white
    private let billDenominations = [100, 50, 20, 10, 5, 2, 1]
    private let coinDenominations = ["Quarters","Dimes", "Nickels", "Pennies", "Other"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    headerSection
                    billsSection
                    coinsSection
                    calculationsSection
                }
                .padding(.horizontal)
                .padding(.vertical, 60)
            }
        }
    }
    
    var headerSection: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Office")
                        .fontWeight(.heavy)
                        .font(.custom("DIN Condensed", size: 35))
                        .foregroundColor(.black.opacity(0.3))
                    Text("Safe Box & Rolled")
                        .fontWeight(.heavy)
                        .font(.custom("DIN Condensed", size: 50))
                        .foregroundColor(slimRedColor)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.enteredTexts = Array(repeating: "0", count: 12)
                    viewModel.totalValue = 0.0
                }) {
                    Text("Reset")
                        .font(.custom("DIN Condensed", size: 40))
                        .fontWeight(.black)
                        .foregroundColor(whiteColor)
                }
                .padding([.top, .leading, .trailing], 10)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(slimRedColor))
                .opacity(0.9)
            }
        }
    }
    
    var billsSection: some View {
        VStack {
            ForEach(0..<billDenominations.count) { i in
                let denomination = billDenominations[i]
                HStack {
                    Text("$\(denomination)")
                        .foregroundColor(slimRedColor)
                        .font(.custom("DIN Condensed", size: 34))
                        .bold()
                        .opacity(0.75)
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(slimRedColor)
                            .opacity(0.8)
                        TextField("Enter number of bills", text: $viewModel.enteredTexts[i])
                            .foregroundColor(whiteColor)
                            .multilineTextAlignment(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.enteredTexts[i]) { newValue in
                                drawerData.enteredTexts[0][i] = newValue
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width * 2 / 3 - 10, height: 40)
                    .zIndex(1)
                }
            }
        }
    }
    
    var coinsSection: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("The following is rolls of coins ")
                    .fontWeight(.heavy)
                    .font(.custom("DIN Condensed", size: 35))
                    .foregroundColor(.black.opacity(0.5))
            }
            ForEach(0..<coinDenominations.count) { i in
                let denomination = coinDenominations[i]
                HStack {
                    Text("\(denomination)")
                        .foregroundColor(slimRedColor)
                        .font(.custom("DIN Condensed", size: 34))
                        .bold()
                        .opacity(0.75)
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(slimRedColor)
                            .opacity(0.9)
                        TextField("0", text: $viewModel.enteredTexts[i + 7])
                            .foregroundColor(whiteColor)
                            .multilineTextAlignment(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.enteredTexts[i + 7]) { newValue in
                                drawerData.enteredTexts[0][i + 7] = newValue
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width * 1.5 / 3 - 10, height: 40)
                    .opacity(0.9)
                    .zIndex(1)
                }
            }
        }
    }
    
    var calculationsSection: some View {
        let billValues = [100, 50, 20, 10, 5, 2, 1]
        let coinValues = [10, 5, 2, 0.5, 1.0]
        
        let totalValue = viewModel.enteredTexts.enumerated().reduce(0.0) { result, tuple in
            let (i, valueString) = tuple
            let value = Double(valueString) ?? 0.0
            if i < 7 {
                return result + value * Double(billValues[i])
            } else {
                return result + value * Double(coinValues[i - 7])
            }
        }
        viewModel.totalValue = totalValue
        
        return VStack {
            HStack {
                Text("Safe Total:")
                    .fontWeight(.heavy)
                    .font(.custom("DIN Condensed", size: 35))
                    .foregroundColor(slimRedColor.opacity(0.9))
                
                Text("$\(viewModel.totalValue, specifier: "%.2f")")
                    .fontWeight(.heavy)
                    .font(.custom("DIN Condensed", size: 35))
                    .foregroundColor(slimRedColor.opacity(0.6))
            }
        }
        .padding(.bottom, 60.0)
    }
}

struct SafeView_Previews: PreviewProvider {
    static var previews: some View {
        SafeView(selectedDrawerView: .constant(.safe))
            .environmentObject(DrawerData())
    }
}


