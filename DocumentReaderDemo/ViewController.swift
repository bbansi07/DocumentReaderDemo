//
//  ViewController.swift
//  UIActivityDemo
//
//  Created by Bansi on 18/05/17.
//
//

import UIKit
import QuickLook

class ViewController: UIViewController,QLPreviewControllerDataSource,QLPreviewControllerDelegate,UIDocumentInteractionControllerDelegate{
    var documentInteractionController : UIDocumentInteractionController!
    let fileURL = "file:///Users/zeitechsolutions/Library/Developer/CoreSimulator/Devices/B6050867-6619-4651-B9FA-16B50FBA8DD3/data/Containers/Data/Application/EB4F8880-3742-4E4A-9E30-B51ECEF7F9A5/Library/Application%20Support/userFiles/2aqlk/jobjrq/jsz8rm/address(1).pdf"
    override func viewDidLoad() {
        super.viewDidLoad()
     let button = UIButton()
    button.setTitle("name", for: UIControlState.normal)
        print(button.titleLabel?.text ?? "")
    
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
        self.present(viewPDF, animated: true, completion: nil)
        
    }

    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        //let path = Bundle.main.path(forResource: "address", ofType: "pdf")
        
       
        
        let url = NSURL.fileURL(withPath: fileURL)
        
        return url as QLPreviewItem
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int{
        return 1
    }
    
    
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
    // MARK: UIDocument Interaction Controller
    func openShareActionSheet(_ sender: UIBarButtonItem) {
       // let url = NSURL.fileURL(withPath: fileURL)
       documentInteractionController = UIDocumentInteractionController(url: URL(fileURLWithPath: fileURL))
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

