////
////  TestFile.swift
////  Tailored
////
////  Created by Yunior Sanchez on 3/8/23.
////
//
//import Foundation
//import SwiftUI
//
//
//struct SectionIndex<ID, TitleContent>: ViewModifier where ID : Hashable, TitleContent : View {
//  let proxy: ScrollViewProxy
//  let sections: [ID]
//  @ViewBuilder let titleContent: (ID, Bool) -> TitleContent
//
//  @State private var selection: ID? = nil
//
//  func body(content: Content) -> some View {
//    ZStack {
//      content
//      // TouchEnterExitReader allows for tracking of finger movement over index shortcuts
//      TouchEnterExitReader(ID.self,
//                           onEnter: { id in
//        selection = id
//        withAnimation {
//          proxy.scrollTo(id)
//        }
//      },
//                           onExit: { id in
//        selection = nil
//      }) { touchEnterExitProxy in
//        HStack {
//          Spacer() // right-align the index
//          VStack { // the index itself
//            ForEach(sections, id: \.self) { section in
//              titleContent(section, selection == section)
//                .touchEnterExit(id: section, proxy: touchEnterExitProxy)
//                .onTapGesture {
//                  withAnimation {
//                    proxy.scrollTo(section)
//                  }
//                }
//              }
//            }
//          }
//      }
//    }
//  }
//}
//
//extension View {
//  func sectionIndex<ID, TitleContent>(proxy: ScrollViewProxy,
//                                      sections: [ID],
//                                      @ViewBuilder titleContent: @escaping (ID, Bool) -> TitleContent) -> some View
//  where ID : Hashable, TitleContent : View {
//    self.modifier(SectionIndex(proxy: proxy, sections: sections, titleContent: titleContent))
//  }
//}
//
//extension View {
//  func firstLetterSectionIndex(proxy: ScrollViewProxy, sections: [String]) -> some View {
//    self.modifier(SectionIndex(proxy: proxy, sections: sections, titleContent: { title, isSelected in
//      Text(title.prefix(1))
//        .font(.system(size: isSelected ? 32 : 16))
//        .fontWeight(isSelected ? .bold : .regular)
//        .foregroundColor(.blue)
//        .padding(.trailing, 3)
//    }))
//  }
//}
