//
//  ModalView.swift
//  TCA_Prac
//
//  Created by LS-MAC-00211 on 2023/08/25.
//

import SwiftUI
import ComposableArchitecture

struct ModelCore: Reducer {
  struct State: Equatable {
    
  }
  enum Action: Equatable {
    case didTapDismissButton
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case increase
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action  {
      case .didTapDismissButton:
        return .run { send in
          await send(.delegate(.increase))
          await dismiss()
        }
      case .delegate:
        return .none
      }
    }
  }
}

struct ModalView: View {
  let store: StoreOf<ModelCore>
  
  var body: some View {
    AlertView(title: "Back") {
      store.send(.didTapDismissButton)
    }
  }
}
