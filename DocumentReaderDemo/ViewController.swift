//
//  ViewController.swift
//  UIActivityDemo
//
//  Created by Bansi Bhatt on 18/05/17.
//
//

import UIKit
import QuickLook

class ViewController: UIViewController,QLPreviewControllerDataSource,QLPreviewControllerDelegate,UIDocumentInteractionControllerDelegate{
    var documentInteractionController : UIDocumentInteractionController!
    
    let mainbundle = Bundle.main
    let url = Bundle.main.path(forResource: "mypdf", ofType: "pdf")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK:- QLPreviewController
    @IBAction func buttontapped (sender: UIButton)  {
    
        let viewPDF = QLPreviewController()
       
        viewPDF.dataSource = self
        viewPDF.delegate = self
       // self.accessibilityValue = url
       // self.accessibilityElementsHidden = false
        
        //Wants to add this button as share button on navigation Item
    /*
    let shareBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action:#selector(openShareActionSheet(_:)))
   
    viewPDF.navigationItem.setRightBarButton(shareBarButton, animated: true)
    */
          self.present(viewPDF, animated: true, completion: nil)
        
    }

    
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        print("Getting item")
        let mainbundle = Bundle.main
        let url = mainbundle.path(forResource: "mypdf", ofType: "pdf")!
        print(url)
        let doc = URL(fileURLWithPath: url)
        
        return doc as QLPreviewItem
        
        //directly open file
       /*
        let fileURL = "file:///Users/zeitechsolutions/Library/Developer/CoreSimulator/Devices/B6050867-6619-4651-B9FA-16B50FBA8DD3/data/Containers/Data/Application/EB4F8880-3742-4E4A-9E30-B51ECEF7F9A5/Library/Application%20Support/userFiles/2aqlk/jobjrq/jsz8rm/address(1).pdf"
        let url = NSURL.fileURL(withPath: fileURL)
        
        return url as QLPreviewItem
 */
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int{
        return 1
    }
    
    //This is not called
    //MARK:- UIDocumentInteractionController
    @IBAction func openUsingDocumentReder(_ sender : UIButton){
        documentInteractionController = UIDocumentInteractionController()
       
        documentInteractionController.delegate = self
    
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action:#selector(self.openShareActionSheet(_:)))
        
       
        
        self.navigationItem.rightBarButtonItem = shareBarButtonItem
       //  documentInteractionController.presentOpenInMenu(from: shareBarButtonItem , animated: true)
        
        
       // documentInteractionController.presentPreview(animated: true)
        //self.documentInteractionControllerViewForPreview(document)
      //  self.present(viewPDF, animated: true, completion: nil)

    }
    
    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool{
        return true
    }
    
    // MARK: UIDocument Interaction Controller
    func openShareActionSheet(_ sender: UIBarButtonItem) {
       // let url = NSURL.fileURL(withPath: fileURL)
       documentInteractionController = UIDocumentInteractionController(url: URL(fileURLWithPath: url))
        self.documentInteractionController.delegate = self
        self.documentInteractionController.presentOpenInMenu(from: sender, animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        
        return self.view
    }
    
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
    
}

