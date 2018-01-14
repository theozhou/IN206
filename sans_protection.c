/*=============================================================================

  Name: TestDB.c
  		main

  Abs:  main function of the prototype

  Auth: 04-01-2011, Nicolas ANCIAUX (NA):
  Rev:  05-01-2011, Nicolas ANCIAUX (NA):

=============================================================================*/

#include <ocilib.h>			// OCILIB (to call Oracle OCI)
#include <stdio.h>			
#include <stdlib.h>
#include <string.h>			// inclue pour strchr()
 
int lire(char *chaine, int longueur)
{
    char *positionEntree = NULL;
    // On lit le texte saisi au clavier
    if (fgets(chaine, longueur, stdin) != NULL)  // Si la saisie se fait sans erreur
    {
        positionEntree = strchr(chaine, '\n'); // On recherche l'"Entrée"
        if (positionEntree != NULL) // Si on a trouvé le retour à la ligne
            *positionEntree = '\0'; // On remplace ce caractère par \0
        return 1; // On renvoie 1 si la fonction s'est déroulée sans erreur
    }
    else
        return 0; // On renvoie 0 s'il y a eu une erreur
}

int connect_dbms(OCI_Connection **cn) {

	char* login = "system";		// login SGBD
	char* mdp = "oracle";	// mot de passe SGBD
	char* sgbd = "XE";		// nom SGBD pour la connection ODBC (voir doc du SGBD)

	// Vérification de l'initialisation de la librairie OCILIB:
	if ( !OCI_Initialize(NULL, NULL, OCI_ENV_DEFAULT) )
		return EXIT_FAILURE;

	// Creation d'une connection vers le SGBD source:
	//    /!\ indiquez un login/mdp correct
	*cn = OCI_ConnectionCreate(sgbd, login, mdp, OCI_SESSION_DEFAULT);
	
	// Si la connection a été établie corectement, afficher ses propriétés:
	if(cn != NULL){
		printf(OCI_GetVersionServer(*cn));
		printf("Server major    version : %i\n", OCI_GetServerMajorVersion(*cn));
		printf("Server minor    version : %i\n", OCI_GetServerMinorVersion(*cn));
		printf("Server revision version : %i\n", OCI_GetServerRevisionVersion(*cn));
		printf("Connection      version : %i\n", OCI_GetVersionConnection(*cn));
	}
  
	return EXIT_SUCCESS;
}

int authenticate(char* login, char* mot, OCI_Connection* cn) {
	OCI_Statement* st;
    OCI_Resultset* rs;
	int nb_col;
	char query[100];
	
	strcpy(query,"select * from LOGINS where login = '");
	strcat(query,login);
	strcat(query,"'");
	strcat(query, " AND mot = '");
	strcat(query, mot);
	strcat(query,"'");
	//select * from LOGINS where login = '' or 'x' = 'x' AND mot = '' or 'x' = 'x'
	//printf("%s\n", query);

	// Création d'une requête à partir de la connexion:
    st = OCI_StatementCreate(cn);

	// Execution de la requête:
	OCI_ExecuteStmt(st, query);
 
	// Stockage du résultat de la requete dans un resultset:
    rs = OCI_GetResultset(st);

	// Récupèration du nombre de colonnes du résultat:
	nb_col = OCI_GetColumnCount (rs);
	// affichage des noms de colonnes:
	
	// Parcours et affichage des lignes du résultat:
	int indicator = 0;
    while (OCI_FetchNext(rs))
    {
		indicator += 1;
    }
	// libération des ressources de la librairie OCILIB:
    //OCI_Cleanup();

	return (indicator > 0);
	
}

int executeQuery(char* query, OCI_Connection* cn) {

    OCI_Statement* st;
    OCI_Resultset* rs;
	int nb_col;
	int i=0;
	OCI_Column *col;

	// Création d'une requête à partir de la connexion:
    st = OCI_StatementCreate(cn);

	// Execution de la requête:
	OCI_ExecuteStmt(st, query);
 
	// Stockage du résultat de la requete dans un resultset:
    rs = OCI_GetResultset(st);

	// Récupèration du nombre de colonnes du résultat:
	nb_col = OCI_GetColumnCount (rs);

	// affichage des noms de colonnes:
	for(i=0; i<nb_col; i++)
	{
		col = OCI_GetColumn (rs, i+1);
		printf("%s | ", OCI_ColumnGetName (col));
	}	printf("\n");


	// Parcours et affichage des lignes du résultat:
    while (OCI_FetchNext(rs))
    {
		// récupération de chaque valeur de colonne sous forme de chaine
		// et affichage des valeurs: 
		for(i=0; i<nb_col; i++)
			printf("%s | ", OCI_GetString(rs,i+1));
	    printf("\n");
    }

	// libération des ressources de la librairie OCILIB:
    //OCI_Cleanup();

	return EXIT_SUCCESS;
}

int main( int argc, char *argv[] )
{
	char* query = malloc(1000);	// requête à executer
	OCI_Connection* cn;
	OCI_Connection* cn2;
	int exit_code;		
	char login[50];
	char pwd[50];
	char classid[200];

	// se connecter à la base de donnée:
	exit_code = connect_dbms(&cn);

	// Lecture du login/pwd
	int try = 0;
	//int try_f = 0;
	retry1: if(++try > 3) return 0; // goto retry1, re-enter login and password
	printf("Login ? ");
	lire(login, 50);
	printf("Login = %s \n\n", login);
	printf("Pwd ? ");
	lire(pwd, 50);
	// login protection below
	/*
    if(strstr(login,"=") != NULL || strstr(login,"Null") != NULL || strstr(pwd,"=") != NULL || strstr(pwd,"Null") != NULL){
		printf("symbol not allowed!\n");
		goto retry1;
	} 
	*/
	
	printf("pwd = %s \n\n", pwd);

	if(authenticate(login, pwd, cn)){
		//retry2: if(++try_f > 3) return 0; // goto retry2, re-enter classid
		printf("select the type of vehicle: \n");
		lire(classid, 200);
		
		strcpy(query,"select distinct veh.carnum, veh.classid from veh WHERE classid='");
	    strcat(query,classid);
	    //inquiry protection below
		/*
	    if(strstr(classid,"=") != NULL || strstr(classid,"Null") != NULL){
			printf("symbol not allowed!\n");
			goto retry2;
		} 
		*/
		strcat(query,"'");

	    exit_code = connect_dbms(&cn2);
	    exit_code = executeQuery(query, cn);
	} 
	else{
		printf("Wrong login / password\n");
		goto retry1;
	}
	
	// executer la requête et afficher le résultat:


    return 0;
}

