import SwiftUI
import Foundation

enum DrawerView {
    case dineIn1
    case dineIn2
    case driveThru
    case safe
    case report
}

struct ContentView: View {
    @State private var selectedDrawerView: DrawerView = .dineIn1
    @StateObject var drawerData = DrawerData()
ß
    var content: some View {
        switch selectedDrawerView {
        case .dineIn1:
            return AnyView(DineInDrawer1View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData))
        case .dineIn2:
            return AnyView(DineInDrawer2View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData))
        case .driveThru:
            return AnyView(DriveThruDrawer3View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData))
        case .safe:
            return AnyView(SafeView(selectedDrawerView: $selectedDrawerView, drawerData: drawerData))

        case .report:
            return AnyView(ReportView(selectedDrawerView: $selectedDrawerView, drawerData: drawerData))
        }
    }

    var backgroundImage: some View {
        Image("slimLogoImg")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .opacity(selectedDrawerView == .report ? 0.1 : 0.2)
            .offset(x: -UIScreen.main.bounds.width * 1 / 3, y: UIScreen.main.bounds.width / 2)
            .animation(.easeInOut(duration: 0.3), value: selectedDrawerView)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundImage

            MainContent(selectedDrawerView: $selectedDrawerView)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))

            CustomNavBar(selectedDrawerView: $selectedDrawerView)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(red: 0.89, green: 0.0, blue: 0.20))
                .zIndex(1)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}



struct MainContent: View {
    @Binding var selectedDrawerView: DrawerView
    @ObservedObject var drawerData = DrawerData()
    
    var body: some View {
        TabView(selection: $selectedDrawerView) {
            DineInDrawer1View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData)
                .tag(DrawerView.dineIn1)
            
            DineInDrawer2View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData)
                .tag(DrawerView.dineIn2)
            
            DriveThruDrawer3View(selectedDrawerView: $selectedDrawerView, drawerData: drawerData)
                .tag(DrawerView.driveThru)
            
            SafeView(selectedDrawerView: $selectedDrawerView, drawerData: drawerData)
                 .tag(DrawerView.safe)

            ReportView(selectedDrawerView: $selectedDrawerView, drawerData: drawerData)
                .tag(DrawerView.report)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.5))
    }
}



struct CustomNavBar: View {
    @Binding var selectedDrawerView: DrawerView

    func navButton(imageName: String, view: DrawerView) -> some View {
        Button(action: {
                selectedDrawerView = view
        }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(selectedDrawerView == view ? Color.white.opacity(0.7) : Color.white)
                .frame(width: 37.5, height: 37.5)
        }
        .frame(maxWidth: .infinity)
    }


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0.0)
                .fill(Color(red: 0.89, green: 0.0, blue: 0.20))
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)

            HStack {
                navButton(imageName: "01.square.fill", view: .dineIn1)
                navButton(imageName: "02.square.fill", view: .dineIn2)
                navButton(imageName: "03.square.fill", view: .driveThru)
                navButton(imageName: "cube.box.fill", view: .safe)
                navButton(imageName: "doc.text.image.fill", view: .report)

            }
            .opacity(0.95)
            .padding(.bottom, 30)
            .padding(.horizontal, 10)
        }
        .frame(height: 115)
        .edgesIgnoringSafeArea(.all)
    }
}



struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(selectedDrawerView: .constant(.dineIn1))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

