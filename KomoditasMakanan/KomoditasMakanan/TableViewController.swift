//
//  TableViewController.swift
//  KomoditasMakanan
//
//  Created by Haidar Rais on 11/8/17.
//  Copyright © 2017 Haidar Rais. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var komoditasselected:String?
    var unitSelected:String?
    var mangkuknaSelected:String?
    var kamariSelected:String?
    var ayenaSelected:String?
    
    
    
    
    //deklarasikan url untuk mengambil datajson
    let kivaLoanURL = "https://script.googleusercontent.com/macros/echo?user_content_key=GvOVbvSkf1hKiV_U4KmfHh3MsxZJJ1jzWjgclRXuXqBBToyerhhB7CLw0IUdCu0y5Rix_lJuw-jasKscReoz-zkFs3QhLnLum5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_zfIhFKPQqUpHa0ILN3_AC5luHhRtg2VQrwl2zydjOSDXk34NutFTjSRPcCdIvYG4uX9oFPiCI7MFUdnuVdqVLGf8SQj2JrOMcC4QpU3SSaLW3_ZQ3-6mU&lib=MgUDQyBteIRqugMle9Pi_iIv1P8nYvko1"
    //deklarasika varibale loans untuk mengambil class Loan yang sudah dibuat sebelumnya
    var loans = [Loan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mengambil data Dari API loans
        getLatestLoans()
        
        //self sizingcell
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        //memasukan nilainya kedalam masing 2 label
        cell.komoditidesc.text = loans[indexPath.row].komoditas
        cell.mangkuknadesc.text = loans[indexPath.row].mangkukna
        
        let data = loans[indexPath.row]
        
        
        return cell
    }
    
    // MARK: - JSON PArsing
    // membuat method baru dengan nama: getLstestLoans()
    func getLatestLoans() {
        
        //deklarsi LoanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasikan sebelumnya
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return //return ini memiliki ffungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
        
        //delarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengambil nilai error yang didapat
            }
            
            //parse JSON data
            //deklarasi variable data untuk mengambil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.loans = self.parseJsonData(data: data)
                
                //Reload TAble view
                OperationQueue.main.addOperation ({
                    //reload Data kembali
                    self.tableView.reloadData()
                })
            }
            
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data Json
    func parseJsonData(data: Data) -> [Loan] {
        //deklarasi variable loans sebagai obejct dari kelas Loan
        var loans = [Loan]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do{
            //deklarasikan jsonResult untuk mengambil data jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            //Parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResults yang bernama Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans{
                //deklarasi loan sebagai objek dari class Loan
                let loan = Loan()
                loan.komoditas = jsonLoan["komoditas"] as! String
                loan.unit = jsonLoan["unit"] as! String
                loan.mangkukna = jsonLoan["mangkukna"] as! String
                loan.kamari = jsonLoan["kamari"] as! String
                loan.ayena = jsonLoan["ayena"] as! String
                
                
                loans.append(loan)
            }
        }catch{
            print(error)
        }
        return loans
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = loans[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        komoditasselected = task.komoditas
        unitSelected = task.unit
        mangkuknaSelected = task.mangkukna
        kamariSelected = task.kamari
        ayenaSelected = task.ayena
        
        
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "PassData", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "PassData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let kirimData = segue.destination as! detailViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            kirimData.passkomoditas = komoditasselected
            kirimData.passunit = unitSelected
            kirimData.passmangkukna = mangkuknaSelected
            kirimData.passkamari = kamariSelected
            kirimData.passayena = ayenaSelected
            
            
            
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}




