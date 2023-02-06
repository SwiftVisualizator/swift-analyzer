//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

import Foundation

internal let smolSample = #"""
//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//

import Foundation


// MARK: - Math operation

private class A {
	
}

@Published public class B: A {

}

@main open class C: A  {

}
"""

internal let mediumSample = """
import Foundation
import UIKit
import Firebase
import FirebaseMessaging
import KazeData
import LastBillAPI
import ModuloCoreKit
import Intercom

typealias NotificationsAuthorizationCallback = (Bool) -> Void

// MARK: - NotificationManagerAuthorizationStatus

enum NotificationManagerAuthorizationStatus {
 case authorized
 case denied
 case notDetermined
 case unknown
}

// MARK: - NotificationManagerConfiguratorType

protocol NotificationManagerConfiguratorType {
 func configure()
 func askAuthorizationIfNeeded(completion: @escaping NotificationsAuthorizationCallback)
}

// MARK: - NotificationManagerOperatorType

protocol NotificationManagerOperatorType {
 var status: NotificationManagerAuthorizationStatus { get }

 func scheduleLocalNotification(
  identifier: String,
  title: String,
  subtitle: String,
  interval: TimeInterval,
  payload: [String: Any]
 )
 func removeNotificationFromScheduler(notificationId: String)
 func clearLPNS()
}

protocol NotificationManagerType: NotificationManagerConfiguratorType,
 NotificationManagerOperatorType {
}

final class NotificationManager: NSObject, NotificationManagerType {
 private(set) var status: NotificationManagerAuthorizationStatus = .notDetermined
 var deviceToken: String? {
  return Messaging.messaging().fcmToken
 }

 private let notificationCenter: UNUserNotificationCenter
 private var userSettings: UserPreferencesSettings
 private let userManager: CurrentUserManagerProtocol
 private let notificationActionManager: NotificationActionManagerProtocol

 init(
  notificationCenter: UNUserNotificationCenter,
  userSettings: UserPreferencesSettings,
  userManager: CurrentUserManagerProtocol,
  notificationActionManager: NotificationActionManagerProtocol
 ) {
  self.notificationCenter = notificationCenter
  self.userSettings = userSettings
  self.userManager = userManager
  self.notificationActionManager = notificationActionManager
 }

 func configure() {
  if isRunningTests { return }
  FirebaseApp.configure()
  notificationCenter.delegate = self
  Messaging.messaging().delegate = self
 }

 func askAuthorizationIfNeeded(completion: @escaping NotificationsAuthorizationCallback) {
  let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

  notificationCenter.getNotificationSettings { [notificationCenter] settings in
   let status = settings.authorizationStatus
   log.debug("APNS: Status: \(status)")
   DispatchQueue.main.async {
	switch status {
	case .notDetermined,
	  .provisional,
	  .ephemeral:
	 log.debug("APNS: requesting authorization")
	 notificationCenter.requestAuthorization(
	  options: authOptions,
	  completionHandler: { (success, error) in
	   let error = error?.localizedDescription ?? "no"
	   log.error("APNS: authorization: \(success), error: \(error)")
	   completion(success)
	  }
	 )
	case .authorized:
	 completion(true)
	default:
	 completion(false)
	}
   }
  }
 }

 func scheduleLocalNotification(
  identifier: String,
  title: String,
  subtitle: String,
  interval: TimeInterval,
  payload: [String: Any]
 ) {
  let content = UNMutableNotificationContent()
  content.title = title
  content.body = subtitle
  content.sound = .default
  content.userInfo = payload

  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
  let request = UNNotificationRequest(
   identifier: identifier,
   content: content,
   trigger: trigger
  )

  notificationCenter.add(request) { error in
   if let error = error {
	log.error("Failed to schedule notification: \(error)")
   }
  }
 }

 func removeNotificationFromScheduler(notificationId: String) {
  notificationCenter.removeDeliveredNotifications(withIdentifiers: [notificationId])
 }

