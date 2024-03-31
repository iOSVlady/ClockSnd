//
//  AppCoordinator.swift
//  ClockSnd
//
//  Created by Vlady on 27.03.2024.
//

import Foundation
import SwiftUI

enum MainCoordinatorPage: NavigationCoordinatorPage {
    var id: Int { self.hashValue }

    case undefined
    case basic
    case clock(clock: SndClock, scaleEffect: Double = 1.0)
    case onboarding

    var orderNumber: Int {
        switch self {
        case .undefined:
            0
        case .basic:
            1
        case .clock:
            2
        case .onboarding:
            3
        }
    }
}

enum MainCoordinatorSheet: String, NavigationCoordinatorSheet {
    var id: String { self.rawValue }

    case none
    case notImplemented
}

enum MainCoordinatorFullScreenCover: String, NavigationCoordinatorFullScreenCover {
    var id: String { self.rawValue }

    case backActionAlert
}

typealias MainFlowOnFinishedHandler = () -> Void

final class MainCoordinator: NavigationCoordinator {
    private var onFinished: MainFlowOnFinishedHandler?

    @Published var navigationStack: [MainCoordinatorPage] = []
    @Published var sheet: MainCoordinatorSheet?
    @Published var fullScreenCover: MainCoordinatorFullScreenCover?

    @Published var isAgreeTermsAndConditions: Bool = false
    @Published var isAgreePrivacyPolicy: Bool = false

    private(set) var targetPage: MainCoordinatorPage = .undefined
    var rootPageIndex: Int?
    var currentPage: MainCoordinatorPage { navigationStack.last ?? .undefined }
    var email: String = ""
    var isActiveFlow: Bool { currentPage != .undefined }

    init() {    }

    func reset() {
//        onFinished = nil
        rootPageIndex = nil
        dismissSheet()
        dismissFullScreenCover()
        targetPage = .undefined
        email = ""
        set(navigationStack: [])
    }

    func set(targetPage: MainCoordinatorPage) {
        self.targetPage = targetPage
    }

    func trySet(targetPage: MainCoordinatorPage) -> Bool {
        guard targetPage.orderNumber > currentPage.orderNumber else {
            return false
        }
        set(targetPage: targetPage)
        return true
    }

    func set(onFinished: @escaping MainFlowOnFinishedHandler) {
        self.onFinished = onFinished
    }

    @ViewBuilder
    func build(page: MainCoordinatorPage) -> some View {
        switch page {
        case .undefined:
            EmptyView()
        case .basic:
            TabBarView(viewModel: TabBarViewModel(coordinator: self))
        case .clock(let clock, let scaleEffect):
            ClockView(viewModel: ClockViewModel(clockModel: clock, coordinator: self), scaleEffect: scaleEffect)
        case .onboarding:
            OnboardingView(viewModel: OnboardingViewModel(coordinator: self))
        }
    }

    private var emptyViewWithBackButton: some View {
        VStack(spacing: 0) {
            
//            TopNavBar(title: "Back") { [weak self] in self?.pop() }
//                .foregroundColor(.white)
            Spacer()
        }
    }

    @ViewBuilder
    func build(sheet: MainCoordinatorSheet) -> some View {
        switch sheet {
        case .none:
            EmptyView()
        case .notImplemented:
            VStack {
                Spacer()
//                Image("")
                Spacer()
                Color.green.frame(height: 1)
                    .padding(.top, 16)
                Text("UNDER CONSTRACTION")
                    .foregroundStyle(Color.green)
                    .multilineTextAlignment(.center)
                Color.green.frame(height: 1)
                    .padding(.bottom, 16)
                Spacer()
                Button(action: { [weak self] in self?.dismissSheet() }, label: {
                    Text("dismiss")
                })
                Button(action: {
                    self.popToRoot()
                    self.dismissSheet()
                }, label: {
                    Text("pop to root")
                })
            }
            .padding(20)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder
    func build(fullScreenCover: MainCoordinatorFullScreenCover) -> some View {
        switch fullScreenCover {
        case .backActionAlert:
            EmptyView()
        }
    }
    
    @MainActor
    func getInitialRootPage() async -> MainCoordinatorPage {
        // Questions
        return targetPage
    }

    func setRootView(to page: MainCoordinatorPage, navigationStack: [MainCoordinatorPage] = []) {
        var temp: [MainCoordinatorPage] = [page]
        temp.append(contentsOf: navigationStack)
        rootPageIndex = self.navigationStack.endIndex
        set(navigationStack: temp)
    }

    func dismissFlow() {
        onFinished?()
        reset()
    }
}
