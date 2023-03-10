//
//  sastrerApp.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI
import Firebase

//final class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil ) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct sastrerApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    @StateObject var launchScreenManager = LaunchScreenManager()
   @StateObject var model = Model()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
//            ZStack {
                NavigationView {
                    switch sessionService.state {
                    case .loggedIn:
                        ContentView()
                            
                    case .loggedOut:
//                      
                        ModalView()
                           
                    case .loading:
                        LaunchScreenView()
                            
                    }
                  
                }
//            }
                .environmentObject(sessionService)
                .environmentObject(model)
//            .environmentObject(launchScreenManager)
//            .preferredColorScheme(.dark)
//            ContentView()
        }
        
    }
}
