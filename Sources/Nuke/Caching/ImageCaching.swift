// The MIT License (MIT)
//
// Copyright (c) 2015-2023 Alexander Grebenyuk (github.com/kean).

import Foundation

/// In-memory image cache.
///
/// The implementation must be thread safe.
public protocol ImageCaching: AnyObject, Sendable {
    /// Access the image cached for the given request.
    subscript(key: ImageCacheKey) -> ImageContainer? { get set }

    /// Removes all caches items.
    func removeAll()
}

/// An opaque container that acts as a cache key.
///
/// In general, you don't construct it directly, and use ``ImagePipeline`` or ``ImagePipeline/Cache-swift.struct`` APIs.
public struct ImageCacheKey: Hashable, Sendable {
    let key: Inner
    let description: String
    let processors: [String]

    // This is faster than using AnyHashable (and it shows in performance tests).
    enum Inner: Hashable, Sendable {
        case custom(String)
        case `default`(CacheKey)
    }


    public init(key: String) {
        self.key = .custom(key)
        self.description = key
        self.processors = []
    }

    public init(request: ImageRequest) {
        self.key = .default(request.makeImageCacheKey())
        self.description = request.url?.description ?? ""
        self.processors = request.processors.map { $0.identifier }
    }
}
