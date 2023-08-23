//
//  JailbrokenCheck.swift
//  RecipesApp
//
//  Created by andres paladines on 8/23/23.
//

import Foundation
import UIKit

extension UIDevice {
    
  var isSimulator: Bool {
    return TARGET_OS_SIMULATOR != 0
  }

  var isJailBroken: Bool {
    if UIDevice.current.isSimulator { return false }
    if JailBrokenHelper.hasCydiaInstalled() { return true }
    if JailBrokenHelper.containsSuspiciousApps() { return true }
    if JailBrokenHelper.hasSuspiciousSystemPaths() { return true }
    return JailBrokenHelper.canEditSystemFiles()
  }
}

private struct JailBrokenHelper {
  static func hasCydiaInstalled() -> Bool {
    return UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!)
  }


  static func containsSuspiciousApps() -> Bool {
    for path in suspiciousAppsPathToCheck {
      if FileManager.default.fileExists(atPath: path) {
        return true
      }
    }
    return false
  }


  static func hasSuspiciousSystemPaths() -> Bool {
    for path in suspiciousSystemPathsToCheck {
      if FileManager.default.fileExists(atPath: path) {
        return true
      }
    }
    return false
  }


  static func canEditSystemFiles() -> Bool {
    let jailBreakText = "Developer Insider"
      do {
        try jailBreakText.write(toFile: "/private/jailbreak.txt", atomically: true, encoding: .utf8)
        return true
      } catch {
        return false
      }
    }


  /**
   Add more paths here to check for jail break
  */
  static var suspiciousAppsPathToCheck: [String] {
    return [
      "/Applications/Cydia.app",
      "/Applications/blackra1n.app",
      "/Applications/FakeCarrier.app",
      "/Applications/Icy.app",
      "/Applications/IntelliScreen.app",
      "/Applications/MxTube.app",
      "/Applications/RockApp.app",
      "/Applications/SBSettings.app",
      "/Applications/WinterBoard.app",
      "/Applications/LibertyLite.app"
    ]
  }


  static var suspiciousSystemPathsToCheck: [String] {
    return [
      "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
      "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
      "/Library/MobileSubstrate/MobileSubstrate.dylib",
      "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
      "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
      "/bin/bash",
      "/bin/sh",
      "/etc/apt",
      "/etc/ssh/sshd_config",
      "/private/var/tmp/cydia.log",
      "/var/tmp/cydia.log",
      "/usr/bin/sshd",
      "/usr/libexec/sftp-server",
      "/usr/libexec/ssh-keysign",
      "/usr/sbin/sshd",
      "/var/cache/apt",
      "/var/lib/apt",
      "/var/lib/cydia",
      "/usr/sbin/frida-server",
      "/usr/bin/cycript",
      "/usr/local/bin/cycript",
      "/usr/lib/libcycript.dylib",
      "/var/log/syslog",
      "/private/var/lib/apt",
      "/private/var/lib/cydia",
      "/private/var/mobile/Library/SBSettings/Themes",
      "/private/var/stash"
    ]
  }
}
