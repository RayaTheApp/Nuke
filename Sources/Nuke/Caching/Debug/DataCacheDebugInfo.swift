//
//  DataCacheDebugInfo.swift
//  Nuke
//
//  Created by Pat Mulloy on 12/18/23.
//  Copyright © 2023 Raya. All rights reserved.
//

import Foundation
import UIKit

/// Provides information about the images stored in `DataCache`
/// It provides the disk URL, the image, and the size of the data for the image
public struct DataCacheDebugInfo: Hashable {
  let url: URL

  

  public var data: Data? { try? Data(contentsOf: url) }

  public var image: UIImage? {
    guard let data = data else { return nil }
    return UIImage(data: data)
  }

  public var dataSize: String {
    guard let data = data else { return "n/a" }
    return ImageCacheDebugInfo.dataFormatter.string(fromByteCount: Int64(data.count))
  }
}
