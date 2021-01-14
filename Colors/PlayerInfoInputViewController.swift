//
//  PlayerInfoInputViewController.swift
//  Colors
//
//  Created by yulin on 2020/12/10.
//

import UIKit

class PlayerInfoInputViewController: UIViewController {
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playeAgeTextField: UITextField!
    @IBOutlet weak var playerGenderSegment: UISegmentedControl!
    var creatPlayer = playerInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerGenderSegment.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0 )
        playerGenderSegment.selectedSegmentTintColor = UIColor.white
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        playerGenderSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor:UIColor.init(displayP3Red: 226/255, green: 123/255, blue: 123/255, alpha: 1   )]
        playerGenderSegment.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        
        addTapGesture()
    }
    
    
    @IBAction func playerNameInput(_ sender: Any) {
        
        if let playerName = playerNameTextField.text{
        creatPlayer.name = playerName
        }
        print (playerNameTextField.text!)
        print (creatPlayer.name)
    }
    

    
    @IBAction func playerAgeInput(_ sender: Any) {
        
        if let playerAgeString = playeAgeTextField.text{
        creatPlayer.age = Int(playerAgeString)!
        }
        
    }
    @IBAction func playerDenderInpute(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if let playerDender = playerGenderSegment.titleForSegment(at: index){
            creatPlayer.gender = playerDender
        }
    }


    func addTapGesture(){
            let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tap)
        }
    @objc private func hideKeyboard(){
            self.view.endEditing(true)
        }
    
    func Alert() -> Bool {
      
        var isdatafiled = true
        var alertMessage = "請輸入"
        
        if creatPlayer.name == "" {
            isdatafiled = false
            alertMessage += "姓名"
        }
        
        if creatPlayer.age == 0{
            isdatafiled = false
            alertMessage += "年紀"
        }
        
        
        if isdatafiled == false{
            
            let controller  = UIAlertController(title: "輸入資料不完整", message: alertMessage, preferredStyle: .alert)
            let okaction = UIAlertAction(title: "好的", style: .default) { (_) in
            }
            controller.addAction(okaction)
            present(controller, animated: true, completion: nil)
            
        }
        print(alertMessage)
        return isdatafiled
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
    
        
        if Alert() {
            if let controller = storyboard?.instantiateViewController(identifier: "3"){
                controller.modalPresentationStyle = .fullScreen
                present(controller, animated: true, completion: nil)
            }
            }else{
        }
    
    
    }
    
    
    @IBAction func TextInputAge_DidEndOnExit(_ sender: Any) {
        playeAgeTextField.resignFirstResponder()
    }
    
    @IBAction func TextInputName_DidEndOnExit(_ sender: Any) {
        playerNameTextField.resignFirstResponder()
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

