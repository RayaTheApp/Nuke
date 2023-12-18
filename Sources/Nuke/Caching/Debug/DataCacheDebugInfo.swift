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

  var data: Data? { try? Data(contentsOf: url) }

  var image: UIImage? {
    guard let data = data else { return nil }
    return UIImage(data: data)
  }

  var dataSize: String {
    guard let data = data else { return "n/a" }
    return ImageCacheDebugInfo.dataFormatter.string(fromByteCount: Int64(data.count))
  }
}
