//
//  AlertView.swift
//  TCA_Prac
//
//  Created by LS-MAC-00211 on 2023/08/25.
//

import SwiftUI

struct AlertView: View {
  let title: String
  let action: () -> Void
  
  
  var body: some View {
    Button(title) {
      action()
    }
    .padding()
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(10)
  }
}

struct AlertView_Previews: PreviewProvider {
  static var previews: some View {
    AlertView(title: "", action: {} )
  }
}
