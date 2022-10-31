//
//  WebViewVC.swift
//  NSC_iOS
//
//  Created by vishal parmar on 28/10/22.
//

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
        
        var loadUrl = "https://www.google.de/"
        
        if self.titleString == kContantUs {

            // Fix url
        }
        else if self.titleString == kAboutUs {
            
            // Fix url
        }
        self.webKitView.load(URLRequest(url: loadUrl.url()))
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
