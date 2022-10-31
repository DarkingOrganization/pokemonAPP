
import UIKit

@IBDesignable

class StatsView: UIView {
    var viewControllerDetalles = StatsController()
    
    @IBOutlet weak private var stat1: UILabel!
    @IBOutlet weak private var stat2: UILabel!
    @IBOutlet weak private var stat3: UILabel!
    @IBOutlet weak private var stat4: UILabel!
    @IBOutlet weak private var stat5: UILabel!
    @IBOutlet weak private var stat6: UILabel!
    
    @IBOutlet weak private var LabelStats1: UILabel!
    @IBOutlet weak private var LabelStats2: UILabel!
    @IBOutlet weak private var LabelStats3: UILabel!
    @IBOutlet weak private var LabelStats4: UILabel!
    @IBOutlet weak private var LabelStats5: UILabel!
    @IBOutlet weak private var LabelStats6: UILabel!
    
    @IBOutlet weak private var progressStat1: UIProgressView!
    @IBOutlet weak private var progressStat2: UIProgressView!
    @IBOutlet weak private var progressStat3: UIProgressView!
    @IBOutlet weak private var progressStat4: UIProgressView!
    @IBOutlet weak private var progressStat5: UIProgressView!
    @IBOutlet weak private var progressStat6: UIProgressView!
    
    private let nibName = "StatsView"
    private var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func loaditems(stats: [Float]) {
        renameLabelStats()
        assignmentValueProgressBar(stats)
        septupLabelProgressBar(stats)
    }
    
    func assignmentValueProgressBar(_ stats: [Float]) {
        progressStat1.progress = Float(stats[0])
        progressStat2.progress = Float(stats[1])
        progressStat3.progress = Float(stats[2])
        progressStat4.progress = Float(stats[3])
        progressStat5.progress = Float(stats[4])
        progressStat6.progress = Float(stats[5])
    }
    
    func septupLabelProgressBar(_ stats: [Float]) {
        stat1.text = String(Int(stats[0] * 100))
        stat2.text = String(Int(stats[1] * 100))
        stat3.text = String(Int(stats[2] * 100))
        stat4.text = String(Int(stats[3] * 100))
        stat5.text = String(Int(stats[4] * 100))
        stat6.text = String(Int(stats[5] * 100))
    }
    
    func renameLabelStats() {
        LabelStats1.text = "Hp"
        LabelStats2.text = "Attack"
        LabelStats3.text = "Defense"
        LabelStats4.text = "Sp. Atk"
        LabelStats5.text = "Sp. Def"
        LabelStats6.text = "Speed"
    }
}
