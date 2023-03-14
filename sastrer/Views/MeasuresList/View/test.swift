//
//  test.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/14/23.
//
import SwiftUI

//A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
let database: [String: [String]] = [
    
    
    "B": [
      
    ],
    "C": [
      
    ],
    "D": [
      
    ],
    "E": [
      
    ],
    "F": [
      
    ],
    "G": [
      
    ],
    "J": [
      
    ],
    "K": [
      
    ],
    "L": [
      
    ],
    "M": [
      
    ],
    "N": [
      
    ],
    "O": [
      
    ],
    "P": [
      
    ],
    "Q": [
      
    ],
    "R": [
      
    ],
    "S": [
      
    ],
    "T": [
      
    ],
    "U": [
      
    ],
    "V": [
      
    ],
    "W": [
      
    ],
    "X": [
      
    ],
    "Y": [
      
    ],
    "Z": [
      
    ],
  "I": [
    "iPhone", "iPhone 3G", "iPhone 3GS", "iPhone 4", "iPhone 4S", "iPhone 5", "iPhone 5C", "iPhone 5S", "iPhone 6", "iPhone 6 Plus", "iPhone 6S", "iPhone 6S Plus", "iPhone SE", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone X", "iPhone Xs", "iPhone Xs Max", "iPhone Xʀ", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone SE 2",

    "iPad", "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad 6", "iPad 7", "iPad Air", "iPad Air 2", "iPad Air 3", "iPad Mini", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad Mini 5", "iPad Pro 9.7-inch", "iPad Pro 10.5-inch", "iPad Pro 11-inch", "iPad Pro 11-inch 2", "iPad Pro 12.9-inch", "iPad Pro 12.9-inch 2", "iPad Pro 12.9-inch 3", "iPad Pro 12.9-inch 4",
    "iPod Touch", "iPod Touch 2", "iPod Touch 3", "iPod Touch 4", "iPod Touch 5", "iPod Touch 6"
  ],
  "A": [
    "Apple TV 2", "Apple TV 3", "Apple TV 4", "Apple TV 4K","Apple Watch", "Apple Watch Series 1", "Apple Watch Series 2", "Apple Watch Series 3", "Apple Watch Series 4", "Apple Watch Series 5"
  ],
  "H": [
    "HomePod"
  ]
]
let database2: [String: [ClientDataList]] = [
    
    
    "B": [
      
    ],
    "C": [
      
    ],
    "D": [
      
    ],
    "E": [
      
    ],
    "F": [
      
    ],
    "G": [
      
    ],
    "J": [
      
    ],
    "K": [
      
    ],
    "L": [
      
    ],
    "M": [
      
    ],
    "N": [
      
    ],
    "O": [
      
    ],
    "P": [
      
    ],
    "Q": [
      
    ],
    "R": [
      
    ],
    "S": [
      
    ],
    "T": [
      
    ],
    "U": [
      
    ],
    "V": [
      
    ],
    "W": [
      
    ],
    "X": [
      
    ],
    "Y": [
      
    ],
    "Z": [
      
    ],
  "I": [
//    "iPhone", "iPhone 3G", "iPhone 3GS", "iPhone 4", "iPhone 4S", "iPhone 5", "iPhone 5C", "iPhone 5S", "iPhone 6", "iPhone 6 Plus", "iPhone 6S", "iPhone 6S Plus", "iPhone SE", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone X", "iPhone Xs", "iPhone Xs Max", "iPhone Xʀ", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone SE 2",
//
//    "iPad", "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad 6", "iPad 7", "iPad Air", "iPad Air 2", "iPad Air 3", "iPad Mini", "iPad Mini 2", "iPad Mini 3", "iPad Mini 4", "iPad Mini 5", "iPad Pro 9.7-inch", "iPad Pro 10.5-inch", "iPad Pro 11-inch", "iPad Pro 11-inch 2", "iPad Pro 12.9-inch", "iPad Pro 12.9-inch 2", "iPad Pro 12.9-inch 3", "iPad Pro 12.9-inch 4",
//    "iPod Touch", "iPod Touch 2", "iPod Touch 3", "iPod Touch 4", "iPod Touch 5", "iPod Touch 6"
  ],
  "A": [
//    "Apple TV 2", "Apple TV 3", "Apple TV 4", "Apple TV 4K","Apple Watch", "Apple Watch Series 1", "Apple Watch Series 2", "Apple Watch Series 3", "Apple Watch Series 4", "Apple Watch Series 5"
  ],
  "H": [
//    "HomePod"
  ]
]


