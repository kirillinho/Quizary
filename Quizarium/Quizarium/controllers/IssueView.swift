import UIKit

class IssueView: UIViewController {
    
    @IBOutlet weak var issueAnimation: NSLayoutConstraint!
    @IBOutlet weak var scroll:   UIScrollView!
    @IBOutlet weak var forward:  UIButton!
    @IBOutlet weak var issueId:  UILabel!
    @IBOutlet weak var issue:    UILabel!
    
    let rest = RestConnect()
    let builder = ButtonBuilder()
    let lableBuilder = LabelBuilder()
    
    var attributes = [NSMutableAttributedString]()
    var answersBank = [Int: Result]()
    var buttons = [AnswerButton]()
    var annotations = [String]()
    var responses = [[Int]]()
    var answers = [Answer]()
    var index: Int = 0
     
     override func viewDidLoad() {
          startingIssue()
     }
     
     private func startingIssue() {
          print("Issue started")
          Util.waitForDownload(rest)
          let col = Colorization()
          for i in 0..<rest.getQuestions().count {
               attributes.append(col.painting(rest.getQuestions()[i].text!))
               annotations.append(rest.getQuestions()[i].annotation!)
          }
          write(index)
     }

     @IBAction func movementOnIssue(_ sender: UIButton) {
          switch sender {
               case forward:
                    index = index + 1
                    forwardAnim()
                    break;
               default:
                    index = index - 1
                    if (index != -1) { backwardAnim() }
                    break;
          }
          
          if (index < attributes.count && index > -1) {
               write(index)
          }
          else if (index == attributes.count) {
               let noAnswered = Util.countOfNoAnswered(answersBank, attributes.count)
               if (noAnswered.count > 0) {
                    alerting(noAnswered)
               } else {
                    printTotalResult()
               }
          }
          
          if (index == -1) { index = 0 }
     }
    
     public func write(_ index: Int) -> Void {
          builder.removeButtons(&buttons)
          
          answers = Util.getAnswersArray(rest, index)
          
          let shuffled:[Int] = answersBank[index] != nil ? (answersBank[index]!.getShuffled()) : Util.shuffle(answers.count)
          
          responses.append(shuffled)
          
          lableBuilder.printQuestion(issue, issueId, attributes[index], attributes.count, index)
          createAnswers(answers, shuffled)
          
          scroll.sizeToFit()
     }
    
     private func createAnswers(_ answers:[Answer], _ shuffled:[Int]) {
          var preBtn = UIButton()
          let select: Int = answersBank[index] != nil ? (answersBank[index]?.getIndex())! : 69
          for i in 0..<shuffled.count {
               let rnd: Int = shuffled[i]
               let text: String = "\(i+1)) \(answers[rnd].getAnswer())"
               let btn = builder.buildButton(text,i,preBtn,&buttons,scroll,issue)
               
               btn.clickAction {
                    self.builder.reChoose(&self.buttons)
                    self.answersBank[self.index] = Result(answers[rnd].getType(), i, shuffled, answers)
                    btn.setTitleColor(UIColor.darkGray, for: .normal)
               }
               
               if (select == i) {
                    btn.setTitleColor(UIColor.darkGray, for: .normal)
               }
               preBtn = btn
          }
     }
    
     private func printTotalResult() {
          let quiz = Quiz(Util.printTime(), attributes, answersBank, annotations)
          ResponseStore.addQuiz(quiz)
          let quizId = ResponseStore.getQuizs().count-1
          ResponseStore.setQuizId(quizId)
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
          let rv = storyBoard.instantiateViewController(withIdentifier: "ResultView") as! ResultView
          self.present(rv, animated:true, completion:nil)
     }
    
     public func alerting(_ noAnswered: [Int]) {
          let alert = UIAlertController(title: "", message: "There are unanswered questions. Return to the question? \(noAnswered)", preferredStyle: UIAlertControllerStyle.actionSheet)
          alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,
                                        handler: { action in
               self.index = noAnswered[0]-1
               self.write(self.index)
          }))
          
          alert.addAction(UIAlertAction(title: "Finish",
                                        style: UIAlertActionStyle.default,
                                        handler: { action in
               for i in noAnswered {
                    let shuffled = self.responses[i-1]
                    self.answersBank[i-1] = Result(false, 50, shuffled, self.answers)
               }
               self.printTotalResult()
          }))
          self.present(alert, animated: true, completion: nil)
     }
     
     private func backwardAnim() {
          UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
               self.issueAnimation.constant += self.view.bounds.width
               self.view.layoutIfNeeded()
          }, completion: nil)
          issueAnimation.constant -= self.view.bounds.width
     }
     
     private func forwardAnim() {
          UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
               self.issueAnimation.constant -= self.view.bounds.width
               self.view.layoutIfNeeded()
          }, completion: nil)
          issueAnimation.constant += self.view.bounds.width
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
