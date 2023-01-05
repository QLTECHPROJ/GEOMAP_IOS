//
//  CustomPhotoAlbum.swift
//  Geo_Map


import Foundation
import Photos

class MyAppPhotoAlbum: NSObject {
    
    static let albumName = "GEO MAP"
    
    static let shared = MyAppPhotoAlbum()
    
    private var assetCollection: PHAssetCollection!
    
    private override init() {
        super.init()
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
    }
    
    func saveImagesInGallary(completion: @escaping ((_ success: Bool) -> Void)){
        let dispatchGroup = DispatchGroup()
        var successCompletion : Bool = Bool()
        dispatchGroup.enter()
        MyAppPhotoAlbum.shared.checkAuthorizationWithHandler { success in
            if success{
                
            }
            successCompletion = success
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(successCompletion)
        }
    }
    
    func checkAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.checkAuthorizationWithHandler(completion: completion)
            })
        }
        else if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.createAlbumIfNeeded { (success) in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
            
        }
        else {
            completion(false)
        }
    }
    
    private func createAlbumIfNeeded(completion: @escaping ((_ success: Bool) -> Void)) {
        if let assetCollection = fetchAssetCollectionForAlbum() {
            // Album already exists
            self.assetCollection = assetCollection
            completion(true)
        } else {
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: MyAppPhotoAlbum.albumName)   // create an asset collection with the album name
            }) { success, error in
                if success {
                    self.assetCollection = self.fetchAssetCollectionForAlbum()
                    completion(true)
                } else {
                    // Unable to create album
                    completion(false)
                }
            }
        }
    }
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", MyAppPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    func save(image: UIImage) {
        self.checkAuthorizationWithHandler { (success) in
            if success, self.assetCollection != nil {
                PHPhotoLibrary.shared().performChanges({
                    let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                    if let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) {
                        let enumeration: NSArray = [assetPlaceHolder!]
                        albumChangeRequest.addAssets(enumeration)
                    }
                    
                }, completionHandler: { (success, error) in
                    if success {
                        print("Successfully saved image to Camera Roll.")
                    } else {
                        print("Error writing to image library: \(error!.localizedDescription)")
                    }
                })
                
            }
        }
    }
    
    func saveMovieToLibrary(movieURL: URL) {
        
        self.checkAuthorizationWithHandler { (success) in
            if success, self.assetCollection != nil {
                
                PHPhotoLibrary.shared().performChanges({
                    
                    if let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: movieURL) {
                        let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                        if let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) {
                            let enumeration: NSArray = [assetPlaceHolder!]
                            albumChangeRequest.addAssets(enumeration)
                        }
                        
                    }
                    
                }, completionHandler:  { (success, error) in
                    if success {
                        print("Successfully saved video to Camera Roll.")
                    } else {
                        print("Error writing to movie library: \(error!.localizedDescription)")
                    }
                })
                
                
            }
        }
        
    }
}