 func clearLPNS() {
  notificationCenter.removeAllPendingNotificationRequests()
 }

}

extension NotificationManager: UNUserNotificationCenterDelegate {
 public func userNotificationCenter(
  _ center: UNUserNotificationCenter,
  willPresent notification: UNNotification,
  withCompletionHandler completion: @escaping (UNNotificationPresentationOptions) -> Void
 ) {
 }

 func userNotificationCenter(
  _ center: UNUserNotificationCenter,
  didReceive response: UNNotificationResponse,
  withCompletionHandler completionHandler: @escaping () -> Void
 ) {
  guard let payload = response.notification.request.content.userInfo as? [String: Any]
  else {
   completionHandler()
   return
  }

  if Intercom.isIntercomPushNotification(payload) {
   Intercom.handlePushNotification(payload)
   completionHandler()
   return
  }

  notificationActionManager.handleNotification(payload: payload)
  completionHandler()
 }
}

// MARK: - MessagingDelegate

extension NotificationManager: MessagingDelegate {
 public func messaging(
  _ messaging: Messaging,
  didReceiveRegistrationToken fcmToken: String?
 ) {
  let oldToken = userSettings.userPushToken
  if oldToken != fcmToken {
   userSettings.userPushToken = fcmToken
   userManager.updateProfile(completion: { _ in })
  }
 }
}

// MARK: - Convenient local authorization status initialization

private extension NotificationManagerAuthorizationStatus {
 init(from status: UNAuthorizationStatus) {
  switch status {
  case .authorized: self = .authorized
  case .denied: self = .denied
  case .notDetermined: self = .notDetermined
  case .provisional: self = .authorized
  case .ephemeral: self = .authorized
  @unknown default: self = .unknown
  }
 }
}
"""#

internal let programSample = """
//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation


// MARK: - Math operation

fileprivate enum MathOperation {
    
    case addition
    
    case subtraction
    
    case multiplication
    
    case division
    
    
    fileprivate static func perform(
        _ operation: MathOperation,
        with lhs: Double,
        and rhs: Double
    ) -> Double {
        switch operation {
        case .addition:
            return lhs + rhs
        case .subtraction:
            return lhs - rhs
        case .multiplication:
            return lhs * rhs
        case .division:
            return lhs / rhs
        }
    }
    
}


// MARK: - Computable expression

public protocol ComputableExpression {
    
    var leftArgument: Double { get }
    
    var rightArgument: Double { get }
    
    func computeResult() -> Double
    
}


// MARK: - Base expression

public class MathExpression: ComputableExpression, Codable {
    
    
    private let lhs: Double
    
    private let rhs: Double
    
    
    public init(lhs: Double, rhs: Double) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    
    public final var leftArgument: Double {
        return lhs
    }
    
    public final var rightArgument: Double {
        return rhs
    }
    
    public func computeResult() -> Double {
        fatalError("Not implemented for base class!")
    }
    
}


// MARK: Multiplication expression

public final class MultiplicationExpression: MathExpression {
    
    public override func computeResult() -> Double {
        return MathOperation.perform(
            .multiplication,
            with: leftArgument,
            and: rightArgument
        )
    }
    
}



// MARK: Addition expression

public class AdditionExpression: MathExpression {
    
    public override func computeResult() -> Double {
        return MathOperation.perform(
            .addition,
            with: leftArgument,
            and: rightArgument
        )
    }
    
}


public final class PrettyAdditionExpression: AdditionExpression {
    
    public func toString() -> String {
        return String(format: "%d + %d = %d\", arguments: [leftArgument, rightArgument, computeResult()])
    }
    
}


// MARK: Solving example

internal struct Solver {
    
    internal init() {
        
    }
    
    internal func solveAddition() {
        
        let additionExpresison = PrettyAdditionExpression(lhs: 9.0, rhs: 10.0)
        
        let isResultEqualTo19 = (additionExpresison.computeResult() == 19.0)
        
        if isResultEqualTo19 {
            print(additionExpresison.toString())
        }
        
    }
    
}
"""
