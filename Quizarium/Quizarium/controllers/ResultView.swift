import UIKit

class ResultView: UIViewController {

    @IBOutlet weak var backward: UIButton!
    @IBOutlet weak var forward:  UIButton!
    @IBOutlet weak var issueId:  UILabel!
    @IBOutlet weak var issue:    UILabel!
    @IBOutlet weak var scroll:   UIScrollView!
    
    let lableBuilder = LabelBuilder()
    let builder = ButtonBuilder()
    
    var attributes = [NSMutableAttributedString]()
    var answersBank = [Int: Result]()
    var annotation = [String]()
    var buttons = [AnswerButton]()
    var index: Int = 0
    
    override func viewDidLoad() {
        print("ResultView is loaded")
        let quizId  = ResponseStore.getQuizId()
        attributes  = ResponseStore.getQuizs()[quizId].getAttributes()
        annotation  = ResponseStore.getQuizs()[quizId].getAnnotations()
        answersBank = ResponseStore.getQuizs()[quizId].getAnswersBank()
        index = attributes.count
        issueId.text = ""
        printTotalResult(quizId)
    }
    
    @IBAction func moveOnIssue(_ sender: UIButton) {
        index = sender == backward ? (index - 1) : (index + 1)
        
        if (index == attributes.count + 1 || index == -1){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mv = storyBoard.instantiateViewController(withIdentifier: "MainView") as! MainView
            self.present(mv, animated:true, completion:nil)
        }
        else if (index == attributes.count) {
            printTotalResult(ResponseStore.getQuizId())
        }
        else {
            writeQuiz(index)
        }
    }
    
    private func writeQuiz(_ quizId: Int) {
        let answers:[Answer] = answersBank[quizId]!.getAnswers()
        
        lableBuilder.printQuestion(issue, issueId, attributes[quizId], attributes.count, quizId)
        
        builder.removeButtons(&buttons)
        printAnswers(answersBank,answers)
    }
    
    private func printAnswers(_ answersBank:[Int: Result],_ answers:[Answer]) {
        var preBtn = UIButton()
        let preIndex: Int = answersBank[index]!.getIndex()
        let shuffled = answersBank[index]!.getShuffled()
    
        for x in 0..<shuffled.count {
            let i: Int = shuffled[x]
            let text: String = "\(x+1)) \(answers[i].getAnswer())"
            let result: Bool = answers[i].getType()
            let btn = builder.buildButton(text,x,preBtn,&buttons,scroll,issue)
            if (x == preIndex) {
                btn.setTitleColor(UIColor.red, for: .normal)
            }
            if (result) {
                btn.setTitleColor(UIColor.blue, for: .normal)
            }
            preBtn = btn
        }
        
        if (!annotation[index].isEmpty) {
            let annotationBtn = builder.createAnnotation(scroll, preBtn)
            annotationBtn.clickAction {
                self.printAnnotation(self.annotation[self.index])
            }
            buttons.append(annotationBtn)
        }
    }
    
    private func printAnnotation(_ annotation: String) {
        let ann = UIAlertController(title: "", message: annotation, preferredStyle: UIAlertControllerStyle.alert)
        ann.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(ann, animated: true)
    }
    
    private func printTotalResult(_ quizId: Int) -> Void {
        issue.text = "Total result:"
        builder.removeButtons(&buttons)
        var preBtn = UIButton()
        for i in 0..<answersBank.count {
            let result: Bool = answersBank[i]!.getResult()
            let end: String = result ? "Correctly" : "Wrong"
            let text: String = "\((i+1) )) \(end)"
            let btn = builder.buildButton(text,i,preBtn,&buttons,scroll,issue)
            btn.clickAction {
                self.index = i
                self.writeQuiz(i)
            }
            if (result) {
                btn.setTitleColor(UIColor.blue, for: .normal)
            }
            preBtn = btn
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
