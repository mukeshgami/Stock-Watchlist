//
//  ViewController.swift
//  Stock
//
//  Created by Mukesh Gami on 27/05/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var stocks = [Stock]()
    var boxValue = [String]()
    var boxValueType = "Value"
    var spinner = UIActivityIndicatorView()
    var refreshTableView = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner

        refreshTableView.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshTableView.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshTableView)
        
        spinner.startAnimating()
        fetchStocks { (stocks) in
            self.stocks = stocks
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
            self.setBoxValue(type: self.boxValueType)
            //print("sfajsdf: ", stocks)
        }
    }
    
    @objc func refresh() {
        print("refresh strart")
        fetchStocks { (stocks) in
            self.stocks = stocks
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
            self.setBoxValue(type: self.boxValueType)
            //print("sfajsdf: ", stocks)
        }
    }
    
    func setBoxValue(type: String) {
        boxValue = []
        for stock in stocks {
            if type == "Percent" {
                boxValue.append(String(format: "%.2f", stock.regularMarketChangePercent) + "%")
            }else {
                if stock.regularMarketChange > 0 {
                    boxValue.append("+" + String(format: "%.2f", stock.regularMarketChange))
                }else {
                    boxValue.append(String(format: "%.2f", stock.regularMarketChange))

                }
                
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshTableView.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! StockCell
        cell.stockName.text = stocks[indexPath.row].shortName
        cell.stockSymbol.text = stocks[indexPath.row].symbol
        cell.stockPrice.text = String(format: "%.2f", stocks[indexPath.row].regularMarketPrice)
        cell.stockPriceChange.text = boxValue[indexPath.row]
        
        
        if stocks[indexPath.row].regularMarketChange > 0 {
            cell.stockPriceChangeBox.backgroundColor = .systemGreen
        }else {
            cell.stockPriceChangeBox.backgroundColor = .red
        }
        
        cell.boxTapped = {
            print("boxTapped")
            if self.boxValueType == "Value" {
                self.setBoxValue(type: "Percent")
                self.boxValueType = "Percent"
            }else {
                self.setBoxValue(type: "Value")
                self.boxValueType = "Value"
            }
        }
        
        return cell
    }
}

