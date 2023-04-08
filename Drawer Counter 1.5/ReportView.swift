import SwiftUI
import Foundation

struct ReportView: View {
    @Binding var selectedDrawerView: DrawerView
    @ObservedObject var drawerData: DrawerData

    var body: some View {
        ScrollView {
            VStack {
                drawerTotalsSection
                safeTotalsSection
                depositTotalsSection
                exportSection
            }
            .padding(.horizontal)
            .padding(.vertical, 60)
        }
    }
   
    var drawerTotalsSection: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("Drawer 1 Total: ")
                    Text("\(drawerData.totalDepositForDrawer(0), specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Drawer 2 Total: ")
                    Text("\(drawerData.totalDepositForDrawer(1), specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Drawer 3 Total: ")
                    Text("\(drawerData.totalDepositForDrawer(2), specifier: "%.2f")")
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Total Drawers: ")
                    Text("\(drawerData.totalDepositAmount, specifier: "%.2f")")
                    Spacer()
                }
            }
        }
    }
    
    var safeTotalsSection: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("Safe Total: ")
                    Text("\(drawerData.totalDepositForSafe, specifier: "%.2f")")
                    Spacer()
                }
            }
        }
    }
    
    var depositTotalsSection: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("Drawer 1 Deposit: ")
                    Text("\(drawerData.depositAmountForDrawer(0), specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Drawer 2 Deposit: ")
                    Text("\(drawerData.depositAmountForDrawer(1), specifier: "%.2f")")
                    Spacer()
                }
                HStack {
                    Text("Drawer 3 Deposit: ")
                    Text("\(drawerData.depositAmountForDrawer(2), specifier: "%.2f")")
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Total Deposit: ")
                    Text("\(drawerData.totalDepositAmount, specifier: "%.2f")")
                    Spacer()
                }
            }
        }
    }
    
    var exportSection: some View {
        ZStack(alignment: .leading) {
            VStack {
                Text("*Export section")
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
       ReportView(selectedDrawerView: .constant(.report), drawerData: DrawerData())
    }
}



