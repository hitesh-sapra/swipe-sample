//
//  ViewController.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 23/08/23.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var productTableView: UITableView!
    var viewModel = ProductListViewModel()
    var dataList = [ProductDataModel]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dataDelegate = self
        viewModel.getProductList()
        registerCellToTableView()
        tableViewDelegates()
        setupNavigationBar()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        let vc = AddProductVC()
        vc.successDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func registerCellToTableView(){
        productTableView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
    }
    
    func tableViewDelegates(){
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    func setupNavigationBar(){
        navigationItem.title = ConstantText.homePageTitle
        searchController.searchBar.tintColor = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ConstantText.searchPlc
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        definesPresentationContext = true
    }
}

//MARK: SEARCH BAR DELEGATE

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            viewModel.searchProduct(searchText: searchText)
        }
        
    }
}

//MARK: TABLEVIEW DELEGATE

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else{
            return UITableViewCell()
        }
        let dataItem = dataList[indexPath.row]
        cell.updateCell(data:dataItem)
        return cell
    }
}
//MARK: VIEWMODEL DELEGATE

extension ViewController:ProductVMDelegate{
    func dataListUpdated(withData data:[ProductDataModel]) {
        dataList = data
        productTableView.reloadData()
    }
}


//MARK: ADDM PRODUCT SUCCESS DELEGATE

extension ViewController:AddProductSuccessDelegate{
    func productAddedSuccessfully(withNewProduct product: ProductDataModel) {
        viewModel.dataList.insert(product, at: 0)
        dataList.insert(product, at: 0)
        productTableView.reloadData()
    }
}


