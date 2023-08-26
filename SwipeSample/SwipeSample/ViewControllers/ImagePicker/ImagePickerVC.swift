//
//  ImagePickerVC.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import UIKit
import Photos

class ImagePickerVC: UIViewController {
    var images: [UIImage] = []
    var is1To1Enabled = false
    var selectedIndices: Set<Int> = []{
        didSet{
            selectBtn.isEnabled = !selectedIndices.isEmpty
        }
    }
    var selectedImages:[UIImage] = []
    var imagePickerDelegate:ImageSelectionProtocol?
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        collectionViewDelegate()
        fetchImages()
    }
    func registerCollectionViewCell(){
        collectionView.register(UINib(nibName:ImageCell.identifier , bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
    }
    
    func collectionViewDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
    }
    func fetchImages() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        let imageManager = PHImageManager.default()
        let imageOptions = PHImageRequestOptions()
        imageOptions.isSynchronous = true
        
        for index in 0..<fetchResult.count {
            imageManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: imageOptions) { (image, _) in
                if self.is1To1Enabled{
                    if let image = image, image.size.width == image.size.height {
                        //width == height makes sure on 1:1 images are picked
                        self.images.append(image)
                    }
                }else{
                    if let image = image {
                        
                        self.images.append(image)
                    }
                }
                
            }
        }
        collectionView.isHidden = images.isEmpty
        collectionView.reloadData()
    }
    
    @IBAction func cancelBtnCLicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func selectBtnClicked(_ sender: Any) {
        for selectedIndex in selectedIndices {
            let selectedPhoto = images[selectedIndex]
            selectedImages.append(selectedPhoto)
        }
        imagePickerDelegate?.finishedPickingImages(with: selectedImages)
        self.dismiss(animated: true)
    }
}

//MARK: COLLECTION VIEW DELEGATE
extension ImagePickerVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        let isSelected = selectedIndices.contains(indexPath.item)
        cell.galleryImageView.image = images[indexPath.row]
        cell.checkMark.isHidden = !isSelected
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndices.contains(indexPath.item) {
                selectedIndices.remove(indexPath.item)
            } else {
                selectedIndices.insert(indexPath.item)
            }
        collectionView.reloadItems(at: [indexPath])
    }
}



protocol ImageSelectionProtocol{
    func finishedPickingImages(with images:[UIImage])
}
