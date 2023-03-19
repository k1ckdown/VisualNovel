//
//  DependencyContainer.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import Foundation
import UIKit

final class DependencyContainer {
    private lazy var stageRepository = StageRepositoryImpl()
}

// MARK: - StageRepositoryFactory

extension DependencyContainer: StageRepositoryFactory {
    func makeStageRepository() -> StageRepository {
        return stageRepository
    }
}

// MARK: - StartViewModelFactory

extension DependencyContainer: StartViewModelFactory {
    func makeStartViewModel(stageId: Int) -> StartViewModel {
        return StartViewModel(factory: self, stageId: stageId)
    }
}

extension DependencyContainer: WelcomeViewModelFactory {
    func makeWelcomeViewModel(stageId: Int) -> WelcomeViewModel {
        return WelcomeViewModel(factory: self, stageId: stageId)
    }
}

// MARK: - CoordinatorFactory

extension DependencyContainer: CoordinatorFactory {
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window, factory: self)
    }

    func makeStartCoordinator(navigationController: UINavigationController) -> StartCoordinator {
        return StartCoordinator(navigationController: navigationController, factory: self)
    }
    
    func makeWelcomeCoordinator(navigationController: UINavigationController, stageId: Int) -> WelcomeCoordinator {
        return WelcomeCoordinator(navigationController: navigationController, factory: self, stageId: stageId)
    }
}