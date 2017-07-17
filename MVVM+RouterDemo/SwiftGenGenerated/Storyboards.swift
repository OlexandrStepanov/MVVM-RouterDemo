// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case navigationControllerScene = "NavigationController"
    static func instantiateNavigationController() -> UINavigationController {
      guard let vc = StoryboardScene.Main.navigationControllerScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'NavigationController' is not of the expected class UINavigationController.")
      }
      return vc
    }

    case repoDetailsViewControllerScene = "RepoDetailsViewController"
    static func instantiateRepoDetailsViewController() -> MVVM_RouterDemo.RepoDetailsViewController {
      guard let vc = StoryboardScene.Main.repoDetailsViewControllerScene.viewController() as? MVVM_RouterDemo.RepoDetailsViewController
      else {
        fatalError("ViewController 'RepoDetailsViewController' is not of the expected class MVVM_RouterDemo.RepoDetailsViewController.")
      }
      return vc
    }

    case repoSearchViewControllerScene = "RepoSearchViewController"
    static func instantiateRepoSearchViewController() -> MVVM_RouterDemo.RepoSearchViewController {
      guard let vc = StoryboardScene.Main.repoSearchViewControllerScene.viewController() as? MVVM_RouterDemo.RepoSearchViewController
      else {
        fatalError("ViewController 'RepoSearchViewController' is not of the expected class MVVM_RouterDemo.RepoSearchViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
