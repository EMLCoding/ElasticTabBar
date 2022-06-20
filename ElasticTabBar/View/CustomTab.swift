//
//  CustomTab.swift
//  ElasticTabBar
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct CustomTab: View {
    @Binding var currentTab: Tab
    @State var startAnimation: Bool = false
    
    var animation: Namespace.ID
    
    // Para almacenar el tamaño de la pantalla y la zona segura inferior
    var size: CGSize
    var bottomEdge: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(currentTab: $currentTab, tab: tab, animation: animation) { pressedTab in
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                        startAnimation = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            currentTab = pressedTab
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                            startAnimation = false
                        }
                    }
                }
            }
        }
        .background(
            ZStack {
                let animationOffset: CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
                // Para que se pueda ver bien en todos los dispositivos
                let offset: CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) : CGSize(width: animationOffset, height: 36)
                
                Rectangle()
                    .fill(.red)
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
                
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: offset.width, y:offset.height)
                
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
                    .offset(x: -offset.width, y:offset.height)
            }
                .offset(x: getStartOffset())
                .offset(x: getOffset())
            , alignment: .leading
        )
        .padding(.horizontal, 15)
        .padding(.top, 7)
        .padding(.bottom, bottomEdge == 0 ? 23 : bottomEdge)
    }
    
    func getStartOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
        // 45 es el tamaño del boton
        let center = (reduced - 45) / 2
        return center
    }
    
    // Para mover la forma "elastic" en función de la posicion del boton pulsado de la TabView
    func getOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
        let index = Tab.allCases.firstIndex { checkTab in
            return checkTab == currentTab
        } ?? 0
        
        return reduced * CGFloat(index)
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton: View {
    @Binding var currentTab: Tab
    
    var tab: Tab
    var animation: Namespace.ID
    
    var onTap: (Tab) -> ()
    
    var body: some View {
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(.red)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currentTab != tab {
                    onTap(tab)
                }
            }
    }
}
