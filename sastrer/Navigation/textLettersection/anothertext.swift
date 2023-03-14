//
//  anothertext.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/14/23.
//

import SwiftUI

struct SectionIndexTest: View {
  let contacts = [
    "A": ["Anne", "Alfred", "Allie"],
    "B": ["Beth", "Bert", "Bart"],
    "C": ["Chad"],
    "D": ["Don", "Dona", "Dierdre"],
    "E": ["Euphrasius", "Elmo"],
    "G": ["Gordan", "Gordon", "Goran"],
    "H": ["Herb", "Herbert", "Hertie"],
    "I": ["Ion"],
    "K": ["Kurt", "Kurtrus", "Kent"],
    "O": ["Oprah", "Oswald"],
    "P": ["Peter", "Percy", "Princess"],
    "R": ["Rand", "Ruth", "Rudy"],
    "S": ["Steve", "Stephen", "Stephanie"],
    "T": ["Tyrone", "Trevor", "Tundra"],
    "W": ["Wilfred", "Wynonna"],
  ]

  var body: some View {
    let sections = Array(contacts.keys.sorted())
    ScrollViewReader { proxy in
      List {
        ForEach(sections, id: \.self) { letter in
          Section(header: Text(letter)) {
            ForEach(contacts[letter]!, id: \.self) { contact in
              Text(contact)
            }
          }
          .id(letter) // necessary for ScrollViewProxy to work
        }
      }
      .firstLetterSectionIndex(proxy: proxy, sections: sections) // as simple as this
    }
  }
}

struct SectionIndexTest_Previews: PreviewProvider {
    static var previews: some View {
        SectionIndexTest()
    }
}
