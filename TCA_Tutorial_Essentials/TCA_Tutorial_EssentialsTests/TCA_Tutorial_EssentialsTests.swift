//
//  TCA_Tutorial_EssentialsTests.swift
//  TCA_Tutorial_EssentialsTests
//
//  Created by Eddy on 2023/08/15.
//

import XCTest
import ComposableArchitecture

@testable import TCA_Tutorial_Essentials

extension CounterFeature.Action: Equatable {
    public static func == (lhs: CounterFeature.Action, rhs: CounterFeature.Action) -> Bool {
        return true
    }
}

@MainActor
final class TCA_Tutorial_EssentialsTests: XCTestCase {

    var store: TestStoreOf<CounterFeature>!
    let clock = TestClock()

//    func testNumberFact() async {
//        store = TestStore(initialState: CounterFeature.State()) {
//            CounterFeature()
//        } withDependencies: {
//            $0.continuousClock = clock
//            $0.numberFact.fetch = { "\($0) is a good number" }
//        }
//
//        await store.send(.factButtonTapped) {
//            $0.isLoading = true
//        }
//
//        await store.receive(.factResponse("0 is a good number")) {
//            $0.isLoading = false
//            $0.fact = "0 is a good number"
//        }
//    }

//    func testCounter() async {
//
//        let clock = TestClock()
//
//        store = TestStore(initialState: CounterFeature.State()) {
//            CounterFeature()
//        } withDependencies: {
//            $0.continuousClock = clock
//        }
//
//        await store.send(.toggleTimerButtonTapped) {
//            $0.isTimerRunning = true
//        }
//
//        await clock.advance(by: .seconds(1))
//        await store.receive(.timerTick, timeout: .seconds(2)) {
//            $0.count = 1
//        }
//
//
//        await store.send(.toggleTimerButtonTapped) {
//            $0.isTimerRunning = false
//        }
//
////        await store.send(.plusButtonTapped) {
////            $0.count = 1
////        }
////        await store.send(.minusButtonTapped) {
////            $0.count = 0
////        }
//    }

    override func setUpWithError() throws {
        store = TestStore(
            initialState: .init(),
            reducer: {CounterFeature()},
            withDependencies: {
                $0.continuousClock = clock
                $0.numberFact.fetch = { "\($0) is a good number" }
            }
        )
    }

    override func tearDownWithError() throws {
        store = nil
    }

    func test_증가버튼() async {
        await store.send(.plusButtonTapped) {
            $0.count = 1
        }
    }

    func test_감소버튼() async {
        await store.send(.minusButtonTapped) {
            $0.count = -1
        }
    }

    func test_타이머() async {
           await store.send(.toggleTimerButtonTapped) {
               $0.isTimerRunning = true
           }

           await clock.advance(by: .seconds(3))

           await store.receive(.timerTick) { $0.count = 1 }
           await store.receive(.timerTick) { $0.count = 2 }
           await store.receive(.timerTick) { $0.count = 3 }

           await store.send(.toggleTimerButtonTapped) {
               $0.isTimerRunning = false
           }
       }

    func test_숫자테스트() async {
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }

        await store.receive(.factResponse("0 is a good number."), timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number"
        }
    }

}
