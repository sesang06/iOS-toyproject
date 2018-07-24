
import Foundation
import UIKit
import SnapKit

class PostTableViewController : UIViewController{
    let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.text = "heddllo world"
        tv.isScrollEnabled = false
        return tv
    }()
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    let headerId = "headerId"
    func setUpViews(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            
        }
        textView.delegate = self
 //       tableView.register(CustomTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(CustomTableViewHeader.self, forCellReuseIdentifier: headerId)
    }
    override func viewDidLoad() {
        setUpViews()
        setUpNavigationBar()
    }
    func setUpNavigationBar(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "글쓰기"
        let dissmissButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionDismiss))
        self.navigationItem.leftBarButtonItem = dissmissButton
        
    }
    @objc func actionDismiss(sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
}
extension PostTableViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        print("hae:")
//        return 100
//    }
   
}
extension PostTableViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        update()
    }
}
extension PostTableViewController : UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("rows")
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.item == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: headerId, for: indexPath) as! CustomTableViewHeader
            cell.postTableViewController = self
            print("deque!")
            cell.addSubview(textView)
            textView.snp.makeConstraints { (make) in
                make.top.equalTo(cell)
                make.trailing.equalTo(cell)
                make.leading.equalTo(cell)
                make.bottom.equalTo(cell)
                
            }
            return cell
        }
        
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
            cell.textLabel!.text = "foo"
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.item == 0){
            let size = CGSize(width: view.frame.width, height: CGFloat.infinity)
            let estimatedSize = textView.sizeThatFits(size)
            
            return estimatedSize.height
        }else {
            return 100
        }
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! CustomTableViewHeader
//        header.postTableViewController = self
//        return header
//    }
    func update(){
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
class CustomTableViewHeader: UITableViewCell {
    var postTableViewController : PostTableViewController?
    let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.text = "hello world"
        tv.isScrollEnabled = false
        return tv
    }()
    var heightConstraint : Constraint?
    func setUpViews(){
//        self.addSubview(textView)
//        textView.delegate = self
//        textView.snp.makeConstraints { (make) in
//            make.top.equalTo(self)
//            make.trailing.equalTo(self)
//            make.leading.equalTo(self)
//            make.bottom.equalTo(self)
//           // heightConstraint = make.height.equalTo(200).constraint
//        }
//        self.textViewDidChange(textView)
//
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        contentView.backgroundColor = .orange
    }
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        setUpViews()
//        contentView.backgroundColor = .orange
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CustomTableViewHeader : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
   //     heightConstraint?.update(inset: estimatedSize.height)
        postTableViewController?.update()
//        content?.text = textView.text
//        if (content?.heightConstraint?.layoutConstraints[0].constant != estimatedSize.height){
//            content?.heightConstraint?.update(offset: estimatedSize.height)
//            print(content?.heightConstraint)
//
//            content?.postEditorViewController?.resizeCollectionView()
//        }
    }
}
