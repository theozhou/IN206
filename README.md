# IN206
Projet de Base de données
Documents et programmes exemples sur http://www-smis.inria.fr/~anciaux/ENSTA/IN206/5-projet </br>
# Objectif :
L'objectif est de se familiariser avec des aspects importants pour le développement d'applications utilisant des bases de données. Dans une première étape, vous devez construire un MCD permettant de modéliser une base de location de voitures. Dans une deuxième étape, vous réaliserez le MLD correspondant; puis implanterez le MPD sous Oracle Express. Enfin, vous insèrerez quelques données, judicieusement choisies par rapport aux questions Q1 à Q5 dont vous donnerez le texte SQL dans la partie 3. Dans la partie 4, vous testerez l'appel d'une base de données depuis C. Pour cela, vous utiliserez le driver Oracle open source OCILIB/OCI (http://www.ocilib.net). Un exemple simple permettant de débuter vous est fourni. Sur la base de cet exemple, il vous est demandé de réaliser une application simpliste. Enfin, vous tenterez de réaliser une attaque au processus d'identification que vous aurez développé, montrant qu'une mauvaise programmation peut générer des failles importantes.
# Partie 1 – Réalisation du MCD
Il faudra créer le MCD en se basant d'une part sur le (court) texte décrivant le contexte associé ainsi que sur les questions Q1 à Q5 indiquées et qui seront utilisées dans la partie 3. Ainsi, le MCD créé devra permettre de stocker les informations nécessaires pour pouvoir répondre à ces questions et, si possible, pas plus. La création d'un MCD plus complexe est en général source d'erreurs. Dans tous les cas, vous aurez au plus 7 entités ou associations au total. Il n'y a pas une seule bonne solution, tout comme, nous l'avons vu en cours, il n'y a pas une seule bonne modélisation. La modélisation sera considérée correcte à partir du moment où les choix sont justifiés et pertinents. Aussi, en cas de doute ou d'imprécision dans le contexte, vous pourrez apportez toutes sortes de précisions, en les justifiant, dans le texte accompagnant le MCD.
Location de voitures : Une agence de location de voitures souhaite gérer son parc locatif. Chaque véhicule est d'une certaine catégorie (A, B, C, D, E) indiquant le tarif journalier, etc. Les clients louent des voitures pour une certaine durée (on ignorera les forfaits, etc.).</br>
**Q1** : Liste des catégories triées par prix à la journée </br>
**Q2** : Liste des locations de véhicules de catégorie E triés par date</br>
**Q3** : Liste des véhicules jamais loués </br>
**Q4** : Nombre de locations par catégorie</br>
**Q5** : Vérifiez qu'un véhicule donné n'est pas loué deux fois (ou plus) à la même période</br>
# Partie 2 – Réalisation du MLD et MPD
Utilisez les règles de transformation vues en cours et les règles de vérification et proposez un MLD correspondant au MCD de la Partie 1. Si vous simplifiez le MLD, justifiez vos simplifications. Donnez le texte SQL de création de la base (en le testant sur Oracle Express) en :
+ Choisissant le bon type pour chaque attribut </br>
+ Pensant à rajouter les contraintes de clé primaire (en les nommant)
+ Pensant à rajouter les contraintes d'intégrité référentielles (en les nommant)

Insérez un jeu de données permettant de tester les requêtes de la partie 3.
# Partie 3 – Questions SQL
Donnez le texte SQL correspondant aux questions Q1 à Q5 et vérifiez-les sur Oracle Express.
# Partie 4 – Application
Sur le modèle de l'application TestDB (code fourni), construisez un petit programme qui :
+ Se connecte à la base de données comme l’utilisateur «TP»
+ Demande un login (saisi au clavier) et un mot de passe (saisi au clavier) et va vérifier dans une table «Logins», créée préalablement dans Oracle, l'existence du couple login/password.
+ Si le login/mot de passe existe, demande une catégorie de véhicule et affiche l’immatriculation des véhicules de la catégorie correspondante.
# Partie 5 – Attaque et correction
Réalisez des attaques par injection de code SQL sur votre petit programme.
+ Par injection, sans modifier le programme C, contournez le mécanisme d'authentification créé dans la partie 1.
+ Par injection, récupérez, sans modifier le programme C, le nom des clients et leur mot de passe
+ Corrigez votre programme pour qu’il soit résistant à ces attaques.

**Documents supports et démo à prévoir pour le jour de la soutenance :** 
* MCD
* MLD + texte SQL de création
* Texte SQL des questions
* Code source C de l’application testé, et prêt à faire une démo des opérations suivantes :
  + Connexion avec le bon login/pwd, sélection d’une catégorie
  - Connexion avec un mauvais login/pwd
  - Connexion sans login (injection SQL n°1)
  - Protection injection SQL n°1
  - Affichage de la liste des clients (injection SQL n°2)
  - Protection injection SQL n°2
