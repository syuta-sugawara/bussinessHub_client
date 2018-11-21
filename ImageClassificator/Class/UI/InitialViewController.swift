import UIKit

public class InitialViewController: UIViewController {
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showVc()
    }
    public func showVc() {
        if let userInfo = UserInfo.getInfo() {
            ApiClient.setBasicAuthInfo(userInfo: userInfo)
            let vc = R.storyboard.projectsViewController.instantiateInitialVC()
            vc.modalPresentationStyle = .custom
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        } else {
            ApiClient.setBasicAuthInfo(userInfo: nil)
            let vc = R.storyboard.loginViewController.instantiateInitialVC()
            vc.modalPresentationStyle = .custom
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}
