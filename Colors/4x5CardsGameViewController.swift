//
//  NewPlayGameViewController.swift
//  Colors
//
//  Created by yulin on 2020/12/6.
//

import UIKit


class FourXFiveCardsGameViewController: UIViewController {
    /// 在NewPlayGamerViewController 內
    @IBOutlet var cardsButtonView: [UIButton]!
    @IBOutlet weak var pairsFoundLable: UILabel!
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var movesLable: UILabel!
    var cards = [Card]()    /// 建立cards陣列-->Card struct 結構
    var currentTapCardTag :Int = 0  ///當前按鈕所分派到的 cardTag
    var lastTapCardTag :Int = 0  /// 上一次按鈕所分派到的 cardTag
    var readyToCompairs :Bool = false /// 是否為第二次翻牌？
    var moves : Int = 0 /// 所翻牌(配對)的次數
    var pairsFound : Int = 0 ///所配對成功的次數
    var totalKind : Int = 0 /// 卡片種類
    var minutes : Int = 0 /// 使用分鐘
    var minutesString = "" /// 使用分鐘-轉字串（格式須為 xx)
    var seconds : Int = 0 /// 使用秒數
    var secondsString = "" /// 使用秒數-轉字串 (格式須為 xx)
    var timer: Timer? = nil /// 設定timer 為 Timer型別 *不確定為何要有？
    var isplaying :Bool = false /// 紀錄是否已經在進行遊戲 --> 計時用
   
 
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        startGame()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func startGame(){
        
        cards = []
        currentTapCardTag = 0  ///當前按鈕所分派到的 cardTag
        lastTapCardTag = 0  /// 上一次按鈕所分派到的 cardTag
        readyToCompairs = false /// 是否為第二次翻牌？
        moves = 0 /// 所翻牌(配對)的次數
        pairsFound = 0 ///所配對成功的次數
        totalKind  = 0 /// 卡片種類
        minutes   = 0 /// 使用分鐘
        minutesString = "" /// 使用分鐘-轉字串（格式須為 xx)
        seconds  = 0 /// 使用秒數
        secondsString = ""
        movesLable.text = "\(moves)"
        
        
        var craetTag = 1
        moves = 0
        pairsFound = 0
        
            for card in cardsButtonView{
                
                card.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
                card.cornerRadius = 10
                
                setBoarderColor(shape: card)
              
                card.tag = craetTag
                card.setTitle("", for: .normal)
                
                let backGroundBlur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
                backGroundBlur.frame = card.bounds
                backGroundBlur.isUserInteractionEnabled = false
                card.insertSubview(backGroundBlur, at: 0 )
                
                let creatCard = Card(tag: craetTag)
                print (craetTag)
                craetTag += 1
                
                cards.append(creatCard)
                
                
            }
        /// 依照 cardsButtonView 內有的按鈕數量依序編號(1.....)並且製作卡片丟入cards陣列中
        /// *實際陣列依然從0開始
        
        var hue = 0
        var saturation  = 0
        var lightness = 0
        var courseType = "lightness"
        var kind = 1
        
        switch courseType {
        case "lightness":
            hue = Int.random(in: 0...360)
            saturation = Int.random(in: 0...100)
            for card in cards{
                print(card.tag)
            if (card.tag % 2) != 0{
                cards[card.tag-1].colorH = hue
                cards[card.tag-1].colorS = saturation
                cards[card.tag-1].colorBr = lightness
                cards[card.tag-1].kind = kind
                
                lightness = lightness + 10
                
            }else{
                cards[card.tag-1].colorH = hue
                cards[card.tag-1].colorS = saturation
                cards[card.tag-1].colorBr = lightness
                cards[card.tag-1].kind = kind
                kind += 1
            }
                print("Tag:\(card.tag)BR:\(cards[card.tag-1].colorBr)")
            }
        case "hue":
            lightness = Int.random(in: 0...360)
            saturation = Int.random(in: 0...360)
            for card in cards{
                print(card.tag)
                    
                    if (card.tag % 2) != 0{
                        hue = Int.random(in: 0...360)
                        cards[card.tag-1].colorH = hue
                        cards[card.tag-1].colorS = saturation
                        cards[card.tag-1].colorBr = lightness
                        cards[card.tag-1].kind = kind
                    }else{
                        cards[card.tag-1].colorH = hue
                        cards[card.tag-1].kind = kind
                        kind += 1
                    }
            }
                case "saturation":
                    hue = Int.random(in: 0...360)
                    lightness = Int.random(in: 0...100)
                    for card in cards{
                        print(card.tag)
                        if (card.tag % 2) != 0{
                        saturation = Int.random(in: 0...100)
                        cards[card.tag-1].colorH = hue
                        cards[card.tag-1].colorS = saturation
                        cards[card.tag-1].colorBr = lightness
                        cards[card.tag-1].kind = kind
                    }else{
                        cards[card.tag-1].colorH = hue
                        cards[card.tag-1].colorS = saturation
                        cards[card.tag-1].colorBr = lightness
                        cards[card.tag-1].kind = kind
                        kind += 1
                    }
                

              
                
            }
                default: break
               
                   
                }
       
            
        
        
        
        cards.shuffle()
        
        ///卡片依照關卡分配顏色（兩個兩個一組）。
        
        totalKind = kind - 1
        pairsFoundLable.text = "\(pairsFound)/\(totalKind)"
        
        ///紀錄卡片種類數量 與 初始化配對數量Lable
    
    }
    
  
    
    
    
