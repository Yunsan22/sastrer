//
//  CalendarView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/12/23.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {

    
    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        
        return view
    }
    //TODO: uncomment the func and adjust to take jobs due from the appstorage and Firebase if Internet is available
//    func makeCoordinator() -> Coordinator {
//
//    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }

    //TODO: uncomment the func and adjust to take jobs due from the appstorage and Firebase if Internet is available
//    class Coordinator: NSObject, UICalendarViewDelegate {
//
//        var parent: CalendarView
//
//        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//            return nil
//        }
//    }
}
