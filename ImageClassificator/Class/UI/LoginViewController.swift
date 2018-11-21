import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SVProgressHUD

final public class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    public override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        idTextField.text = DebugConstants.id
        passTextField.text = DebugConstants.pass
        #endif

        Observable
            .combineLatest(idTextField.rx.text, passTextField.rx.text, isLoading) {
                return !($0 ?? "").isEmpty && !($1 ?? "").isEmpty && !$2
            }
            .asSignal(onErrorSignalWith: Signal.empty())
            .emit(to: loginButton.rx.isEnabled).disposed(by: rx.disposeBag)

        isLoading.subscribe(onNext: { isLoading in
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: rx.disposeBag)

        let tap: ControlEvent<Void> = loginButton.rx.tap
        tap.subscribe { [weak wself = self] (_) in
            guard let id = wself?.idTextField.text, !id.isEmpty else { return }
            guard let pass = wself?.passTextField.text, !pass.isEmpty else { return }

            wself?.isLoading.accept(true)
            UsersRepository.postMe(id: id, pass: pass, completion: { (result) in
                wself?.isLoading.accept(false)
                switch result {
                case .success:
                    UserInfo(id: id, pass: pass).saveInfo()
                    wself?.dismiss(animated: false) {
                        AppDelegateAccessor.initialViewController.showVc()
                    }
                case let .failure(error):
                    SVProgressHUD.showError(withStatus: error.message)
                }
            })
        }.disposed(by: rx.disposeBag)

    }

}
