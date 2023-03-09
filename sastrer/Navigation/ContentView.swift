//
//  ContentView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .homes
    @EnvironmentObject var model: Model
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        ZStack(alignment: .bottom) {

                switch selectedTab {
                case .homes:
                    HomeView()
                case .measuresView:
                    CustomersMeasuresList()
                case .toDoss:
                    ToDoView()
                case .calendarVi:
                    CalendarItemView()
                }
 
            TabBar()
                .offset(y: model.showDetails ? 200 : 0)
        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear.frame(height: 44)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionServiceImpl())
            .environmentObject(Model())
            .environmentObject(LaunchScreenManager())
    }
}
