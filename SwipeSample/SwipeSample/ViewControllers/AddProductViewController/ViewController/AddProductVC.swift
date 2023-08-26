//
//  AddProductVC.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import UIKit

class AddProductVC: UIViewController {

    @IBOutlet weak var imageAspectBtn: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var addImageView: CornerRadiusView!
    @IBOutlet weak var productTypeTableView: UITableView!
    @IBOutlet weak var taxTf: UITextField!
    @IBOutlet weak var productPriceTf: UITextField!
    @IBOutlet weak var productNameTf: UITextField!
    var images = [UIImage]()
    var productTypes = ["Mobile","Laptop"]
    var viewModel = AddProductViewModel()
    var successDelegate:AddProductSuccessDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.successDelegate = self
        setupNavigationBar()
        registerReusableCells()
        assignDelegates()
        setupimageAspectBtn()
    }
    func setupimageAspectBtn(){
        imageAspectBtn.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
        imageAspectBtn.layer.borderColor = UIColor.lightGray.cgColor
        imageAspectBtn.layer.borderWidth = 0.5
        imageAspectBtn.layer.cornerRadius = 5
        imageAspectBtn.setImage(nil, for: .normal)
        imageAspectBtn.setImage(UIImage(named: "ic_check"), for: .selected)
    }
    @objc func checkBoxAction(){
        imageAspectBtn.isSelected = !imageAspectBtn.isSelected
    }
    func setupNavigationBar(){
        title = "Add Product"
        navigationItem.largeTitleDisplayMode = .never
    }
    func assignDelegates(){
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        productTypeTableView.delegate = self
        productTypeTableView.dataSource = self
    }
    func registerReusableCells(){
        imagesCollectionView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.identifier)
        productTypeTableView.register(UINib(nibName: ProductTypeCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTypeCell.identifier)
    }
    
    @IBAction func addImageBtnClicked(_ sender: Any) {
        let vc = ImagePickerVC()
        vc.imagePickerDelegate = self
        vc.is1To1Enabled = imageAspectBtn.isSelected
        self.present(vc, animated: true)
    }
    
    @IBAction func addProductBtnCLicked(_ sender: Any) {
        viewModel.productName = productNameTf.text ?? ""
        viewModel.productTax = taxTf.text ?? ""
        viewModel.productPrice = productPriceTf.text ?? ""
        viewModel.productImages = images
        viewModel.validation()
    }
}
//MARK: TABLE VIEW DELEGATE
extension AddProductVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTypeCell.identifier, for: indexPath) as! ProductTypeCell
        cell.typeNameLbl.text = productTypes[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProductTypeCell
        cell.checkmark.isHidden = false
        viewModel.productType = productTypes[indexPath.row]
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProductTypeCell
        cell.checkmark.isHidden = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//MARK: COLLECTION VIEW DELEGATE
extension AddProductVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.galleryImageView.image = images[indexPath.row]
        cell.checkMark.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
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
}

//MARK: IMAGE PICKER DELEGATE
extension AddProductVC:ImageSelectionProtocol{
    func finishedPickingImages(with images: [UIImage]) {
        self.images = images
        imagesCollectionView.reloadData()
        addImageView.isHidden = !self.images.isEmpty
        imagesCollectionView.isHidden = self.images.isEmpty
    }
}

//MARK: ADD PRODUCT VIEWMODEL DELEGATE
extension AddProductVC:AddProductSuccessDelegate{
    func productAddedSuccessfully(withNewProduct product: ProductDataModel) {
        successDelegate?.productAddedSuccessfully(withNewProduct: product)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            AlertManager().showAlert(message: ConstantText.productAddSucess) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
