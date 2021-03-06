//
//  NewRestaurantVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 26/06/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantVC: UITableViewController {

    // MARK: - Properties
    private var isVisited = false
    private var newRestaurant: RestaurantMO!

    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Restaurant"
    }

    // MARK: - Actions
    @IBAction private func saveButtonPressed() {
        guard let name = nameTextField.text, let type = typeTextField.text, let phone = phoneTextField.text, let loc = locationTextField.text else { return }
        if validateInputs() {
            guard let appDel = UIApplication.shared.delegate as? AppDelegate  else { return }
            newRestaurant = RestaurantMO(context: appDel.persistentContainer.viewContext)
            newRestaurant.name = name
            newRestaurant.type = type
            newRestaurant.phone = phone
            newRestaurant.location = loc
            newRestaurant.isVisited = isVisited

            if let restImg = photoImageView.image {
                if let imageData = UIImagePNGRepresentation(restImg) { newRestaurant.image = imageData }
            }
            appDel.saveContext()
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction private func toggleVisitedButtons(sender: UIButton) {
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = .red
            noButton.backgroundColor = .lightGray
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = .lightGray
            noButton.backgroundColor = .red
        }
    }

    // MARK: - Private Methods
    private func validateInputs() -> Bool {
        guard let name = nameTextField.text, let type = typeTextField.text, let phone = phoneTextField.text, let loc = locationTextField.text else { return false }
        if name.isEmpty || type.isEmpty || loc.isEmpty || phone.isEmpty {
            return false
        } else {
            return true
        }
    }

    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Photo Picker Methods
extension NewRestaurantVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}
