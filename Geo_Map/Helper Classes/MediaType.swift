//
//  MediaType.swift
//  Geo_Map
//
//  Created by Dhruvit on 12/08/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import UIKit
import Foundation

public enum MediaType {
    case document
    case image
    case audio
    case video
}

let mediaTypes : [String : MediaType] = [
    "html": MediaType.document,
    "htm": MediaType.document,
    "shtml": MediaType.document,
    "css": MediaType.document,
    "xml": MediaType.document,
    "mml": MediaType.document,
    "txt": MediaType.document,
    "jad": MediaType.document,
    "wml": MediaType.document,
    "htc": MediaType.document,
    
    "gif": MediaType.image,
    "jpeg": MediaType.image,
    "jpg": MediaType.image,
    "png": MediaType.image,
    "tif": MediaType.image,
    "tiff": MediaType.image,
    "wbmp": MediaType.image,
    "ico": MediaType.image,
    "jng": MediaType.image,
    "bmp": MediaType.image,
    "svg": MediaType.image,
    "svgz": MediaType.image,
    "webp": MediaType.image,
    
    "mid": MediaType.audio,
    "midi": MediaType.audio,
    "kar": MediaType.audio,
    "mp3": MediaType.audio,
    "ogg": MediaType.audio,
    "m4a": MediaType.audio,
    "ra": MediaType.audio,
    
    "3gpp": MediaType.video,
    "3gp": MediaType.video,
    "ts": MediaType.video,
    "mp4": MediaType.video,
    "mpeg": MediaType.video,
    "mpg": MediaType.video,
    "mov": MediaType.video,
    "webm": MediaType.video,
    "flv": MediaType.video,
    "m4v": MediaType.video,
    "mng": MediaType.video,
    "asx": MediaType.video,
    "asf": MediaType.video,
    "wmv": MediaType.video,
    "avi": MediaType.video
]

public struct FileType {
    
    let ext: String?
    
    public var value: MediaType? {
        guard let ext = ext else {
            return nil
        }
        return mediaTypes[ext.lowercased()]
    }
    
    public init(path: String) {
        ext = NSString(string: path).pathExtension
    }
    
    public init(path: NSString) {
        ext = path.pathExtension
    }
    
    public init(url: URL) {
        ext = url.pathExtension
    }
}
