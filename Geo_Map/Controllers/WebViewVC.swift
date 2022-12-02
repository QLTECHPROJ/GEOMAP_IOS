//
//  WebViewVC.swift

import UIKit
import WebKit

class WebViewVC: ClearNaviagtionBarVC {
    
    //----------------------------------------------------------------------------
    //MARK: - UIControl's Outlets
    //----------------------------------------------------------------------------
  
   
    
    //----------------------------------------------------------------------------
    //MARK: - Class Variables
    //----------------------------------------------------------------------------
    var webKitView : WKWebView = WKWebView()
    var titleString : String = ""
    
    var loadUrl = "https://www.google.de/"
    
    //----------------------------------------------------------------------------
    //MARK: - Memory management
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
       
    }
    
    //----------------------------------------------------------------------------
    //MARK: - Custome Methods
    //----------------------------------------------------------------------------
    //Desc:- Centre method to call Of View Config.
    
    func setUpView(){
        
        self.title = self.titleString
        self.view.backgroundColor = .colorBGSkyBlueLight
       
        if self.titleString == kAboutUs {
            
            // Fix url
        }
        self.webKitView.load(URLRequest(url: self.loadUrl.url()))
    }
    

    //----------------------------------------------------------------------------
    //MARK: - Action Methods
    //----------------------------------------------------------------------------
    
    @IBAction func btnBackTapped(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
 
    
    //----------------------------------------------------------------------------
    //MARK: - View life cycle
    //----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.webKitView.navigationDelegate = self
        self.webKitView.frame = CGRect(x: 0, y: kScreenHeight > ScreenHeightResolution.height667.rawValue ? 100 : 60, width: kScreenWidth, height: kScreenHeight - (kScreenHeight > ScreenHeightResolution.height667.rawValue ? 100 : 60))
        self.view.addSubview(self.webKitView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}

extension WebViewVC : WKNavigationDelegate,WKUIDelegate, UIDocumentInteractionControllerDelegate,URLSessionDownloadDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {

            print("fileDownload: check ::  \(url)")

            let extention = "\(url)".suffix(4)

            if extention == ".pdf" ||  extention == ".csv"{
                print("fileDownload: redirect to download events. \(extention)")
                DispatchQueue.main.async {
                    self.downloadPDF(tempUrl: "\(url)")
                }
                decisionHandler(.cancel)
                return
            }
        }

        decisionHandler(.allow)
    }
    
    func downloadPDF(tempUrl:String){
        print("fileDownload: downloadPDF")
        guard let url = URL(string: tempUrl) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        //showHUD(isShowBackground: true); //show progress if you need
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        print("fileDownload: documentInteractionControllerViewControllerForPreview")
        return self
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // create destination URL with the original pdf name
        print("fileDownload: urlSession")
        guard let url = downloadTask.originalRequest?.url else { return }
        print("fileDownload: urlSession \(url)")
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            myViewDocumentsmethod(PdfUrl:destinationURL)
            print("fileDownload: downloadLocation", destinationURL)
            DispatchQueue.main.async {
                
                GFunctions.shared.showSnackBar(message: "Download Completed")
            }
        } catch let error {
            print("fileDownload: error \(error.localizedDescription)")
        }
       // dismissHUD(isAnimated: false); //dismiss progress
    }
    
    func myViewDocumentsmethod(PdfUrl:URL){
        print("fileDownload: myViewDocumentsmethod \(PdfUrl)")
        DispatchQueue.main.async {
            let controladorDoc = UIDocumentInteractionController(url: PdfUrl)
            controladorDoc.delegate = self
            controladorDoc.presentPreview(animated: true)
        }
    }
}

