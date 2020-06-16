//
//  SceneDelegate.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let square0 = [CoordinateValue(r: 0, c: 0, s: 0, v: 8),
                       CoordinateValue(r: 0, c: 1, s: 0, v: 2),
                       CoordinateValue(r: 0, c: 2, s: 0, v: 3),
                       CoordinateValue(r: 1, c: 1, s: 0, v: 9),
                       CoordinateValue(r: 2, c: 0, s: 0, v: 5),
                       CoordinateValue(r: 2, c: 1, s: 0, v: 7),
                       CoordinateValue(r: 2, c: 2, s: 0, v: 1)]
        let square1 = [CoordinateValue(r: 0, c: 0, s: 1, v: 9),
                       CoordinateValue(r: 0, c: 1, s: 1, v: 5),
                       CoordinateValue(r: 1, c: 0, s: 1, v: 2),
                       CoordinateValue(r: 1, c: 1, s: 1, v: 1),
                       CoordinateValue(r: 1, c: 2, s: 1, v: 8),
                       CoordinateValue(r: 2, c: 0, s: 1, v: 3),
                       CoordinateValue(r: 2, c: 1, s: 1, v: 4),
                       CoordinateValue(r: 2, c: 2, s: 1, v: 6)]
        let square2 = [CoordinateValue(r: 0, c: 0, s: 2, v: 4),
                       CoordinateValue(r: 0, c: 1, s: 2, v: 6),
                       CoordinateValue(r: 0, c: 2, s: 2, v: 1),
                       CoordinateValue(r: 1, c: 0, s: 2, v: 5),
                       CoordinateValue(r: 1, c: 1, s: 2, v: 3),
                       CoordinateValue(r: 1, c: 2, s: 2, v: 7),
                       CoordinateValue(r: 2, c: 0, s: 2, v: 2),
                       CoordinateValue(r: 2, c: 1, s: 2, v: 9)]
        let square3 = [CoordinateValue(r: 0, c: 0, s: 3, v: 1),
                       CoordinateValue(r: 0, c: 1, s: 3, v: 4),
                       CoordinateValue(r: 0, c: 2, s: 3, v: 7),
                       CoordinateValue(r: 1, c: 0, s: 3, v: 3),
                       CoordinateValue(r: 1, c: 1, s: 3, v: 6),
                       CoordinateValue(r: 1, c: 2, s: 3, v: 2),
                       CoordinateValue(r: 2, c: 0, s: 3, v: 9),
                       CoordinateValue(r: 2, c: 2, s: 3, v: 5)]
        let square4 = [CoordinateValue(r: 0, c: 0, s: 4, v: 6),
                       CoordinateValue(r: 0, c: 1, s: 4, v: 3),
                       CoordinateValue(r: 0, c: 2, s: 4, v: 2),
                       CoordinateValue(r: 1, c: 0, s: 4, v: 5),
                       CoordinateValue(r: 1, c: 1, s: 4, v: 8),
                       CoordinateValue(r: 1, c: 2, s: 4, v: 9),
                       CoordinateValue(r: 2, c: 1, s: 4, v: 7),
                       CoordinateValue(r: 2, c: 2, s: 4, v: 1)]
        let square5 = [CoordinateValue(r: 0, c: 0, s: 5, v: 9),
                       CoordinateValue(r: 0, c: 2, s: 5, v: 5),
                       CoordinateValue(r: 1, c: 0, s: 5, v: 1),
                       CoordinateValue(r: 1, c: 1, s: 5, v: 7),
                       CoordinateValue(r: 1, c: 2, s: 5, v: 4),
                       CoordinateValue(r: 2, c: 0, s: 5, v: 6),
                       CoordinateValue(r: 2, c: 2, s: 5, v: 3)]
        let square6 = [CoordinateValue(r: 0, c: 0, s: 6, v: 2),
                       CoordinateValue(r: 0, c: 1, s: 6, v: 1),
                       CoordinateValue(r: 0, c: 2, s: 6, v: 8),
                       CoordinateValue(r: 1, c: 1, s: 6, v: 5),
                       CoordinateValue(r: 1, c: 2, s: 6, v: 4),
                       CoordinateValue(r: 2, c: 0, s: 6, v: 7),
                       CoordinateValue(r: 2, c: 1, s: 6, v: 3),
                       CoordinateValue(r: 2, c: 2, s: 6, v: 9)]
        let square7 = [CoordinateValue(r: 0, c: 0, s: 7, v: 7),
                       CoordinateValue(r: 0, c: 2, s: 7, v: 5),
                       CoordinateValue(r: 1, c: 0, s: 7, v: 8),
                       CoordinateValue(r: 1, c: 1, s: 7, v: 2),
                       CoordinateValue(r: 1, c: 2, s: 7, v: 3),
                       CoordinateValue(r: 2, c: 0, s: 7, v: 1),
                       CoordinateValue(r: 2, c: 2, s: 7, v: 4)]
        let square8 = [CoordinateValue(r: 0, c: 0, s: 8, v: 3),
                       CoordinateValue(r: 0, c: 1, s: 8, v: 4),
                       CoordinateValue(r: 0, c: 2, s: 8, v: 6),
                       CoordinateValue(r: 1, c: 1, s: 8, v: 1),
                       CoordinateValue(r: 2, c: 0, s: 8, v: 8),
                       CoordinateValue(r: 2, c: 1, s: 8, v: 5),
                       CoordinateValue(r: 2, c: 2, s: 8, v: 2)]
        let squares = [square0, square1, square2, square3, square4, square5, square6, square7, square8]
        let coordinates = squares.flatMap { $0 }
        let startingGrid = StartingGridValues(grid: coordinates)
        let workingGrid = GridValues(grid: coordinates)
        let editState = EditState()
        let editGridValues = EditGridValues(grid: [])
        
        let contentView = ContentView()
            .environmentObject(SelectedCell())
            .environmentObject(UserAction())
            .environmentObject(startingGrid)
            .environmentObject(workingGrid)
            .environmentObject(editState)
            .environmentObject(editGridValues)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            window.rootViewController?.view.backgroundColor = UIColor(named: "dynamicBackground")
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

