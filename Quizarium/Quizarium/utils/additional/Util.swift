import Foundation

public class Util {
    
    private static let dtf = DateFormatter()
    public static var qestionIndex: Int = 0
    
     public static func shuffle(_ size: Int) -> [Int] {
          var arr = Array(0...size-1)
          var result = Array(repeating: 0, count: size)
          for x in 0..<result.count {
               let rnd: Int = Int(arc4random_uniform(UInt32(arr.count)))
               result[x] = arr[rnd]
               arr.remove(at: rnd)
          }
          return result
     }
    
    public static func getAnswersArray(_ rest: RestConnect,
                                       _ index: Int) -> [Answer] {
        var answers = [Answer]()
        answers.append(Answer(true, rest.getQuestions()[index].right!))
        for elem in rest.getQuestions()[index].wrong! {
            answers.append(Answer(false, elem))
        }
        return answers
    }
    
    public static func countOfNoAnswered(_ answerMap:[Int: Result],
                                         _ count: Int) -> [Int] {
        var noAnswered = [Int]()
        for x in 0..<count {
            if(answerMap[x]==nil) {
                noAnswered.append(x+1)
            }
        }
        return noAnswered
    }
    
     public static func printTime() -> String {
          dtf.dateFormat = "dd.MM.yy h:mm"
          return dtf.string(from: NSDate() as Date)
     }
    
     public static func waitForDownload(_ rest: RestConnect) {
          var download = true
          while (download) {
               if (rest.getQuestions().count > 0) {
                    download = false
               }
          }
     }
}
