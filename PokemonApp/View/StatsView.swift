
import UIKit

@IBDesignable

class StatsView: UIView {
    var viewControllerDetalles = ViewControllerDetalles()
    var stats: [Float] = [0,1,2,3,4,5]
    var statsString: [String] = ["1","2"]
    
    @IBOutlet weak var stat1: UILabel!
    @IBOutlet weak var stat2: UILabel!
    @IBOutlet weak var stat3: UILabel!
    @IBOutlet weak var stat4: UILabel!
    @IBOutlet weak var stat5: UILabel!
    @IBOutlet weak var stat6: UILabel!
    
    @IBOutlet weak var LabelStats1: UILabel!
    @IBOutlet weak var LabelStats2: UILabel!
    @IBOutlet weak var LabelStats3: UILabel!
    @IBOutlet weak var LabelStats4: UILabel!
    @IBOutlet weak var LabelStats5: UILabel!
    @IBOutlet weak var LabelStats6: UILabel!
    
    @IBOutlet weak var progressStat1: UIProgressView!
    @IBOutlet weak var progressStat2: UIProgressView!
    @IBOutlet weak var progressStat3: UIProgressView!
    @IBOutlet weak var progressStat4: UIProgressView!
    @IBOutlet weak var progressStat5: UIProgressView!
    @IBOutlet weak var progressStat6: UIProgressView!
    
    
    let nibName = "StatsView"
    var contentView: UIView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        loaditems()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit() }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        
    }


private func loaditems() {
    renameLabelStats()
    
        assignmentValueProgressBar(stats)
        septupLabelProgressBar(stats)
}

private func assignmentValueProgressBar(_ stats: [Float]) {
    progressStat1.progress = Float(stats[0])
    progressStat2.progress = Float(stats[1])
    progressStat3.progress = Float(stats[2])
    progressStat4.progress = Float(stats[3])
    progressStat5.progress = Float(stats[4])
    progressStat6.progress = Float(stats[5])
}

private func septupLabelProgressBar(_ stats: [Float]) {
    stat1.text = String(Int(stats[0] * 100))
    stat2.text = String(Int(stats[1] * 100))
    stat3.text = String(Int(stats[2] * 100))
    stat4.text = String(Int(stats[3] * 100))
    stat5.text = String(Int(stats[4] * 100))
    stat6.text = String(Int(stats[5] * 100))
}

private func renameLabelStats() {
    LabelStats1.text = "Hp"
    LabelStats2.text = "Attack"
    LabelStats3.text = "Defense"
    LabelStats4.text = "Sp. Atk"
    LabelStats5.text = "Sp. Def"
    LabelStats6.text = "Speed"
}
}
