

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

struct ImageLoader {
 
    static func loadImage(from urlString: String, completion: @escaping ((UIImage) -> Void)){
        
        //check if the image already exsits in cache
        //TODO: Currently, offline image loading isn't working. Hence, it's a issue which needs to be addressed and this code below for image caching isn't working. The app only runs when connected to wifi
        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            completion(cachedImage)
            return
        }
        
        //if not, make a url request
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let downloadedImage = UIImage(data: data)  {
                imageCache.setObject(downloadedImage,
                                     forKey:
                                        NSString(string: urlString))
                completion(downloadedImage)
            }
        }.resume()
    }
}
