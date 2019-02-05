package org;

public class ENTRAINEUR extends PERSONNE {

	/**
	 * Constructeur d'initialisation de MEDECIN
	 */
	public ENTRAINEUR(String id, String NOM, String PRENOM, String DATE_NAIS,
			String LIEU_NAIS, String ADRESSE, String NUM_TEL, String DATE_INSCR) {
		super(id, NOM, PRENOM, DATE_NAIS, LIEU_NAIS, ADRESSE, NUM_TEL,
				DATE_INSCR);
	}

	public ENTRAINEUR() {
		super("0", "", "", "01/01/1990", "", "", "", "01/01/1990");
	}

}
