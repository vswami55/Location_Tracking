//
//  BaseVC.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit

class BaseVC: UIViewController {

    var tap:UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    func showLoader()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       // appDelegate.showLoader()
    }
    func hideLoder()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       // appDelegate.HideLoader()
    }
    func setNavBar()  {
        // setMenuButton()
        self.setStatusBarColor()
         self.navigationController?.navigationItem.backBarButtonItem = nil
             self.navigationController?.navigationBar.barStyle = .default
             self.navigationController?.navigationBar.isTranslucent = true
             self.navigationController?.navigationBar.isHidden = false
             self.navigationController?.isNavigationBarHidden = false
             self.navigationItem.hidesBackButton = true
             self.navigationItem.backBarButtonItem = nil
        
        if let navFrame = self.navigationController?.navigationBar.frame {

            let newframe = CGRect(origin: .zero, size: CGSize(width: navFrame.width, height: (navFrame.height + UIApplication.shared.statusBarFrame.height) ))

            self.navigationController?.navigationBar.barTintColor = UIColor.gradientColorss(startColor: .init(red: 67.0/255.0, green: 141.0/255.0, blue: 226.0/255.0, alpha: 1.0), endColor: .init(red: 58.0/255.0, green: 217.0/255.0, blue: 119.0/255.0, alpha: 1.0), frame: newframe)

        }
        
        
        
        
        
//        let gradientLayer = CAGradientLayer()
//
//        let layerY = -UIApplication.shared.statusBarFrame.size.height as CGFloat
//        let layerHeight = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height as CGFloat
//        gradientLayer.frame = CGRect(x: 0, y: layerY, width: 1366, height: layerHeight)
////        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
////        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//            gradientLayer.masksToBounds = true
//        gradientLayer.colors = [UIColor(red: 67.0/255.0, green: 141.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor, UIColor(red: 58.0/255.0, green: 217.0/255.0, blue: 119.0/255.0, alpha: 1.0).cgColor]
//
//        self.navigationController?.navigationBar.layer.addSublayer(gradientLayer)
        self.navigationController?.navigationBar.tintColor = .white
    }
    func setStatusBarColor() {
        let MyStatusBarHeight = UIApplication.shared.statusBarFrame.height
        let myStatusView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: MyStatusBarHeight))
        UIApplication.shared.statusBarStyle = .lightContent
        myStatusView.backgroundColor = .white
