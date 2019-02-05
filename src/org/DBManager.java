package org;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBManager {
	public static Connection getConnection() {
		Connection con = null;

		try {
			Context context = new InitialContext();
			//DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/GCSDB");  //to use H2 datasource
			DataSource ds = (DataSource) context.lookup("java:jboss/datasources/gcsdb");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}

	public static int creatTables()
	{
		int ret = 0;
		Connection con = getConnection();
		if (con==null) {
			System.out.println("con = null");
			ret = -1;
			return ret;
		}
		String myRequest = "";
		PreparedStatement pStmt;
		try {
			//Création de la table "ATHLETE"
			myRequest = "CREATE TABLE ATHLETE ("+
			"ID INTEGER PRIMARY KEY,"+ // Identifiant athlète (11-infini)
			"NOM VARCHAR(30) NOT NULL,"+
			"PRENOM VARCHAR(30) NOT NULL,"+
			"DATE_NAIS DATE,"+
			"LIEU_NAIS VARCHAR(30) NOT NULL,"+
			"PRENOM_PERE VARCHAR(30) NOT NULL,"+
			"PROFESSION_PERE VARCHAR(30) NOT NULL,"+
			"NOM_MERE VARCHAR(30) NOT NULL,"+
			"PRENOM_MERE VARCHAR(30) NOT NULL,"+
			"PROFESSION_MERE VARCHAR(30) NOT NULL,"+
			"ADRESSE VARCHAR(1024) NOT NULL,"+
			"NUM_TEL VARCHAR(30) NOT NULL,"+
			"DATE_INSCRIPTION DATE,"+
			"IMG_PATH VARCHAR(1024)) ENGINE = InnoDB";
//Afficher myRequest
System.out.println("INFO -- Create table : "+myRequest);
			pStmt = con.prepareStatement(myRequest);
			pStmt.executeUpdate();
			pStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			ret = -1;
		}

		try {
			//Création de la table "ENTRAINEUR"
			myRequest = "CREATE TABLE ENTRAINEUR ("+
			"ID INTEGER PRIMARY KEY,"+ // Identifiant entraineur (1-10)
			"NOM VARCHAR(30) NOT NULL,"+
			"PRENOM VARCHAR(30) NOT NULL,"+
			"DATE_NAIS DATE,"+
			"LIEU_NAIS VARCHAR(30) NOT NULL,"+
			"ADRESSE VARCHAR(1024) NOT NULL,"+
			"NUM_TEL VARCHAR(30) NOT NULL,"+
			"DATE_INSCRIPTION DATE) ENGINE = InnoDB";
//Afficher myRequest
System.out.println("INFO -- Create table : "+myRequest);
			pStmt = con.prepareStatement(myRequest);
			pStmt.executeUpdate();
			pStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			ret = -1;
		}

		try {
			//Création de la table "PAIEMENT"
			myRequest = "CREATE TABLE PAIEMENT ("+
			"ID INTEGER,"+ // 1<ID<=10 (Entraineur) /   ID>10 (Athlète)
			"MOIS DATE,"+
			"MONTANT DECIMAL(8,2),"+ //8 chifres dont 2 après la virgule
			"PRIMARY KEY (ID,MOIS)) ENGINE = InnoDB";
//Afficher myRequest
System.out.println("INFO -- Create table : "+myRequest);
			pStmt = con.prepareStatement(myRequest);
			pStmt.executeUpdate();
			pStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			ret = -1;
		}

		try {
			//Création de la table "ASSURANCE"
			myRequest = "CREATE TABLE ASSURANCE ("+
			"ID INTEGER PRIMARY KEY,"+ // 1<ID<=10 (Entraineur) /   ID>10 (Athlète)
			"debut DATE,"+
			"fin DATE) ENGINE = InnoDB";
//Afficher myRequest
System.out.println("INFO -- Create table : "+myRequest);
			pStmt = con.prepareStatement(myRequest);
			pStmt.executeUpdate();
			pStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			ret = -1;
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return ret;
	}
	
	public static void setATHLETE(Integer id, String nom, String prenom, String dateNais, String lieuNais,
			String prenomPere, String profPere, String nomMere, String prenomMere, String profMere,
			String adresse, String tel, String dateInscription)
	{
		if (id.intValue() > 0) {
			if (nom == null) nom = "";
			if (prenom == null) prenom = "";
			if (dateNais == null) dateNais = "01/01/2000";
			if (lieuNais == null) lieuNais = "";
			if (prenomPere == null) prenomPere = "";
			if (profPere == null) profPere = "";
			if (nomMere == null) nomMere = "";
			if (prenomMere == null) prenomMere = "";
			if (profMere == null) profMere = "";
			if (adresse == null) adresse = "";
			if (tel == null) tel = "";
			if (dateInscription == null) dateInscription = "01/01/2000";
			Connection con = getConnection();
			try {
				String myRequest = "SELECT * FROM ATHLETE WHERE ID=" + id.toString();
//Afficher myRequest
System.out.println("setAthlete1 : "+myRequest);
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				if ( rs.next() ) {
					pStmt.close();
					myRequest = "UPDATE ATHLETE SET NOM='"+nom
					+"', PRENOM='"+prenom
					+"', DATE_NAIS='"+dateNais
					+"', LIEU_NAIS='"+lieuNais
					+"', PRENOM_PERE='"+prenomPere
					+"', PROFESSION_PERE='"+profPere
					+"', NOM_MERE='"+nomMere
					+"', PRENOM_MERE='"+prenomMere
					+"', PROFESSION_MERE='"+profMere
					+"', ADRESSE='"+adresse
					+"', NUM_TEL='"+tel
					+"', DATE_INSCRIPTION='"+dateInscription
					+"' WHERE ID="+id.toString();
//Afficher myRequest
System.out.println("setAthlete2 : "+myRequest);
					pStmt = con.prepareStatement(myRequest);
					pStmt.executeUpdate();
					pStmt.close();
				}
				else {
					pStmt.close();
					myRequest = "INSERT INTO ATHLETE (ID,NOM,PRENOM,DATE_NAIS,LIEU_NAIS,PRENOM_PERE,PROFESSION_PERE,"+
								"NOM_MERE,PRENOM_MERE,PROFESSION_MERE,ADRESSE,NUM_TEL,DATE_INSCRIPTION) VALUES ("
								+id+",'"+nom+"','"+prenom+"','"+dateNais+"','"+lieuNais+"','"+prenomPere+"','"+profPere+"','"
								+nomMere+"','"+prenomMere+"','"+profMere+"','"+adresse+"','"+tel+"','"+dateInscription+"')";
//Afficher myRequest
System.out.println("setAthlete3 : "+myRequest);
					pStmt = con.prepareStatement(myRequest);
					pStmt.executeUpdate();
					pStmt.close();
					//Initialisation de l'assurance
					init_ASSURANCE(id);
					//Initialisation du paiement
					init_PAIEMENT(id);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}		
	}
	
	public static void setENTRAINEUR(Integer id, String nom, String prenom, String dateNais, String lieuNais,
			String adresse, String tel, String dateInscription)
	{
		if (id.intValue() > 0) {
			if (nom == null) nom = "";
			if (prenom == null) prenom = "";
			if (dateNais == null) dateNais = "01/01/2000";
			if (lieuNais == null) lieuNais = "";
			if (adresse == null) adresse = "";
			if (tel == null) tel = "";
			if (dateInscription == null) dateInscription = "01/01/2000";
			Connection con = getConnection();
			try {
				String myRequest = "SELECT * FROM ENTRAINEUR WHERE ID=" + id.toString();
//Afficher myRequest
System.out.println("setEntraineur1 : "+myRequest);
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				if ( rs.next() ) {
					pStmt.close();
					myRequest = "UPDATE ENTRAINEUR SET NOM='"+nom
					+"', PRENOM='"+prenom
					+"', DATE_NAIS='"+dateNais
					+"', LIEU_NAIS='"+lieuNais
					+"', ADRESSE='"+adresse
					+"', NUM_TEL='"+tel
					+"', DATE_INSCRIPTION='"+dateInscription
					+"' WHERE ID="+id.toString();
//Afficher myRequest
System.out.println("setEntraineur2 : "+myRequest);
					pStmt = con.prepareStatement(myRequest);
					pStmt.executeUpdate();
					pStmt.close();
				}
				else {
					pStmt.close();
					myRequest = "INSERT INTO ENTRAINEUR (ID,NOM,PRENOM,DATE_NAIS,LIEU_NAIS,"+
								"ADRESSE,NUM_TEL,DATE_INSCRIPTION) VALUES ("
								+id+",'"+nom+"','"+prenom+"','"+dateNais+"','"+lieuNais+"','"+adresse+"','"+tel+"','"+dateInscription+"')";
//Afficher myRequest
System.out.println("setEntraineur3 : "+myRequest);
					pStmt = con.prepareStatement(myRequest);
					pStmt.executeUpdate();
					pStmt.close();
					//Initialisation de l'assurance
					init_ASSURANCE(id);
					//Initialisation du paiement
					init_PAIEMENT(id);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}		
	}
	
	public static Integer getFreeAthleteID(){
		int max = 10;
		Connection con = getConnection();
		if (con == null) {
			return -1;
		} else {
			try {
				String myRequest = "SELECT * FROM ATHLETE";
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				while (rs.next()) {
					Integer _id = rs.getInt("ID");
					if (_id > max) max = _id;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		if (max < 10) return -1;
		return max+1;
	}
	
	public static Integer getFreeEntraineurID(){
		int max = 0;
		Connection con = getConnection();
		if (con == null) {
			return -1;
		} else {
			try {
				String myRequest = "SELECT * FROM ENTRAINEUR";
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				while (rs.next()) {
					Integer _id = rs.getInt("ID");
					if (_id > max) max = _id;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		if (max >= 10) return -1;
		return max+1;
	}
	
	public static ArrayList getATHLETE(Integer id, String nom,String prenom) {
		ArrayList athletes = new ArrayList();

		Connection con = getConnection();
		if (con == null) {
			athletes.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				if ((id != null && nom != null && prenom != null
					&& id == 0 && nom.isEmpty() && prenom.isEmpty()) ||
					(id != null && nom != null && prenom != null
					&& id == 0 && nom.equals("Tapez le nom de l_athlète") && prenom.equals("Tapez le prénom de l_athlète"))){
					myRequest = "SELECT * FROM ATHLETE";
				} else {
					myRequest = "SELECT * FROM ATHLETE WHERE ";
					if (id==null || id.toString().isEmpty() || id == 0)
						myRequest = myRequest + "ID=0";
					else
						myRequest = myRequest + "ID=" + id.toString();
					if (nom!=null && !nom.isEmpty() && !nom.equals("Tapez le nom de l_athlète")) 
						myRequest = myRequest + " OR NOM='" + nom + "'";
					if (prenom!=null && !prenom.isEmpty() && !prenom.equals("Tapez le prénom de l_athlète")) 
						myRequest = myRequest + " OR PRENOM='" + prenom + "'";
				}
				if (!myRequest.isEmpty()) myRequest = myRequest + " ORDER BY ID ASC";
//Afficher myRequest
System.out.println("getathletes : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ArrayList athlete = new ArrayList();

					Integer _id = rs.getInt("ID");
					String _nom = rs.getString("NOM");
					String _prenom = rs.getString("PRENOM");
					String _dateNais = rs.getDate("DATE_NAIS").toString();
					String _lieuNais = rs.getString("LIEU_NAIS");
					String _prenomPere = rs.getString("PRENOM_PERE");
					String _profPere = rs.getString("PROFESSION_PERE");
					String _nomMere = rs.getString("NOM_MERE");
					String _prenomMere = rs.getString("PRENOM_MERE");
					String _profMere = rs.getString("PROFESSION_MERE");
					String _adresse = rs.getString("ADRESSE");
					String _tel = rs.getString("NUM_TEL");
					String _dateInscription = rs.getDate("DATE_INSCRIPTION").toString();

					athlete.add(0, _id);
					athlete.add(1, _nom);
					athlete.add(2, _prenom);
					athlete.add(3, _dateNais);
					athlete.add(4, _lieuNais);
					athlete.add(5, _prenomPere);
					athlete.add(6, _profPere);
					athlete.add(7, _nomMere);
					athlete.add(8, _prenomMere);
					athlete.add(9, _profMere);
					athlete.add(10, _adresse);
					athlete.add(11, _tel);
					athlete.add(12, _dateInscription);

					athletes.add(j, athlete);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return athletes;
	}
	
	public static ATHLETE getATHLETE(Integer id) {
		ATHLETE ret = null;
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && id > 0){
					myRequest = "SELECT * FROM ATHLETE WHERE ID=" + id.toString();
				}
//Afficher myRequest
System.out.println("getATHLETE(id) : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ret = new ATHLETE();
					ret.ID = String.valueOf(rs.getInt("ID"));
					ret.NOM = rs.getString("NOM");
					ret.PRENOM = rs.getString("PRENOM");
					ret.DATE_NAIS = rs.getDate("DATE_NAIS").toString();
					ret.LIEU_NAIS = rs.getString("LIEU_NAIS");
					ret.prenomPere = rs.getString("PRENOM_PERE");
					ret.profPere = rs.getString("PROFESSION_PERE");
					ret.nomMere = rs.getString("NOM_MERE");
					ret.prenomMere = rs.getString("PRENOM_MERE");
					ret.profMere = rs.getString("PROFESSION_MERE");
					ret.ADRESSE = rs.getString("ADRESSE");
					ret.NUM_TEL = rs.getString("NUM_TEL");
					ret.DATE_INSCRIPTION = rs.getDate("DATE_INSCRIPTION").toString();
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return ret;
	}
	
	public static ArrayList get_PAIEMENT(Integer id) {
		ArrayList paiements = new ArrayList();

		Connection con = getConnection();
		if (con == null) {
			paiements.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				if ((id != null	&& id == 0) ||
					(id != null	&& id == 0)){
					myRequest = "SELECT * FROM PAIEMENT";
				} else {
					myRequest = "SELECT * FROM PAIEMENT WHERE ";
					if (id==null || id.toString().isEmpty() || id == 0)
						myRequest = myRequest + "ID=0";
					else
						myRequest = myRequest + "ID=" + id.toString();
				}
//Afficher myRequest
System.out.println("get_PAIEMENT : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ArrayList paiement = new ArrayList();

					Integer _id = rs.getInt("ID");
					String _mois = rs.getDate("MOIS").toString();
					String _montant = rs.getString("MONTANT");

					paiement.add(0, _id);
					paiement.add(1, _mois);
					paiement.add(2, _montant);

					paiements.add(j, paiement);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}

		return paiements;
	}
	
	//date : mm/01/yyyy
	public static Float get_PAIEMENT(Integer id, String date) {
		Float ret = null;
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null	&& id > 0 && date != null && !date.isEmpty())
					myRequest = "SELECT * FROM PAIEMENT WHERE ID=" + id.toString() + " AND MOIS='"+date+"'";
//Afficher myRequest
System.out.println("get_PAIEMENT : "+myRequest);
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				if (rs.next())
					ret = Float.parseFloat(rs.getString("MONTANT"));
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return ret;
	}
	
	//date : yyyy-mm-01
	public static boolean check_PAIEMENT(Integer id, String date) {
		boolean ret = false;
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && date != null)
				{
					if (id > 0 && !date.isEmpty()) {
						myRequest = "SELECT * FROM PAIEMENT WHERE ID="+id.toString()+" AND MOIS='"+date+"' AND MONTANT>=0.00";
					}
				}
//Afficher myRequest
System.out.println("check_PAIEMENT : "+myRequest);
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				while (rs.next())
					ret = true;
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return ret;
	}
	
	//date : mm/01/yyyy
	public static void set_PAIEMENT(Integer id, String date, Float montant) {
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && date != null)
				{
					if (id > 0 && !date.isEmpty()) {
						if (get_PAIEMENT(id, date) != null)
							myRequest = "UPDATE PAIEMENT SET MONTANT="+montant.toString()+" WHERE ID="+id.toString()+" AND MOIS='"+date+"'";
						else
							myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+id.toString()+",'"+date+"',"+montant.toString()+")";
					}
				}
//Afficher myRequest
System.out.println("set_PAIEMENT : "+myRequest);
				PreparedStatement pStmt = con.prepareStatement(myRequest);
				pStmt.executeUpdate();
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public static ArrayList get_ASSURANCE(Integer id) {
		ArrayList assurance = new ArrayList();

		Connection con = getConnection();
		if (con == null) {
			assurance.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				if ((id != null	&& id == 0) ||
					(id != null	&& id == 0)){
					myRequest = "SELECT * FROM ASSURANCE";
				} else {
					myRequest = "SELECT * FROM ASSURANCE WHERE ";
					if (id==null || id.toString().isEmpty() || id == 0)
						myRequest = myRequest + "ID=0";
					else
						myRequest = myRequest + "ID=" + id.toString();
				}
//Afficher myRequest
System.out.println("get_ASSURANCE : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				if (rs.next()) {
					Integer _id = rs.getInt("ID");
					String _debut = rs.getString("DEBUT");
					String _fin = rs.getString("FIN");

					assurance.add(0, _debut);
					assurance.add(1, _fin);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}

		return assurance;
	}
	
	public static boolean check_ASSURANCE(Integer id, java.util.Date date) {
		boolean ret = false;
		String d = Integer.valueOf(date.getYear()+1900).toString() + "-" + Integer.valueOf(date.getMonth()+1).toString() + "-" + Integer.valueOf(date.getDate()).toString();
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && date != null && id > 0)
				{
					myRequest = "SELECT * FROM ASSURANCE WHERE ID="+id.toString()+" AND FIN>='"+d+"'";
				}
//Afficher myRequest
System.out.println("check_ASSURANCE : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				while (rs.next())
					ret = true;
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}

		return ret;
	}
	
	//debut et fin sour forme "yyyy-mm-dd"
	public static void set_ASSURANCE(Integer id, String debut, String fin) {
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && debut != null && fin != null)
				{
					if (id > 0) {
						if (get_ASSURANCE(id).size() > 0)
							myRequest = "UPDATE ASSURANCE SET DEBUT='"+debut+"',FIN='"+fin+"' WHERE ID="+id.toString();
						else
						{
							if (!debut.isEmpty() && !fin.isEmpty())
								myRequest = "INSERT INTO ASSURANCE (ID,DEBUT,FIN) VALUES ("+id.toString()+",'"+debut+"','"+fin+"')";
							else
								myRequest = "INSERT INTO ASSURANCE (ID) VALUES ("+id.toString()+")";
						}
					}
				}
//Afficher myRequest
System.out.println("set_ASSURANCE : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				pStmt.executeUpdate();
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public static void init_ASSURANCE(Integer id) {
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && id > 0) {
					if (get_ASSURANCE(id).size() > 0)
					{
						myRequest = "UPDATE ASSURANCE SET DEBUT='01/01/0001',FIN='01/01/0001' WHERE ID="+id.toString();
					}
					else
					{
						myRequest = "INSERT INTO ASSURANCE (ID,DEBUT,FIN) VALUES ("+id.toString()+",'01/01/0001','01/01/0001')";
					}
//Afficher myRequest
System.out.println("set_ASSURANCE : "+myRequest);
					PreparedStatement pStmt = con.prepareStatement(myRequest);
					pStmt.executeUpdate();
					pStmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public static void init_PAIEMENT(Integer id) {
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && id > 0) {
					PreparedStatement pStmt = null;
					if (get_PAIEMENT(id).size() > 0)
					{
						myRequest = "UPDATE PAIEMENT SET MONTANT=-1.00 WHERE ID="+id.toString();
//Afficher myRequest
System.out.println("init_PAIEMENT : "+myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();
					}
					else
					{
						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+id.toString()+",'2011/10/01,-1.00)";
//Afficher myRequest
System.out.println("init_PAIEMENT : "+myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();
						
						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+id.toString()+",'2011/11/01',-1.00)";
//Afficher myRequest
System.out.println("init_PAIEMENT : "+myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+id.toString()+",'2011/12/01',-1.00)";
//Afficher myRequest
System.out.println("init_PAIEMENT : "+myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/01/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/02/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/03/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/04/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/05/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/06/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();

						myRequest = "INSERT INTO PAIEMENT (ID,MOIS,MONTANT) VALUES ("+ id.toString() + ",'2012/07/01',-1.00)";
// Afficher myRequest
System.out.println("init_PAIEMENT : " + myRequest);
						pStmt = con.prepareStatement(myRequest);
						pStmt.executeUpdate();
						pStmt.close();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static ArrayList getENTRAINEUR(Integer id, String nom,String prenom) {
		ArrayList entraineurs = new ArrayList();

		Connection con = getConnection();
		if (con == null) {
			entraineurs.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				if ((id != null && nom != null && prenom != null
					&& id == 0 && nom.isEmpty() && prenom.isEmpty()) ||
					(id != null && nom != null && prenom != null
					&& id == 0 && nom.equals("Tapez le nom de l_entraineur") && prenom.equals("Tapez le prénom de l_entraineur"))){
					myRequest = "SELECT * FROM ENTRAINEUR";
				} else {
					myRequest = "SELECT * FROM ENTRAINEUR WHERE ";
					if (id==null || id.toString().isEmpty() || id == 0)
						myRequest = myRequest + "ID=0";
					else
						myRequest = myRequest + "ID=" + id.toString();
					if (nom!=null && !nom.isEmpty() && !nom.equals("Tapez le nom de l_entraineur")) 
						myRequest = myRequest + " OR NOM='" + nom + "'";
					if (prenom!=null && !prenom.isEmpty() && !prenom.equals("Tapez le prénom de l_entraineur")) 
						myRequest = myRequest + " OR PRENOM='" + prenom + "'";
				}
				myRequest = myRequest + " ORDER BY ID ASC";
//Afficher myRequest
System.out.println("getENTRAINEUR : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ArrayList entraineur = new ArrayList();

					Integer _id = rs.getInt("ID");
					String _nom = rs.getString("NOM");
					String _prenom = rs.getString("PRENOM");
					String _dateNais = rs.getDate("DATE_NAIS").toString();
					String _lieuNais = rs.getString("LIEU_NAIS");
					String _adresse = rs.getString("ADRESSE");
					String _tel = rs.getString("NUM_TEL");
					String _dateInscription = rs.getDate("DATE_INSCRIPTION").toString();
					entraineur.add(0, _id);
					entraineur.add(1, _nom);
					entraineur.add(2, _prenom);
					entraineur.add(3, _dateNais);
					entraineur.add(4, _lieuNais);
					entraineur.add(5, _adresse);
					entraineur.add(6, _tel);
					entraineur.add(7, _dateInscription);

					entraineurs.add(j, entraineur);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return entraineurs;
	}
	
	public static ENTRAINEUR getENTRAINEUR(Integer id) {
		ENTRAINEUR ret = null;
		Connection con = getConnection();
		if (con != null) {
			try {
				String myRequest = "";
				if (id != null && id > 0){
					myRequest = "SELECT * FROM ENTRAINEUR WHERE ID=" + id.toString();
				}
//Afficher myRequest
System.out.println("getENTRAINEUR(id) : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ret = new ENTRAINEUR();
					ret.ID = String.valueOf(rs.getInt("ID"));
					ret.NOM = rs.getString("NOM");
					ret.PRENOM = rs.getString("PRENOM");
					ret.DATE_NAIS = rs.getDate("DATE_NAIS").toString();
					ret.LIEU_NAIS = rs.getString("LIEU_NAIS");
					ret.ADRESSE = rs.getString("ADRESSE");
					ret.NUM_TEL = rs.getString("NUM_TEL");
					ret.DATE_INSCRIPTION = rs.getDate("DATE_INSCRIPTION").toString();
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return ret;
	}
	
	public static ArrayList getENTRAINEUR_non_assures() {
		ArrayList entraineurs = new ArrayList();

		java.util.Date date = new java.util.Date();
		
		Connection con = getConnection();
		if (con == null) {
			entraineurs.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				String d = String.valueOf(date.getYear()+1900)+"-"+String.valueOf(date.getMonth()+1)+"-"+String.valueOf(date.getDate());
				myRequest = "SELECT * FROM ASSURANCE WHERE ID < 11 AND FIN<'"+d+"'";
//Afficher myRequest
System.out.println("getENTRAINEUR_non_assures : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ArrayList entraineur = new ArrayList();

					Integer _id = rs.getInt("ID");
					String _debut = rs.getString("DEBUT");
					String _fin = rs.getString("FIN");
					entraineur.add(0, _id);
					entraineur.add(1, _debut);
					entraineur.add(2, _fin);

					entraineurs.add(j, entraineur);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return entraineurs;
	}
	
	public static ArrayList getATHLETE_non_assures() {
		ArrayList athletes = new ArrayList();

		java.util.Date date = new java.util.Date();
		
		Connection con = getConnection();
		if (con == null) {
			athletes.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				String d = String.valueOf(date.getYear()+1900)+"-"+String.valueOf(date.getMonth()+1)+"-"+String.valueOf(date.getDate());
				myRequest = "SELECT * FROM ASSURANCE WHERE ID>10 AND FIN<'"+d+"'";
//Afficher myRequest
System.out.println("getATHLETE_non_assures : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				int j = 0;
				while (rs.next()) {
					ArrayList athlete = new ArrayList();

					Integer _id = rs.getInt("ID");
					String _debut = rs.getString("DEBUT");
					String _fin = rs.getString("FIN");
					athlete.add(0, _id);
					athlete.add(1, _debut);
					athlete.add(2, _fin);

					athletes.add(j, athlete);
					j++;
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return athletes;
	}
	
	public static ArrayList getATHLETE_non_payes() {
		ArrayList athletes = new ArrayList();

		java.util.Date date = new java.util.Date();
		
		Connection con = getConnection();
		if (con == null) {
			athletes.add(0, "Problème de connection à la base de données");
		} else {
			try {
				String myRequest = "";
				String d = String.valueOf(date.getYear()+1900)+"-"+String.valueOf(date.getMonth()+1)+"-01";
				myRequest = "SELECT * FROM PAIEMENT WHERE ID>10 AND MOIS='"+d+"' AND MONTANT=-1.00";
//Afficher myRequest
System.out.println("getATHLETE_non_payes : "+myRequest);

				PreparedStatement pStmt = con.prepareStatement(myRequest);
				ResultSet rs = pStmt.executeQuery();
				while (rs.next()) {
					Integer _id = rs.getInt("ID");
					if (!athletes.contains(_id))
						athletes.add(_id);
				}
				pStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return athletes;
	}
	
}
