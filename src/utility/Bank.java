package utility;

import java.util.HashMap;

/**
* Class for banks lookup. Facilitate retrieval of bank names.
* 
* Reference: https://www.baeldung.com/java-random-string
* 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
*/
public class Bank {
	
	private HashMap<String, String> bank;

	public Bank() {
		bank = new HashMap<String, String>();
		
		bank.put("affin_bank", "Affin Bank");
		bank.put("alliance_bank_malaysia_berhad", "Alliance Bank Malaysia Berhad");
		bank.put("al_rajhi_bank", "Al_rajhi Bank");
		bank.put("ambank_bhd", "Ambank Bhd");
		bank.put("bank_islam_malaysia_berhad", "Bank Islam Malaysia Berhad");
		bank.put("bank_kerjasama_rakyat_malaysia", "Bank Kerjasama Rakyat Malaysia");
		bank.put("bank_muamalat", "Bank Muamalat");
		bank.put("bank_of_china_malaysia_berhad", "Bank Of China (Malaysia) Berhad");
		bank.put("bank_pertanian_malaysia_berhad_agrobank", "Bank Pertanian Malaysia Berhad (Agrobank)");
		bank.put("bank_simpanan_nasional", "Bank Simpanan Nasional");
		bank.put("cimb_bank_bhd", "Cimb Bank Bhd");
		bank.put("citibank_bhd", "Citibank Bhd");
		bank.put("deutsche_bank", "Deutsche Bank");
		bank.put("hong_leong_bank_bhd", "Hong Leong Bank Bhd");
		bank.put("hsbc_bank_malaysia_bhd", "Hsbc Bank Malaysia Bhd");
		bank.put("industrial_and_commerical_bank_of_china", "Industrial And Commerical Bank Of China");
		bank.put("j_p__morgan_chase_bank_berhad", "J.p. Morgan Chase Bank Berhad");
		bank.put("kuwait_finance_house_malaysia_bhd", "Kuwait Finance House (Malaysia) Bhd");
		bank.put("malayan_banking_bhd_maybank", "Malayan Banking Bhd (Maybank)");
		bank.put("ocbc_bank_malaysia_bhd", "Ocbc Bank Malaysia Bhd");
		bank.put("public_bank_bhd", "Public Bank Bhd");
		bank.put("rhb_bank_bhd", "Rhb Bank Bhd");
		bank.put("standard_chartered_bank_bhd", "Standard Chartered Bank Bhd");
		bank.put("united_overseas_bank_malaysia_bhd", "United Overseas Bank Malaysia Bhd");
	}
	
	public HashMap<String, String> getList() {
		return bank;
	}
	
	public String findBankName(String key) {
		return bank.get(key);
	}
}