struct HeaderView: View {
  let title: String

  var body: some View {
    Text(title)
      .font(.title)
      .fontWeight(.bold)
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct RowView: View {
  let text: String

  var body: some View {
    Text(text)
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct testView: View {
    
  let devices: [String: [ClientDataList]] = database2

    @ObservedObject var models = ClientViewModel()
    
  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack {
          devicesList
        }
      }
      .overlay(sectionIndexTitles(proxy: proxy))
    }
    .navigationBarTitle("Measures")
  }

  var devicesList: some View {
      
    ForEach(devices.sorted(by: { (lhs, rhs) -> Bool in
      lhs.key < rhs.key
    }), id: \.key) { categoryName, devicesArray in
      Section(
        header: HeaderView(title: categoryName)
      ) {
        ForEach(devicesArray, id: \.id) { name in
            RowView(text: name.fullName)
        }
      }
    }
  }
    func makeintoformat() -> [String:[String]] {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".compactMap({ String($0) })
        
      
        let words = ["Apple", "Banana", "Blueberry", "Eggplant"]
        
        var result = [String:[String]]()
        
        
//        ForEach(models.clientInfo ( $0.fullName)) { names in
//            words.append(names)
//        }
        for letter in alphabet {
            result[letter] = []
            let matches = words.filter({ $0.hasPrefix(letter) })
            if !matches.isEmpty {
                for word in matches {
                    result[letter]?.append(word)
                }
            }
        }
        return result
        print(result)
    }
    
    
  func sectionIndexTitles(proxy: ScrollViewProxy) -> some View {
    SectionIndexTitles(proxy: proxy, titles: devices.keys.sorted())
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding()
  }
}

struct SectionIndexTitles: View {
  let proxy: ScrollViewProxy
  let titles: [String]
  @GestureState private var dragLocation: CGPoint = .zero

  var body: some View {
    VStack {
      ForEach(titles, id: \.self) { title in
        SectionIndexTitle(image:  title)
          .background(dragObserver(title: title))
      }
    }
    .gesture(
      DragGesture(minimumDistance: 0, coordinateSpace: .global)
        .updating($dragLocation) { value, state, _ in
          state = value.location
        }
    )
  }

  func dragObserver(title: String) -> some View {
    GeometryReader { geometry in
      dragObserver(geometry: geometry, title: title)
    }
  }

  func dragObserver(geometry: GeometryProxy, title: String) -> some View {
    if geometry.frame(in: .global).contains(dragLocation) {
      DispatchQueue.main.async {
        proxy.scrollTo(title, anchor: .center)
      }
    }
    return Rectangle().fill(Color.clear)
  }
    //A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
  func sfSymbol(for deviceCategory: String) {
    
    switch deviceCategory {
    case "I": break
    case "B": break
    case "C": break
    case "A": break
    case "D":  break
    case "H":  break
    case "E":  break
    case "F":  break
    case "G":  break
    case "J":  break
    case "K": break
    case "L": break
    case "M": break
    case "N":  break
    case "O":  break
    case "P": break
    case "Q":  break
    case "R":  break
    case "S":  break
    case "T":  break
    case "U": break
    case "V":  break
    case "W":  break
    case "X": break
    case "Y":  break
    case "Z":  break
    default:
        break
    }
//    return Image(systemName: systemName)
  }
}

struct SectionIndexTitle: View {
  let image: String

  var body: some View {

        Text(image)
          .foregroundColor(.blue)

  }
}

struct testView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      testView()
    }
  }
}
