#ZakFit

ZakFit est une application iOS de **suivi forme & nutrition** pensée pour accompagner l’utilisateur au quotidien : activité physique, alimentation, poids, énergie…  
L’objectif : proposer un **coach de poche simple, motivant et moderne**, sans côté “hardcore muscu”, mais avec une vraie exigence de suivi.

---

##  Vision

- Aider l’utilisateur à **mieux s’entraîner**, **mieux manger** et **mieux se connaître**.
- Offrir une expérience **fluide, premium et agréable**, qui s’intègre naturellement dans la routine de la journée.
- Utiliser l’**intelligence artificielle** (Apple Intelligence, modèles open-source, etc.) pour fournir des **conseils personnalisés** et des **calculs intelligents** (objectifs, besoins, progression).

---

## Fonctionnalités principales

> Certaines fonctionnalités sont en cours de développement ou prévues dans la roadmap.

### Accueil

- Tableau de bord récapitulatif de la journée :
  - activité / séances
  - repas et apports
  - poids / mesures
  - niveau d’énergie / ressenti
- Accès rapide aux actions importantes via un **bouton central “+”** (quick actions).

### Fitness

- Suivi des **séances de sport** (musculation, cardio, etc.).
- Historique des entraînements et visualisation des progrès.
- Utilisation d’icônes claires (ex : `dumbbell.fill`) et d’une interface inspirée de la **tab bar “liquid glass”**.

### Nutrition

- Ajout de **repas / collations** de la journée.
- Suivi des apports (calories et macros selon les itérations).
- Conseils ou ajustements basés sur les objectifs.

### Profil & objectifs

- Informations personnelles (âge, poids, taille, niveau d’activité…).
- Définition d’**objectifs** (perte de poids, maintien, prise de masse, mieux manger…).
- Paramètres de personnalisation de l’expérience (notifications, préférences, unités, etc.).

### IA & assistance

- Intégration prévue d’une **IA intégrée à l’app** pour :
  - proposer des **conseils contextualisés** (ex. “tu es en retard sur tes protéines aujourd’hui”),
  - aider à **raisonner sur les données** (progression, cohérence des séances, charge globale),
  - calculer des **recommandations d’objectifs quotidiens**.
- Support envisagé :
  - **Apple Intelligence** (quand disponible),
  - ou **modèles open source** adaptés au mobile / backend (Mistral, etc.).

---

##  Stack technique

- **Plateforme** : iOS
- **Langage** : Swift
- **UI** : SwiftUI
- **Architecture** : MVVM (vues réactives, ViewModels observables)
- **Design** :
  - Tab bar personnalisée **“liquid glass”** avec bouton d’action rapide central,
  - Icônes SF Symbols (ex. `house.fill`, `fork.knife`, `dumbbell.fill`, `person.crop.circle`),
  - Palette dorée / sable pour l’identité visuelle de ZakFit.
- **Cible** : iOS 17+ (à adapter selon le projet).

---

##  Installation & lancement

1. Cloner le dépôt :

   ```bash
   git clone https://github.com/<owner>/ZakFit.git
   cd ZakFit

