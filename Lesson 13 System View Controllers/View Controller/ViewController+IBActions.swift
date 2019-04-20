//
//  ViewController.swift
//  Lesson 13 System View Controllers
//
//  Created by Иван longrail on 20/04/2019.
//  Copyright © 2019 Иван longrail. All rights reserved.
//

import SafariServices
import MessageUI

extension ViewController {

    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = imageView.image else { return }
        
        let activityController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        present(activityController,animated: true)
    }
    
    @IBAction func safariButtonPressed(_ sender: Any) {
        let url = URL(string: "https://yandex.ru")!
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //JUST FOR TRYING:
        //imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        
        let alertController = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
             imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController,animated: true)
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
        
        guard MFMailComposeViewController.canSendMail() else {
            presentAlertControllerWithMessage("Device is not configured to send email")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["longrail@yandex.ru"])
        mailComposer.setSubject("Hello from lesson 13")
        mailComposer.setMessageBody("Hi!", isHTML: false)
        let imageData = imageView.image!.jpegData(compressionQuality: 0.2)!
        mailComposer.addAttachmentData( imageData, mimeType: "image/jpeg", fileName: "image.jpg")
        
        present(mailComposer, animated: true)
    }
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        
        guard MFMessageComposeViewController.canSendText() else {
            presentAlertControllerWithMessage("Messaging is not available")
            return
        }
        guard MFMessageComposeViewController.canSendAttachments() else {
            presentAlertControllerWithMessage("Attachments is not available")
            return
        }
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        
        messageComposer.recipients = ["89099038432"]
        messageComposer.body = "Hello from Lesson 13"
        let imageData = imageView.image!.pngData()!
        messageComposer.addAttachmentData(imageData, typeIdentifier: "image/jpeg", filename:  "image.jpg")
        
        present(messageComposer, animated: true)
    }
}


// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let data = info[UIImagePickerController.InfoKey.originalImage] else { return }
        let image = data as? UIImage
        imageView.image = image
        dismiss(animated: true)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}

// MARK: - MFMessageComposeViewControllerDelegate
extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
    }
}
