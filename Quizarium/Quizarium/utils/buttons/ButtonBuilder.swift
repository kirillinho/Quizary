import UIKit

class ButtonBuilder {
    
    public init() {}
    
    public func buildButton(_ text: String,
                             _ i: Int,
                             _ preBtn: UIButton,
                             _ buttons: inout [AnswerButton],
                             _ scroll: UIScrollView,
                             _ issue: UILabel) -> AnswerButton {
        let btn = getButtonDefaultSettings(text)
        scroll.addSubview(btn)
        btn.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        if (i == 0) {
            btn.topAnchor.constraint(equalTo: issue.bottomAnchor).isActive = true
        } else {
            btn.topAnchor.constraint(equalTo: preBtn.bottomAnchor).isActive = true
        }
        buttons.append(btn)
        return btn
    }
    
    public func createAnnotation(_ scroll: UIScrollView,
                                 _ preBtn: UIButton) -> AnswerButton {
        let annotationBtn = getButtonDefaultSettings("Question annotation")
        scroll.addSubview(annotationBtn)
        annotationBtn.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        annotationBtn.topAnchor.constraint(equalTo: preBtn.bottomAnchor).isActive = true
        return annotationBtn
    }
    
    public func removeButtons(_ buttons: inout [AnswerButton]) -> Void {
        for btn in buttons {
            btn.removeFromSuperview()
        }
    }
    
    public func reChoose(_ buttons: inout [AnswerButton]) -> Void {
        for btn in buttons {
            btn.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    public func getButtonDefaultSettings(_ text: String) -> AnswerButton {
        let btn = AnswerButton()
        btn.setTitle(text, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
