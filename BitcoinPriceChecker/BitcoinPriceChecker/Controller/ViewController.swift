//
//  ViewController.swift
//  BitcoinPriceChecker
//
//  Created by Danylo Kushlianskyi on 05.08.2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var coinManager = CoinManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        coinManager.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        self.view.addSubview(globalStack)
        globalStack.addArrangedSubview(nameLabel)
        globalStack.addArrangedSubview(innerStack)
        globalStack.addArrangedSubview(stackView)
        
        
        stackView.addSubview(innerStack)
        innerStack.addArrangedSubview(bitcoinImage)
        innerStack.addArrangedSubview(priceLabel)
        innerStack.addArrangedSubview(currencyLabel)
        
        self.view.addSubview(pickerView)
        
    
        setConstraints()
    }
    
    // MARK: - Layout Elements
    
    let globalStack: UIStackView = {
        let globalStack = UIStackView()
        globalStack.axis = .vertical
        globalStack.translatesAutoresizingMaskIntoConstraints = false
        globalStack.spacing = 50
        return globalStack
    }()
    let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Coin Checker"
        name.textColor = UIColor(named: "TitleColor")
        name.font = .systemFont(ofSize: 40, weight: .ultraLight)
        name.textAlignment = .center
        return name
    }()
    let stackView : UIView = {
        let stackView = UIView()
        stackView.layer.cornerRadius = 12
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor(named: "IconColor")?.cgColor
        return stackView
    }()
    let innerStack: UIStackView = {
        let innerStack = UIStackView()
        innerStack.translatesAutoresizingMaskIntoConstraints = false
        innerStack.axis = .horizontal
        innerStack.distribution = .fillEqually
        return innerStack
    }()
    let bitcoinImage: UIImageView = {
        let bitcoin = UIImageView()
        bitcoin.translatesAutoresizingMaskIntoConstraints = false
        bitcoin.image = UIImage(systemName: "bitcoinsign.circle.fill")
        bitcoin.tintColor = UIColor(named: "IconColor")
        bitcoin.clipsToBounds = true
        bitcoin.contentMode = .scaleAspectFit
        return bitcoin
    }()
    let priceLabel: UILabel = {
        let price = UILabel()
        price.textAlignment = .right
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "..."
        price.textColor = UIColor(named: "TitleColor")
        price.font = .systemFont(ofSize: 20, weight: .regular)
        return price
    }()
    let currencyLabel: UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.text = "USD"
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = UIColor(named: "TitleColor")
        currencyLabel.font = .systemFont(ofSize: 20, weight: .regular)
        return currencyLabel
    }()
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    func setConstraints(){
        
        globalStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        globalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        globalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        globalStack.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nameLabel.topAnchor.constraint(equalTo: globalStack.topAnchor, constant: 50).isActive = true
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.leadingAnchor.constraint(equalTo: globalStack.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: globalStack.trailingAnchor, constant: -15).isActive = true
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
    
        innerStack.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        innerStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        innerStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        bitcoinImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        
        

    }
    
    
    

}
// MARK: - PickerView delegate methods

extension ViewController {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = coinManager.currencyArray[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.performRequest(fiat: coinManager.currencyArray[row])
    }
}

// MARK: - CoinDelegate methods

extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(_ coinData: Coin) {
        DispatchQueue.main.async {
            self.priceLabel.text = String(format: "%.2f", coinData.rate)
        }
    }
    
    func didGetError(_ error: Error) {
        print(error)
    }
    
    
}

