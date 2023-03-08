//
//  LaunchScreenView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/3/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var sessionService : SessionServiceImpl
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseisAnimating: Bool = false
    @State private var secondPhaseisAnimating: Bool = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            background
            logo
        }
        .onReceive(timer) { input in
            
            switch sessionService.state {
            case .loggedIn:
                //frist phase with continous scaling
                withAnimation(.spring()) {
                    firstPhaseisAnimating.toggle()
                }
            case .loggedOut:
                //frist phase with continous scaling
                withAnimation(.spring()) {
                    secondPhaseisAnimating.toggle()
                }
                
            default: break
            }
            
           
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}

private extension LaunchScreenView {
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    var logo: some View {
        Image("logo")
            .scaleEffect(firstPhaseisAnimating ? 0.6: 1)
            .scaleEffect(secondPhaseisAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
