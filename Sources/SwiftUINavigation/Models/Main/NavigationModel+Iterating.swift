import SwiftUI
import Combine

@MainActor
public extension NavigationModel {
    var root: any NavigationModel {
        parent?.root ?? self
    }

    var predecessors: [any NavigationModel] {
        parent?.predecessorsIncludingSelf ?? []
    }

    var predecessorsIncludingSelf: [any NavigationModel] {
        (parent?.predecessorsIncludingSelf ?? []) + [self]
    }

    var successors: [any NavigationModel] {
        children.flatMap(\.successorsIncludingSelf)
    }

    var successorsIncludingSelf: [any NavigationModel] {
        [self] + children.flatMap(\.successorsIncludingSelf)
    }

    var canPresentIfWouldnt: Bool {
        parent == nil || parent?.isWrapperModel == false || parent?.presentedModel?.model === self
    }

    var nearestModelWhichCanPresent: (any NavigationModel)? {
        nearestChildrenModelWhichCanPresent ?? nearestModelWhichCanPresentFromParent?.topPresented
    }

    var topPresented: any NavigationModel {
        if let presentedModel = presentedModel?.model {
            presentedModel.topPresented
        } else {
            self
        }
    }

    var nearestChildrenModelWhichCanPresent: (any NavigationModel)? {
        let childrenModelsWhichCanPresent = childrenModelsWhichCanPresent
        return childrenModelsWhichCanPresent.compactMap { $0.presentedModel?.model }.first?.nearestChildrenModelWhichCanPresent
            ?? childrenModelsWhichCanPresent.last
    }

    var nearestModelWhichCanPresentFromParent: (any NavigationModel)? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestModelWhichCanPresentFromParent
        }
    }

    var childrenModelsWhichCanPresent: [any NavigationModel] {
        var models = [any NavigationModel]()
        if canPresentIfWouldnt {
            models.append(self)
        }
        models += children.flatMap { $0.childrenModelsWhichCanPresent }
        return models
    }
}
