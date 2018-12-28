//
//  UploadAvatarWorker.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct CTUploadAvatarWorker {
    private var image: UIImage
    private var fileName: String
    private var complete: ((_ url: String?) -> Void)?
    
    init(image: UIImage, fileName: String, complete: ((_ url: String?) -> Void)?) {
        self.image = image
        self.fileName = fileName
        self.complete = complete
    }
    
    func execute() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let bucketRef = storageRef.child(CTStorageBucket.avatar.rawValue)
        let imageRef = bucketRef.child(self.fileName)
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        imageRef.putData(data, metadata: nil, completion: { (meta, err) in
            imageRef.downloadURL(completion: { (link, err) in
                guard let link = link?.absoluteString, let userId = appSetting.userId else { return }
                let db = Helper.getUserDb()
                db.child(userId).child("avatar").setValue(link)
                appSetting.user?.avatar = link
            })
        })
    }
}
