//
//  ProductListViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 20/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class ProductCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productCollection = Array<Product>()
    var productFilterCollection = Array<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        var names = Array<String>()
        names.append("Samsung 5")
        names.append("iPhone 5C")
        names.append("iPhone 6")
        names.append("iPhone 6S")
        names.append("iPhone 7")
        names.append("iPhone 7S")
        names.append("Tablet XP")
        names.append("Laptop Pavilion")
        names.append("Mackbook Pro")
        names.append("Mackbook Pro Retina")
        names.append("iPod 3")
        names.append("iPod 5")
    
        
        let product = Product()
        
        for i in 0..<12 {
            product.name = names[i]
            product.amount = 20.00 * Double(i)
            product.image = UIImage(named: "iphone\(i)")
            productCollection.append(product)
        }
        
    }
    
    func itemLongSelected(product:Product) {
        print("itemLongSelected")
        print("id: \(product.id)");
        print("name: \(product.name)");
    }
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
            print("handleLongPress long pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("productCollection.count: \(productCollection.count)")
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            return productFilterCollection.count
        } else {
            return productCollection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        let product:Product
        
        if searchBar.text != nil && !searchBar.text!.isEmpty {
            product = productFilterCollection[indexPath.row]
        } else {
            product = productCollection[indexPath.row]
        }
        
        cell.labelName.text = product.name
        cell.labelAmount.text = "S/. \(product.amount!)"
        cell.imageProduct.image = product.image
        
        /*
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(itemLongSelected(product:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5//seg
        longPressGestureRecognizer.delaysTouchesBegan = true
        cell.addGestureRecognizer(longPressGestureRecognizer)
        */
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange: \(searchText)")
        
        
        productFilterCollection = productCollection.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased()) ||
                String(product.amount).contains(searchText)
        })
        collectionView.reloadData()
        
    }

}
