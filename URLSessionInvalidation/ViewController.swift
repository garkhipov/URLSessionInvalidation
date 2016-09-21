//
//  ViewController.swift
//  URLSessionInvalidation
//
//  Created by Gleb Arkhipov on 21/09/16.
//  Copyright © 2016 Gleb Arkhipov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var label: UILabel!

    @IBAction func startButtonTapped(_ sender: UIButton) {
        startButton.isEnabled = false

        // Create a session
        let config = URLSessionConfiguration.background(withIdentifier: UUID().uuidString)
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        log(text: "Session created")

        // Start downloading a file large enough to jump to background and return before it finishes.
        session.downloadTask(with: URL(string: "http://ipv4.download.thinkbroadband.com/50MB.zip")!).resume()

        // Try to invalidate it when the task finishes
        session.finishTasksAndInvalidate()
    }

    fileprivate func log(text: String) {
        DispatchQueue.main.async {
            self.label.text = text
        }
    }

}


extension ViewController : URLSessionDelegate
{
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        log(text: "Session invalidated with error: \(error)")
    }
}


extension ViewController : URLSessionDownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.progressView.progress = totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown
                ? Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                : 0.0;
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        log(text: "Download finished")
    }
}


extension ViewController : URLSessionTaskDelegate
{
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

        // Uncomment this line to make the session invalidate after all.
        // session.finishTasksAndInvalidate()

        log(text: "Task completed with error: \(error)\n(Not invalidated yet!)")
        DispatchQueue.main.async {
            self.startButton.isEnabled = true
        }
    }
}