//        myStatusView.layer.configureGradientBackground(UIColor(red: 67.0/255.0, green: 141.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor, UIColor(red: 58.0/255.0, green: 217.0/255.0, blue: 119.0/255.0, alpha: 1.0).withAlphaComponent(1).cgColor, view: myStatusView)
        
      
        
        self.view.addSubview(myStatusView)
    }
    func setLeftLogoButton()  {
      self.setNavBar()
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        myButton.addTarget(self, action: #selector(rightButton), for: .touchUpInside)
        myButton.setImage(#imageLiteral(resourceName: "MenuLogo"), for: .normal)
        let button1 = UIBarButtonItem() // action:#selector(Class.MethodName) for swift 3
        button1.customView = myButton
        self.navigationItem.leftBarButtonItem  = button1
    }
    func setRightMenuButton()  {
     self.setNavBar()
        self.navigationController?.navigationItem.backBarButtonItem = nil
         self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
//        let myButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuWhite"), style: .bordered, target: self, action: #selector(menuButtonHit))
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 31.0/255.0, green: 73.0/255.0, blue: 144.0/255.0, alpha: 1.0)
          self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationItem.leftBarButtonItem = myButton
        let button1 = UIBarButtonItem(image: UIImage(named: "Upgrade"), style: .plain, target: self, action: #selector(rightButtonn)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = button1
    }
    @objc  func rightButtonn(sender:UIButton) {
        print("gg")
            }
    @objc  func showCityPicker(sender:UIButton) {
    }
    func showAlert(message: String?, title:String?, otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String, cancelAction: ((UIAlertAction)-> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction))
        if otherButtons != nil {
            for key in otherButtons!.keys {
                alert.addAction(UIAlertAction(title: key, style: .default, handler: otherButtons![key]))
            }
        }
        present(alert, animated: true, completion: nil)
    }
    func setMenuButton()  {
       self.setNavBar()
        self.navigationController?.navigationItem.backBarButtonItem = nil
         self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
//        let myButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuWhite"), style: .bordered, target: self, action: #selector(menuButtonHit))
        self.navigationController?.navigationBar.barTintColor = .red//UIColor(red: 31.0/255.0, green: 73.0/255.0, blue: 144.0/255.0, alpha: 1.0)
          self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationItem.leftBarButtonItem = myButton
        let button1 = UIBarButtonItem(image: UIImage(named: "Back_w"), style: .plain, target: self, action: #selector(rightButton)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
    }
    func setBackButton()  {
        
        self.setNavBar()
           let button1 = UIBarButtonItem(image: UIImage(named: "Back_w") , style: .plain, target: self, action: #selector(backButtonHit)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
    }
    @objc func rightButton()  {
        self.setNavBar()
        let button1 = UIBarButtonItem(image: UIImage(named: "Upgrade") , style: .plain, target: self, action: #selector(rightButton)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = button1
    }
    func setTitle(title:String = "Inge App", size:CGFloat = 18) {
        self.setNavBar()
        let MyStatusBarHeight = self.navigationController?.navigationBar.frame.size.height
        let myTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: MyStatusBarHeight!))
        myTitleLabel.numberOfLines = 2
        myTitleLabel.font = UIFont.boldSystemFont(ofSize: size)
        myTitleLabel.text = title.capitalized
        myTitleLabel.adjustsFontSizeToFitWidth = true
        myTitleLabel.textAlignment = .center
        myTitleLabel.textColor = .white
        myTitleLabel.center = (self.navigationController?.navigationBar.center)!
        //        self.navigationController?.navigationItem.title?.addSubview(myTitleLabel)
        self.navigationItem.titleView = myTitleLabel
    }
    func MoveToViewController(storyBoard:String , identifier : String) {
        let myStoryBoard = UIStoryboard(name: storyBoard, bundle: .main)
       let myVC = myStoryBoard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
//    func borderColor(){
//        let myColor : UIColor = UIColor( red: 143.0/255.0, green: 143.0/255.0, blue:143.0/255.0, alpha: 1.0 )
//    }
    @objc func StaticDetail()
    {
//
//        let edit  = self.storyboard?.instantiateViewController(withIdentifier: "InvoiceDetailVC")as! InvoiceDetailVC
//
//        self.navigationController?.pushViewController(edit, animated: true)
//
    }
    @objc func InvoiceAction()
    {
       
//        let edit  = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionVC")as! DescriptionVC
//
//        self.navigationController?.pushViewController(edit, animated: true)
        
    }
    @objc func Description1()
    {
        
//        let edit  = self.storyboard?.instantiateViewController(withIdentifier: "Description1")as! Description1
//
//        self.navigationController?.pushViewController(edit, animated: true)
        
    }
//    @objc func callButton()
//    {
//        let elDrawer = self.navigationController?.parent as! KYDrawerController
//        elDrawer.setDrawerState(.opened, animated: true)
//   }
    func popBackkk(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }

    
    
    @objc func backButtonHit()
    {
       
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.kyDrawer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// Put this piece of code anywhere you like
extension BaseVC {
    func hideKeyboardWhenTappedAround() {
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func removeTap() {
        
        self.view.removeGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension BaseVC{
    
    func NavigateViewController(StoryBoardName:String,viewControllerIdentifier:String) {
        let myStoryBoard = UIStoryboard(name: StoryBoardName, bundle:.main)
        let myViewController = myStoryBoard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        self.navigationController?.pushViewController(myViewController, animated: true)
    }
    
    func fetchViewController(StoryBoardName:String,viewControllerIdentifier:String) -> UIViewController {
        let myStoryBoard = UIStoryboard(name: StoryBoardName, bundle:.main)
        let myViewController = myStoryBoard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        return myViewController
    }
    func PopViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    func backPopToVC(StoryBoardName:String,viewControllerIdentifier:String) {
        
        let myViewController = self.fetchViewController(StoryBoardName: StoryBoardName, viewControllerIdentifier: viewControllerIdentifier)
        
        for controller in self.navigationController!.viewControllers as Array {
            if type(of: controller) == type(of: myViewController) {
                self.navigationController!.popToViewController(controller, animated: true)
//                DataManagger.lastStoryBoard = nil
//                DataManagger.lastVC = nil
                break
            }
        }
    }
    
    
    
    
}


extension BaseVC : UIGestureRecognizerDelegate
{
    
}

extension CALayer {
    public func configureGradientBackground(_ colors:CGColor..., view:UIView){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: frame.height)
       gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
       gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = colors
        gradient.masksToBounds = true
        //gradient.locations = [0.0, 0.25, 0.75, 1.0]
        self.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    static func gradientColorss(startColor: UIColor, endColor: UIColor, frame: CGRect) -> UIColor? {
        let gradient = CAGradientLayer(layer: frame.size)
        gradient.frame = frame
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradient.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image)
    }
}




