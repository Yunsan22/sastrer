//
//  TouchEnterExit.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/14/23.
//

import SwiftUI
//first part
struct TouchEnterExit: ViewModifier {
  @GestureState private var dragLocation: CGPoint = .zero
  @State private var didEnter = false

  let onEnter: (() -> Void)?
  let onExit: (() -> Void)?

  func body(content: Content) -> some View {
    content
      .gesture(
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
          .updating($dragLocation) { value, state, _ in
            state = value.location
          }
      )
      .background(GeometryReader { geo in
        dragObserver(geo)
      })
  }

  private func dragObserver(_ geo: GeometryProxy) -> some View {
    if geo.frame(in: .global).contains(dragLocation) {
      DispatchQueue.main.async {
        didEnter = true
        onEnter?()
      }
    } else if didEnter {
      DispatchQueue.main.async {
        didEnter = false
        onExit?()
      }
    }
    return Color.clear
  }
}

extension View {
  func touchEnterExit(onEnter: (() -> Void)? = nil,
                      onExit: (() -> Void)? = nil) -> some View {
    self.modifier(TouchEnterExit(onEnter: onEnter, onExit: onExit))
  }
}
//second part
// A simple rect that tracks if the touch is currently inside it
// and adjusts its label and outline accordingly
struct GroupAwareRect: View {
  let id: Int
  let color: Color
  let isSelected: Bool
  let proxy: TouchEnterExitProxy<Int>

  var body: some View {
    ZStack {
      color
      if isSelected {
        Rectangle()
          .stroke(Color.black, lineWidth: 10)
      }
    }
    .frame(width: 150, height: 150)
    .touchEnterExit(id: id, proxy: proxy) // as simple as this
  }
}

struct GroupTouchEnterTouchExitTest: View {
  private let colors = [Color.red, .blue, .green, .orange]

  @State private var text = "Default"
  @State private var selection: Int? = nil

  var body: some View {
    VStack {
      Text(text)
      // the reader tracks the events and provides a proxy
      // that internal views can share
      TouchEnterExitReader(Int.self,
                           onEnter: { id in
        text = "Entered \(id)"
        selection = id
      },
                           onExit: { id in
        text = "Exited \(id)"
        selection = nil
      }) { proxy in
        HStack {
          ForEach(0..<4) { i in
            GroupAwareRect(id: i,
                           color: colors[i],
                           isSelected: i == selection,
                           proxy: proxy)
          }
        }
      }
    }
  }
}
//tehird part
class TouchEnterExitProxy<ID: Hashable> {
  let onEnter: ((ID) -> Void)?
  let onExit: ((ID) -> Void)?

  private var frames = [ID: CGRect]()
  private var didEnter = [ID: Bool]()

  init(onEnter: ((ID) -> Void)?,
       onExit: ((ID) -> Void)?) {
    self.onEnter = onEnter
    self.onExit = onExit
  }

  func register(id: ID, frame: CGRect) {
    frames[id] = frame
    didEnter[id] = false
  }

  func check(dragPosition: CGPoint) {
    for (id, frame) in frames {
      if frame.contains(dragPosition) {
        DispatchQueue.main.async { [self] in
          didEnter[id] = true
          onEnter?(id)
        }
      } else if didEnter[id] == true {
        DispatchQueue.main.async { [self] in
          didEnter[id] = false
          onExit?(id)
        }
      }
    }
  }
}

//forth part
struct TouchEnterExitReader<ID, Content>: View where ID : Hashable, Content : View {
  private let proxy: TouchEnterExitProxy<ID>
  private let content: (TouchEnterExitProxy<ID>) -> Content

  init(_ idSelf: ID.Type, // without this, the initializer can't infer ID type
       onEnter: ((ID) -> Void)? = nil,
       onExit: ((ID) -> Void)? = nil,
       @ViewBuilder content: @escaping (TouchEnterExitProxy<ID>) -> Content) {
    proxy = TouchEnterExitProxy(onEnter: onEnter, onExit: onExit)
    self.content = content
  }

  var body: some View {
    content(proxy)
      .gesture(
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
          .onChanged { value in
            proxy.check(dragPosition: value.location)
          }
      )
  }
}

//fitj part
struct GroupTouchEnterExit<ID>: ViewModifier where ID : Hashable {
  let id: ID
  let proxy: TouchEnterExitProxy<ID>

  func body(content: Content) -> some View {
    content
      .background(GeometryReader { geo in
        dragObserver(geo)
      })
  }

  private func dragObserver(_ geo: GeometryProxy) -> some View {
    proxy.register(id: id, frame: geo.frame(in: .global))
    return Color.clear
  }
}

extension View {
  func touchEnterExit<ID: Hashable>(id: ID, proxy: TouchEnterExitProxy<ID>) -> some View {
    self.modifier(GroupTouchEnterExit(id: id, proxy: proxy))
  }
}

//sixth part