    func startTimer(){
    
        if isplaying == false{
            isplaying = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            if self.seconds == 59{
                self.seconds = 0
                self.minutes += 1
            }else{
                self.seconds += 1
            }
        /// 設定計時器，秒&分
                
                if self.seconds < 10 {
                    self.secondsString = "0\(self.seconds)"
                }else{
                    self.secondsString = "\(self.seconds)"
                }
                if self.minutes<10{
                    self.minutesString = "0\(self.minutes)"
                }else{
                    self.minutesString = "\(self.minutes)"
                }
                
                self.timerLable.text = "\(self.minutesString):\(self.secondsString)"
            /// 格式化時間 MM:SS 並轉為字串丟回 timerLable
                
        })
            
        }
        
    }
    
    
    
    
    @IBAction func Cardsbutton(_ sender: UIButton) {
    
        startTimer() ///開始記錄時間
        currentTapCardTag = sender.tag ///紀錄按下的按鈕對應的卡片Tag
        sender.backgroundColor = UIColor(hue: CGFloat(Float(cards[sender.tag-1].colorH)/360), saturation: CGFloat(Float(cards[sender.tag-1].colorS)/100), brightness:CGFloat(Float( cards[sender.tag-1].colorBr)/100), alpha: 1)
        print(sender.backgroundColor)
//        sender.backgroundColor = UIColor(hue: CGFloat(Float(cards[sender.tag-1].colorH) / 360), saturation: 1, brightness: 1, alpha: 1)
//
        
        
        ///翻牌
        
        if readyToCompairs { ///判斷是否已翻兩張牌
            if cards[currentTapCardTag-1].kind != cards[lastTapCardTag-1].kind{ ///判斷是否配對成功
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self](_) in
                    cardsButtonView[currentTapCardTag-1].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
                    cardsButtonView[lastTapCardTag-1].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
                readyToCompairs = false
                lastTapCardTag = sender.tag
                } /// 配對失敗，在0.5秒後將 Current & Last的牌翻回黑色（cardsButtonView)
                /// 並且初始化readyToCpompairs
            }else{
               readyToCompairs = false
               pairsFound += 1
            } ///配對成功紀錄 +1
            
            
            moves += 1
            
            ///配對次數＋1
            
        }else{
            readyToCompairs = true
            lastTapCardTag = sender.tag
        } ///尚未翻兩張牌，將第一張牌Tag紀錄下來
        
        movesLable.text = "\(moves)/10"
        pairsFoundLable.text = "\(pairsFound)/\(totalKind)"
        ///丟回 配對次數與配對成功次數
        
        if moves == 10{
            
            let controller = UIAlertController(title: "遊戲結束", message: "是否要重新遊玩", preferredStyle: .alert)
            let okAction =  UIAlertAction(title: "豪", style: .default) { (_) in
                self.startGame()
            }
            let noActoin = UIAlertAction(title: "不好", style: .default, handler: nil)
            controller.addAction(okAction)
            controller.addAction(noActoin)
            
            present(controller, animated: true, completion: nil)
            
            
        }
        
    }
    

}



