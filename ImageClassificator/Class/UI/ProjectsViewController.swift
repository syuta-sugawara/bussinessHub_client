import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

public final class ProjectsViewController: UIViewController {
    typealias DataType = ClassificationResponse
    @IBOutlet weak var tableView: UITableView!

    var dataList: [DataType] = []
    var isDetailLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    @objc func logout(sender: Any?) {
        UserInfo.resetInfo()
        self.dismiss(animated: true) {
            AppDelegateAccessor.initialViewController.showVc()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ログアウト", style: UIBarButtonItemStyle.done, target: self, action: #selector(logout(sender:)))

        let refreshControl = UIRefreshControl()
        weak var wRefreshControl = refreshControl
        tableView.refreshControl = refreshControl

        isDetailLoading.subscribe(onNext: {
            if $0 {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: rx.disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .map { _  -> Bool? in
                guard let refreshControl = wRefreshControl else { return nil }
                return refreshControl.isRefreshing
            }
            .ignoreNil()
            .filter { $0 }
            .subscribe(onNext: { [weak wself = self] _ in
                wself?.fetchData(successClosure: { (results) in
                    wself?.updateData(dataList: results)
                }, completion: {
                    wRefreshControl?.endRefreshing()
                })
            }).disposed(by: rx.disposeBag)

        refreshControl.beginRefreshing()
        self.fetchData(successClosure: { [weak wself = self] (results) in
            wself?.updateData(dataList: results)
        }, completion: {
            wRefreshControl?.endRefreshing()
        })
    }

    private func updateData(dataList: [DataType]) {
        DispatchQueue.main.async {
            self.dataList = dataList
            self.tableView.reloadData()
        }
    }

    private func fetchData(successClosure: @escaping (_ results: [DataType]) -> Void, completion: @escaping () -> Void) {
        ClassificationsRepository.get { (result) in
            switch result {
            case let .success(value):
                successClosure(value.results)
            case let .failure(error):
                SVProgressHUD.showError(withStatus: error.message)
            }
            completion()
        }
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageSelectionViewController, let dataSet = sender as? ([ImageResponse], DataType) {
            vc.dataList = dataSet.0
            vc.projectData = dataSet.1
        }
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row].title
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard !isDetailLoading.value else { return }
        let data = self.dataList[indexPath.row]
        isDetailLoading.accept(true)
        ImagesRepository.getClassificationsImages(id: data.id) { [weak wself = self] (result) in
            wself?.isDetailLoading.accept(false)
            switch result {
            case let .success(value):
                wself?.performSegue(withIdentifier: "Detail", sender: (value.results, data))
            case let .failure(error):
                SVProgressHUD.showError(withStatus: error.message)
            }

        }
    }
}
