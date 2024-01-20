//
//  MainViewController.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "cardCell", for: indexPath
            ) as? CardTableViewCell
        else { return UITableViewCell() }
        return cell
    }

}
