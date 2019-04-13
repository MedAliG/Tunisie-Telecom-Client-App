-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  sam. 06 avr. 2019 à 20:38
-- Version du serveur :  10.1.25-MariaDB
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `tta`
--

-- --------------------------------------------------------

--
-- Structure de la table `forfait`
--

CREATE TABLE `forfait` (
  `id` int(11) NOT NULL,
  `montant` int(11) NOT NULL,
  `duree` int(11) NOT NULL,
  `prix` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `forfait`
--

INSERT INTO `forfait` (`id`, `montant`, `duree`, `prix`) VALUES
(1, 225, 1, 1),
(2, 1024, 7, 5);

-- --------------------------------------------------------

--
-- Structure de la table `forfaithistory`
--

CREATE TABLE `forfaithistory` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `forfaitId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `forfaithistory`
--

INSERT INTO `forfaithistory` (`id`, `date`, `forfaitId`, `userId`) VALUES
(1, '2019-03-28 13:14:03', 1, 1),
(2, '2019-03-28 13:14:34', 1, 1),
(3, '2019-04-05 15:57:52', 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `recharge`
--

CREATE TABLE `recharge` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `montant` double NOT NULL,
  `code_utilise` varchar(128) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `recharge`
--

INSERT INTO `recharge` (`id`, `date`, `montant`, `code_utilise`, `userId`) VALUES
(1, '2019-03-28 12:53:54', 5, '26547895654232', 1),
(2, '2019-03-28 12:54:51', 6, '26547895654232', 1);

-- --------------------------------------------------------

--
-- Structure de la table `transferhistory`
--

CREATE TABLE `transferhistory` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `senderId` int(11) NOT NULL,
  `receiverId` int(11) NOT NULL,
  `montant` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `transferhistory`
--

INSERT INTO `transferhistory` (`id`, `date`, `senderId`, `receiverId`, `montant`) VALUES
(1, '2019-03-28 13:49:10', 1, 2, 100),
(2, '2019-04-05 13:21:56', 1, 3, 0),
(3, '2019-04-05 13:22:18', 1, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `fullName` varchar(128) NOT NULL,
  `sold` double NOT NULL,
  `sold_internet` int(11) NOT NULL,
  `fin_sold` int(11) NOT NULL,
  `fin_sold_internet` int(11) NOT NULL,
  `bonus` double NOT NULL,
  `bonus_days_left` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `phone`, `password`, `fullName`, `sold`, `sold_internet`, `fin_sold`, `fin_sold_internet`, `bonus`, `bonus_days_left`) VALUES
(1, '96245100', '21232f297a57a5a743894a0e4a801fc3', 'Zouaoui Achref', 10.5, 875, 12, 2, 600, 2),
(2, '98424462', '24171837at', 'Ahmed Mezrgi', 0, 0, 0, 0, 0, 0),
(3, '98424463', '5e94b0f3530ccfa1c0d43da558dd2092', 'Ahmed Mezrgi', 1, 0, 0, 0, 0, 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `forfait`
--
ALTER TABLE `forfait`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `forfaithistory`
--
ALTER TABLE `forfaithistory`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `recharge`
--
ALTER TABLE `recharge`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `transferhistory`
--
ALTER TABLE `transferhistory`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `forfait`
--
ALTER TABLE `forfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `forfaithistory`
--
ALTER TABLE `forfaithistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `recharge`
--
ALTER TABLE `recharge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `transferhistory`
--
ALTER TABLE `transferhistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
