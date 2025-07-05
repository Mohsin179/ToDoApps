//
//  ViewModelProtocol.swift
//  Neighbourly
//
//  Created by Faizan Mahmood on 19/01/2021.
//

import Foundation
import UIKit

protocol ViewModelType {
    var controller: UIViewController? {get set}
    func bootstrap()
}

// swiftlint:disable class_delegate_protocol
protocol ViewModelDelegate {
    func showAlert(title: String?, message: String)
    func showProgress(message: String?, fullScreen: Bool)
    func hideProgress()
}

//extension ViewModelDelegate where Self: ViewModelType {
//    func showProgress(message: String? = nil, fullScreen: Bool = true) {
//        DispatchQueue.main.async {
//            if let viewWithTag = self.controller?.view.viewWithTag(506) {
//                viewWithTag.removeFromSuperview()
//            }
//            if let viewWithTag = UIApplication.topViewController()?.view.viewWithTag(506) {
//                viewWithTag.removeFromSuperview()
//            }
//            if let viewWithTag = UIApplication.shared.keyWindow?.viewWithTag(506) {
//                viewWithTag.removeFromSuperview()
//            }
//            let progressView = ProgressView.init()
//            guard let controller = self.controller else {
//                return
//            }
//            if fullScreen {
//                progressView.showFullscreenProgress(forView: controller.view, withMessage: message)
//            } else {
//                progressView.showProgres(forView: controller.view, withMessage: message)
//            }
//        }
//    }
//    
//    func hideProgress() {
//        DispatchQueue.main.async {
//            if let viewWithTag = self.controller?.view.viewWithTag(506) {
//                viewWithTag.removeFromSuperview()
//            }
//            if let viewWithTag = UIApplication.shared.keyWindow?.viewWithTag(506) {
//                viewWithTag.removeFromSuperview()
//            }
//        }
//    }
//
//    func showAlert(title: String?, message: String) {
//        let titleString = (title == nil || title?.isEmpty ?? false) ? nil : title
//        DispatchQueue.main.async {
//            guard let controller = self.controller else {
//                return
//            }
//            AlertService.shared.showAlert(title: titleString, message: message,
//                                          buttonText: TranslationString.general_okay.value(),
//                                          alertType: AlertType.warning,
//                                          controller: controller)
//        }
//    }
//    
//    func showAlertWithHandler(title: String?, message: String, completionHandler: @escaping () -> Void) {
//        let titleString = (title == nil || title?.isEmpty ?? false) ? nil : title
//        DispatchQueue.main.async {
//            guard let controller = self.controller else {
//                return
//            }
//            AlertService.shared.showAlert(title: titleString, message: message,
//                                          buttonText: TranslationString.general_okay.value(),
//                                          alertType: AlertType.warning,
//                                          controller: controller) { _ in
//                completionHandler()
//            }
//        }
//    }
//    
//    func showEmptyDataView(_ isShow: Bool, for type: EmptyDataType = .chat) {
//        for subview in self.controller?.view.subviews ?? []
//        where subview is UITableView ||
//            subview is UICollectionView ||
//            subview is UIStackView {
//            (subview as? UITableView)?.showEmptyDataView(isShow, for: type)
//            (subview as? UICollectionView)?.showEmptyDataView(isShow, for: type)
//            (subview.subviews.first as? UITableView)?.showEmptyDataView(isShow, for: type)
//        }
//    }
//}

protocol ViewModelErrorDelegate {
    typealias ShowAlert = Bool
    var onErrorHandling: ((ShowAlert, String) -> Void)? { get set }
}
extension ViewModelErrorDelegate where Self: ViewModelType {}
