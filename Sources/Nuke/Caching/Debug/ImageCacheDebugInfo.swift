//
//  ImageCacheDebugInfo.swift
//  Raya
//
//  Created by Pat Mulloy on 8/17/22.
//  Copyright © 2022 Raya. All rights reserved.
//

import UIKit

public struct ImageCacheDebugInfo: Hashable {

  public enum ImageType: String, CaseIterable {
    case place
    case sliced
    case ripsSmall
    case ripsMedium
    case ripsLarge
  }

  public let image: UIImage
  public let url: URL?
  public let cost: Int
  public let processorsInfo: String

  // Determine the image type based off the URL
  // Not the most robust solution, but it provides a solid approximation of the image type
  public var imageType: ImageType? {
    if url?.absoluteString.contains("lh3") == true {
      return .place
    } else if url?.absoluteString.contains("bestFill") == true {
      return .sliced
    } else if url?.absoluteString.contains("small") == true {
      return .ripsSmall
    } else if url?.absoluteString.contains("medium") == true {
      return .ripsMedium
    } else if url?.absoluteString.contains("large") == true {
      return .ripsLarge
    }
    return nil
  }

  public var dataSize: String {
    ImageCacheDebugInfo.dataFormatter.string(fromByteCount: Int64(cost))
  }

  static func urlFrom(_ text: String) -> URL? {
    let types: NSTextCheckingResult.CheckingType = .link
    guard let detector = try? NSDataDetector(types: types.rawValue) else { return nil }
    let matches = detector.matches(
      in: text,
      options: .reportCompletion,
      range: NSRange(location: 0, length: text.count)
    )
    return matches.compactMap({ $0.url }).first
  }

  static func processorsString(_ text: String) -> String {
    var string = ""
    if text.contains("ResizeImageProcessor") {
      string += "Resize,"
    }
    if text.contains("profileGradient") {
      string += "Profile Gradient"
    }
    return string
  }

  public static let dataFormatter: ByteCountFormatter = {
    let bcf = ByteCountFormatter()
    bcf.allowedUnits = [.useGB, .useMB, .useKB]
    return bcf
  }()
}
