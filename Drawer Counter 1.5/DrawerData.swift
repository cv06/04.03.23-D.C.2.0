import Foundation
import Combine

class DrawerData: ObservableObject {
    @Published var enteredTexts: [[String]] = Array(repeating: Array(repeating: "0", count: 12), count: 5) {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var dineIn1TotalValue: Double = 0.0
    @Published var dineIn1DepositAmount: Double = 0.0

    var totalDepositForSafe: Double {
        var total = 0.0
        for i in 0..<3 {
            total += calculateDeposit(texts: enteredTexts[i])
        }
        return total
    }
    
    var totalDepositAmount: Double {
        return depositAmountForDrawer(0) + depositAmountForDrawer(1) + depositAmountForDrawer(2)
    }
    
    func depositAmountForDrawer(_ drawerIndex: Int) -> Double {
        return calculateDeposit(texts: enteredTexts[drawerIndex])
    }
    
    func totalDepositForDrawer(_ drawerIndex: Int) -> Double {
        return calculateDeposit(texts: enteredTexts[drawerIndex])
    }
    
    func calculateDeposit(texts: [String]) -> Double {
        let billValues = [100, 50, 20, 10, 5, 2, 1]
        let coinValues = [0.25, 0.1, 0.05, 0.01, 1.0]
        
        let totalValue = Array(0..<7).reduce(0.0) { result, i in
            let value = Double(texts[i]) ?? 0.0
            return result + value * Double(billValues[i])
        } + Array(7..<12).reduce(0.0) { result, i in
            let value = Double(texts[i]) ?? 0.0
            return result + value * coinValues[i - 7]
        }
        let depositAmount = totalValue - 200.0
        return depositAmount
    }
}
