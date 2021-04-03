
//
//  ImageDownloadManager.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//


import Foundation
import UIKit

// this is a singleton class
final class ImageDownloadManager {
    
    enum DownloadStatus {
        case Cached, InProgress, Pending
    }
    
    static var sharedInstance = ImageDownloadManager()
    // this is to prevent the class from making their own initializers
    private init() {}
    
    private var cache = NSCache<NSString, AnyObject>()
    typealias completionHandler = (String,UIImage?) -> ()
    private var downloadTasks = [String: (task: URLSessionTask, completion: completionHandler)]()
    private var session = URLSession(configuration: .default)
    
    func addDownloadTaskFor(urlString: String, completion: @escaping completionHandler) {
        
        switch checkImageStatus(url: urlString) {
        case .Cached:
            completion(urlString, cache.object(forKey: urlString as NSString) as? UIImage)
        case .InProgress:
            downloadTasks[urlString]?.completion = completion
        case .Pending:
            let url = URL(string: urlString)!
            let task = session.downloadTask(with: url, completionHandler: {[weak self] (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        let img  = UIImage(data: data)!
                        self?.cache.setObject(img, forKey: urlString as NSString)
                        self?.downloadTasks[urlString]?.completion(urlString, img)
                        self?.downloadTasks[urlString] = nil
                    })
                }
            })
            downloadTasks[urlString] = (task: task, completion: completion)
            task.priority = URLSessionTask.highPriority
            task.resume()
        }
        
    }
    
    func increasePriorityFor(urlString: String) {
        if checkImageStatus(url: urlString) == .InProgress {
            downloadTasks[urlString]?.task.priority = URLSessionTask.highPriority
        }
    }
    
    func decreasePriorityFor(urlString: String) {
        if checkImageStatus(url: urlString) == .InProgress {
            downloadTasks[urlString]?.task.priority = URLSessionTask.lowPriority
        }
    }
    
    private func checkImageStatus(url: String) -> DownloadStatus {
        if self.cache.object(forKey: url as NSString) != nil {
            //Cached Image
            return .Cached
        }else if let _ = downloadTasks[url] {
            //Download already in progress
            return .InProgress
        }
        return .Pending
    }
}

