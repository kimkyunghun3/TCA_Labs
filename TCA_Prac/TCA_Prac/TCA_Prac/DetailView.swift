//
//  DetailView.swift
//  TCA_Prac
//
//  Created by LS-MAC-00211 on 2023/08/25.
//

import SwiftUI
import ComposableArchitecture

struct DetailCore: Reducer {
  struct State: Equatable {
    var title: Content
  }
  
  enum Action: Equatable {
    case didTapBackButton
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case increaseNumber
    }
  }
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapBackButton:
        return .run { send in
          await send(.delegate(.increaseNumber))
          await dismiss()
        }
      case .delegate:
        return .none
      }
    }
  }
}

struct DetailView: View {
  let store: StoreOf<DetailCore>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Button {
        viewStore.send(.didTapBackButton)
      } label: {
        VStack {
          Text(viewStore.title.name)
          Text("Back")
        }
        .foregroundColor(.blue)
      }
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(store: .init(initialState: DetailCore.State(title: .init(name: "키위는 100점", score: 100)), reducer: {
      DetailCore()
    }))
  }
}
