package org;

public class PropertyHandler {

	// Param�tres du clients
	private String nss;
	private String nom;
	private String prenom;
	
	//Param�tres du m�decin
	private String nssMedecin;
	private String nomMedecin;
	private String prenomMedecin;
	
	//Pram�tres d'une consultation
	private String nommed;
	private String nompat;
	private String dateconsultation;
	//Pram�tres d'un ordonnance
	private String nommede;
	private String nompati;
	private String idord;
	//Pram�tres d'une maladie
	private String idmal;
	private String nomal;



	public PropertyHandler() {
		nss = null;
		nom = null;
		prenom = null;
	}

	//M�thodes pour M�decin
	public String getNssMedecin() {
		return nssMedecin;
	}

	public void setNssMedecin(String nssMedecin) {
		this.nssMedecin = nssMedecin;
	}

	public String getNomMedecin() {
		return nomMedecin;
	}

	public void setNomMedecin(String nomMedecin) {
		this.nomMedecin = nomMedecin;
	}

	public String getPrenomMedecin() {
		return prenomMedecin;
	}

	public void setPrenomMedecin(String prenomMedecin) {
		this.prenomMedecin = prenomMedecin;
	}

	//M�thodes pour Patient
	public String getNss() {
		return nss;
	}

	public void setNss(String num_ss) {
		nss = num_ss;
	}

	public String getNom() {
		return nom;
	}
	
	public void setNom(String name) {
		nom = name;
	}

	public String getPrenom() {
		return prenom;
	}
	
	public void setPrenom(String lastname) {
		prenom = lastname;
	}
	
	//M�thodes pour Consultation

	public String getDateconsultation() {
		return dateconsultation;
	}

	public void setDateconsultation(String dateconsultation) {
		this.dateconsultation = dateconsultation;
	}

	public String getNompat() {
		return nompat;
	}

	public void setNompat(String nompatient) {
		nompat = nompatient;
	}

	public String getNommed() {
		return nommed;
	}

	public void setNommed(String nommedecin) {
		nommed = nommedecin;
	}
	//M�thodes pour ordonnance
	public String getNompati() {
		return nompati;
	}

	public void setNompati(String nompati) {
		this.nompati = nompati;
	}

	public String getNommede() {
		return nommede;
	}

	public void setNommede(String nommede) {
		this.nommede = nommede;
	}

	public String getIdord() {
		return idord;
	}

	public void setIdord(String idord) {
		this.idord = idord;
	}
	//M�thodes pour maladie
	public String getIdmal() {
		return idmal;
	}

	public void setIdmal(String idmal) {
		this.idmal = idmal;
	}

	public String getNomal() {
		return nomal;
	}

	public void setNomal(String nomal) {
		this.nomal = nomal;
	}
}
