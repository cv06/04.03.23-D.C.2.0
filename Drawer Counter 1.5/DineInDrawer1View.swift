import SwiftUI
import Foundation

struct DineInDrawer1View: View {
    @Binding var selectedDrawerView: DrawerView
    @ObservedObject var drawerData: DrawerData

    let slimRedColor = Color(red: 0.89, green: 0.0, blue: 0.20)
    let whiteColor = Color.white
    @State private var enteredTexts: [String] = Array(repeating: "0", count: 12)
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
                    Text("Dine-In")
                        .fontWeight(.heavy)
                        .font(.custom("DIN Condensed", size: 35))
                        .foregroundColor(.black.opacity(0.3))
                    Text("Drawer #1")
                        .fontWeight(.heavy)
                        .font(.custom("DIN Condensed", size: 50))
                        .foregroundColor(slimRedColor)
                }
                Spacer()
                Button(action: {
                    enteredTexts = Array(repeating: "0", count: 12)
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
        let billDenominations = [100, 50, 20, 10, 5, 2, 1]
        return VStack {
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
                        TextField("Enter number of bills", text: $enteredTexts[i])
                            .foregroundColor(whiteColor)
                            .multilineTextAlignment(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .keyboardType(.numberPad)
                    }
                    .frame(width: UIScreen.main.bounds.width * 2 / 3 - 10, height: 40)
                    .zIndex(1)
                }
            }
        }
    }
    var coinsSection: some View {
        let coinDenominations = ["Quarters","Dimes", "Nickels", "Pennies", "Rolled"]
        return VStack {
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
                        TextField("0", text: $enteredTexts[i + 7])
                            .foregroundColor(whiteColor)
                            .multilineTextAlignment(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .keyboardType(.numberPad)
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
            let coinValues = [0.25, 0.1, 0.05, 0.01, 1.0]
            
            let totalValue = Array(0..<7).reduce(0.0) { result, i in
                let value = Double(enteredTexts[i]) ?? 0.0
                return result + value * Double(billValues[i])
            } + Array(7..<12).reduce(0.0) { result, i in
                let value = Double(enteredTexts[i]) ?? 0.0
                return result + value * coinValues[i - 7]
            }
            let depositAmount = totalValue - 200.0
            
        return VStack {
                 HStack {
                     Text("Drawer Total:")
                         .fontWeight(.heavy)
                         .font(.custom("DIN Condensed", size: 35))
                         .foregroundColor(slimRedColor.opacity(0.9))
                     Text("$\(totalValue, specifier: "%.2f")")
                         .fontWeight(.heavy)
                         .font(.custom("DIN Condensed", size: 35))
                                         .foregroundColor(slimRedColor.opacity(0.6))
                                 }
                                 HStack {
                                     Text("Deposit Amount:")
                                         .fontWeight(.heavy)
                                         .font(.custom("DIN Condensed", size: 35))
                                         .foregroundColor(slimRedColor.opacity(0.9))
                                     
                                     Text("$\(depositAmount, specifier: "%.2f")")
                                         .fontWeight(.heavy)
                                         .font(.custom("DIN Condensed", size: 35))
                                         .foregroundColor(slimRedColor.opacity(0.6))
                                 }
                             }
                             .padding(.bottom, 60.0)            .onReceive(enteredTexts.publisher.collect(), perform: { _ in
                DispatchQueue.main.async {
                    drawerData.dineIn1TotalValue = totalValue
                    drawerData.dineIn1DepositAmount = depositAmount
                }
            })
        }
    }

    struct DineInDrawer1View_Previews: PreviewProvider {
        static var previews: some View {
            DineInDrawer1View(selectedDrawerView: .constant(.dineIn1), drawerData: DrawerData())
        }
    }
