-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recipedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `recipedb` ;

-- -----------------------------------------------------
-- Schema recipedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recipedb` DEFAULT CHARACTER SET utf8 ;
USE `recipedb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NULL,
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `image_url` VARCHAR(2000) NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `biography` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(200) NULL,
  `kcals_per_serving` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `directions` TEXT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `user_id` INT NOT NULL,
  `active` TINYINT NULL,
  `prepminutes` INT NULL,
  `cookminutes` INT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `comment` TEXT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `active` TINYINT NULL,
  `in_reply_to` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user_idx` (`user_id` ASC),
  INDEX `fk_comment_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_comment_comment1_idx` (`in_reply_to` ASC),
  CONSTRAINT `fk_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`in_reply_to`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite` ;

CREATE TABLE IF NOT EXISTS `favorite` (
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_user_has_recipe_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_user_has_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_recipe_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `made_this`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `made_this` ;

CREATE TABLE IF NOT EXISTS `made_this` (
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `makedate` DATETIME NULL,
  `rating` INT NULL,
  `comment` VARCHAR(2000) NULL,
  `image_url` VARCHAR(200) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_user_has_recipe_recipe2_idx` (`recipe_id` ASC),
  INDEX `fk_user_has_recipe_user2_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_recipe_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_recipe_recipe2`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `keyword` ;

CREATE TABLE IF NOT EXISTS `keyword` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag` ;

CREATE TABLE IF NOT EXISTS `tag` (
  `recipe_id` INT NOT NULL,
  `keyword_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `keyword_id`),
  INDEX `fk_recipe_has_keyword_keyword1_idx` (`keyword_id` ASC),
  INDEX `fk_recipe_has_keyword_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_has_keyword_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_has_keyword_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `keyword` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_photo` ;

CREATE TABLE IF NOT EXISTS `recipe_photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NULL,
  `sequence_number` INT NULL,
  `caption` VARCHAR(200) NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_photo_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_photo_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_ingredient` ;

CREATE TABLE IF NOT EXISTS `recipe_ingredient` (
  `recipe_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `amount` VARCHAR(10) NULL,
  `measure` VARCHAR(20) NULL,
  `preparation` VARCHAR(50) NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`),
  INDEX `fk_recipe_has_ingredient_ingredient1_idx` (`ingredient_id` ASC),
  INDEX `fk_recipe_has_ingredient_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_has_ingredient_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS chef;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'chef' IDENTIFIED BY 'chef';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'chef';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (1, 'chef', '$2a$10$lKJKCiDz1aLg.wfBkdkipueBmNpuWGwz8UWqCEx66tDPyWNqgFlE6', 'chef@example.com', 'ROLE_ADMIN', 1, '2022-06-22', NULL, 'https://lh3.googleusercontent.com/9zdWGQpNh8dwkWTSPoWlN3G6_0iosfxRHQ3X6shizlsijT2IRpPGmZWvAqo3-8a59i5ilnL27-ZSLS3UbpZR39DrI_Km--QZJibX6iFxo-KqYdGJruA_1714mS3keRH2ZTKBkkYI56WIdV2Qg0H7NrW2ACAnn6y5IXsDqp6kjMnfOgNc5W0ZVrLgB70Z-mO-BpoH0YwLHDrw17nuzI2uXatz9rEUYBpPb-I21_UOZuG8Lm80eZR9bFWaTi4WtMrzEKFyG9gmllk7T80cgAB5HjK9LYuq3SIMqE1mqKwl3cKFJBAPSkQMrI7--7LhOnHU6Vjt9CoKrdCTIqeCQZiISDad9HH62Df7RMZPqALUFsMirTxrPr14HVqRpwJV6_3a_4pjWD_7iggDbP78d8OOcC4nooYMJikI2xofYaCgy-2XhCbkKuzd4hFb08tMrg3LFWXPuK-OvId_fEF49B2L4hGG1oHdqocFJwAT_t3jZyvAkbtvAzqdSNA4ngk9VRHdiK1_6ctrp6QGL27cFt0TRkOAgz4PjtZKM8kw_IubwMvJw9Oe7Er3aGS_GkRRmxDiNWgfqlMm_5IerQhGAKcylCLuqFNKpFGhpsLZCzCi4LS0sAJr360ytQVRAujPiA_VRtZu_1LbP3bTs-_RSUwxpXjuIqAGdlMqywaSTq4KdV2iNG-tKrzZ9hatzzgX1CxaBWW_uMb94zipvzLvAPMDzyhr8fFE8zwXaDQNUUnGJOdqzJz1azDHmHGoHkrPPA=w852-h796-no?authuser=0', 'Chef', 'Supreme', 'I make Gordon Ramsey look compassionate. Get out of my kitchen.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (2, 'amateur', '$2a$10$s/dQwtE1EgUB5iLCFVBtY.BcNdLGNG85b2hS3.qbe.WIuVkwXPG9C', 'amateur@example.com', 'ROLE_USER', 1, '2022-06-22', NULL, NULL, 'Amateur', 'Cook', 'I grew up smelling the amazing foods my grandmother used to make in the kitchen. Since then, I\'ve been seeking the best peanut butter and jelly recipe the world has to offer.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (3, 'TEMP', '$2a$10$nuZxWkvxgY797dKfJ0Kwle5Ukqw1BEDULB2NVv9DCbpez12zOKv3m', 'TEMP@example.com', 'ROLE_USER', 1, '2022-06-22', NULL, NULL, 'Tempus', 'Fugit', 'Time is fleeting, get to cooking.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (4, 'bleachsquash', 'YWR2aXNvcmNhdGhlYWQ6YWR2aXNvcmNhdGhlYWQ=', 'bleachsquash@example.com', 'ROLE_USER', 1, '2016-08-30', NULL, 'https://photos.google.com/photo/AF1QipMHG1A56nLN-1clgSI_7EgZ1h4NaVWYF3ZoqOpF', 'Christopher', 'Hernandez', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (5, 'frightenedadjust', 'YmxlYWNoc3F1YXNoOmJsZWFjaHNxdWFzaA==', 'frightenedadjust@example.com', 'ROLE_USER', 1, '1909-02-23', NULL, 'https://photos.google.com/photo/AF1QipNEZmkZlqR_Xt1LFWuqRr2jzH27VYPsblmjBIyV', 'Jacqueline', 'Ortiz', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (6, 'meaningkneel', 'ZnJpZ2h0ZW5lZGFkanVzdDpmcmlnaHRlbmVkYWRqdXN0', 'meaningkneel@example.com', 'ROLE_USER', 1, '1903-01-02', NULL, 'https://photos.google.com/photo/AF1QipNTr4DJ1HB9zCQbQRiwLrowuzVRh6te6CnFIt_e', 'Amy', 'Young', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (7, 'structureacrid', 'c3RydWN0dXJlYWNyaWQ6c3RydWN0dXJlYWNyaWQ=', 'structureacrid@example.com', 'ROLE_USER', 1, '2002-02-15', NULL, 'https://photos.google.com/photo/AF1QipOVEx0_7M7maduJek9thpu5r5UY8kSK-JQ0O4c3', 'Jean', 'Cox', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (8, 'frostedpickleball', 'ZnJvc3RlZHBpY2tsZWJhbGw6ZnJvc3RlZHBpY2tsZWJhbGw=', 'frostedpickleball@example.com', 'ROLE_USER', 1, '1927-03-23', NULL, 'https://photos.google.com/photo/AF1QipO8vVzL5RFr_EuvJDI5DSOgjeOM6ZfAB9Q_KYPF', 'Robert', 'Johnson', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (9, 'counselorpress', 'Y291bnNlbG9ycHJlc3M6Y291bnNlbG9ycHJlc3M=', 'counselorpress@example.com', 'ROLE_USER', 1, '1945-01-07', NULL, 'https://photos.google.com/photo/AF1QipOqqg07QBIhuokB7T1etdz7CZNwTazU-andl0in', 'Isabella', 'Price', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (10, 'pointlesshawse', 'cG9pbnRsZXNzaGF3c2U6cG9pbnRsZXNzaGF3c2U=', 'pointlesshawse@example.com', 'ROLE_USER', 1, '2020-02-19', NULL, 'https://photos.google.com/photo/AF1QipOUCmDuHpXrja5lN5kyY0REoQR8ecTIVvAdB3CZ', 'Noah', 'Morales', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (11, 'easterlydeltas', 'ZWFzdGVybHlkZWx0YXM6ZWFzdGVybHlkZWx0YXM=', 'easterlydeltas@example.com', 'ROLE_USER', 1, '1978-03-29', NULL, 'https://ibb.co/p3N742S', 'Joan', 'Stewart', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (12, 'creamybattenburg', 'Y3JlYW15YmF0dGVuYnVyZzpjcmVhbXliYXR0ZW5idXJn', 'creamybattenburg@example.com', 'ROLE_USER', 1, '2022-06-08', NULL, 'https://photos.google.com/photo/AF1QipNkU99qibgFKClfrRvfPkIuBVPNhuR3t5OTHbfh', 'Kathryn', 'Ramos', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (13, 'consistentshameless', 'Y29uc2lzdGVudHNoYW1lbGVzczpjb25zaXN0ZW50c2hhbWVsZXNz', 'consistentshameless@example.com', 'ROLE_USER', 1, '2006-02-08', NULL, 'https://photos.google.com/photo/AF1QipN6xbc7FAjpvCJzjyBbAAEtsFDgz9IOZ0D1Otpd', 'Henry', 'Parker', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (14, 'acquiredetermine', 'YWNxdWlyZWRldGVybWluZTphY3F1aXJlZGV0ZXJtaW5l', 'acquiredetermine@example.com', 'ROLE_USER', 1, '1970-04-26', NULL, 'https://photos.google.com/photo/AF1QipO3lN5qnhpOhHCXasNVW1uDvi5e2Ai90IWyafu5', 'Jason', 'Ramirez', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (15, 'weakglobe', 'd2Vha2dsb2JlOndlYWtnbG9iZQ==', 'weakglobe@example.com', 'ROLE_USER', 1, '1975-08-20', NULL, 'https://photos.google.com/photo/AF1QipP0fdNykJEwoVV8p1R1TZ1IXjxu-NIE3MR_qWcY', 'Adam', 'Turner', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (16, 'admitfairlead', 'YWRtaXRmYWlybGVhZDphZG1pdGZhaXJsZWFk', 'admitfairlead@example.com', 'ROLE_USER', 1, '1950-05-28', NULL, 'https://photos.google.com/photo/AF1QipNkU99qibgFKClfrRvfPkIuBVPNhuR3t5OTHbfh', 'Jesse', 'Kim', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (17, 'quietoccasionally', 'cXVpZXRvY2Nhc2lvbmFsbHk6cXVpZXRvY2Nhc2lvbmFsbHk=', 'quietoccasionally@example.com', 'ROLE_USER', 1, '1982-10-07', NULL, 'https://photos.google.com/photo/AF1QipP0fdNykJEwoVV8p1R1TZ1IXjxu-NIE3MR_qWcY', 'Nicholas', 'Allen', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (18, 'analysiswhat', 'YW5hbHlzaXN3aGF0OmFuYWx5c2lzd2hhdA==', 'analysiswhat@example.com', 'ROLE_USER', 1, '1965-11-28', NULL, 'https://photos.google.com/photo/AF1QipODj63laSJh1K_WjXXS_vHg4MSmFI7e-yKNiU8E', 'Roger', 'Gutierrez', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (19, 'illfateddna', 'aWxsZmF0ZWRkbmE6aWxsZmF0ZWRkbmE=', 'illfateddna@example.com', 'ROLE_USER', 1, '1961-02-28', NULL, 'https://photos.google.com/photo/AF1QipP5jiiuqnxn1eoIY_CgxJXEUaiDomKjdUyXRdyt', 'George', 'White', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (20, 'obstinacypost', 'b2JzdGluYWN5cG9zdDpvYnN0aW5hY3lwb3N0', 'obstinacypost@example.com', 'ROLE_USER', 1, '1919-01-15', NULL, 'https://photos.google.com/photo/AF1QipNUurG9Vw_9pZJNgoRpGGOPH4WZGrrJrF9iU5Py', 'Betty', 'Gonzales', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (21, 'alembicstudious', 'YWxlbWJpY3N0dWRpb3VzOmFsZW1iaWNzdHVkaW91cw==', 'alembicstudious@example.com', 'ROLE_USER', 1, '1937-11-22', NULL, 'https://photos.google.com/photo/AF1QipP4MD2uVbipaX09x_bFHi7iIptOn6tPiOcUERpf', 'Russell', 'Myers', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (22, 'teacherright', 'dGVhY2hlcnJpZ2h0OnRlYWNoZXJyaWdodA==', 'teacherright@example.com', 'ROLE_USER', 1, '1995-01-02', NULL, 'https://photos.google.com/photo/AF1QipN9qgSgTwNrdyLn_FZgOZYZkCs7q_-9Kz7e2yXN', 'Randy', 'Price', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (23, 'operateneed', 'b3BlcmF0ZW5lZWQ6b3BlcmF0ZW5lZWQ=', 'operateneed@example.com', 'ROLE_USER', 1, '2004-07-11', NULL, 'https://photos.google.com/photo/AF1QipM0UZiqBIPLKm060htEY7306GmCH4enqPvO6OwM', 'Debra', 'Baker', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (24, 'statementpolitician', 'c3RhdGVtZW50cG9saXRpY2lhbjpzdGF0ZW1lbnRwb2xpdGljaWFu', 'statementpolitician@example.com', 'ROLE_USER', 1, '1923-10-12', NULL, 'https://photos.google.com/photo/AF1QipMDld1kMSntZSMsInGN6EMqC-5J-eym2mWUYFZU', 'Catherine', 'Mitchell', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (25, 'shakesquirrel', 'c2hha2VzcXVpcnJlbDpzaGFrZXNxdWlycmVs', 'shakesquirrel@example.com', 'ROLE_USER', 1, '1927-04-17', NULL, 'https://photos.google.com/photo/AF1QipN84aCTqxf2dTh1yBA8cLKiA64TDYoJNetAIXK-', 'Alexis', 'Foster', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (26, 'percentageskit', 'cGVyY2VudGFnZXNraXQ6cGVyY2VudGFnZXNraXQ=', 'percentageskit@example.com', 'ROLE_USER', 1, '1934-02-25', NULL, 'https://photos.google.com/photo/AF1QipPYZwqqi5nkfzZNVv3FFWFiugdMqkgdNFUxJZ5Y', 'Sarah', 'Rodriguez', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (27, 'constructclothe', 'Y29uc3RydWN0Y2xvdGhlOmNvbnN0cnVjdGNsb3RoZQ==', 'constructclothe@example.com', 'ROLE_USER', 1, '1957-10-25', NULL, 'https://photos.google.com/photo/AF1QipPxX7ckwXtLrk0-LdTBNlC4uwpZ6QkO6e2stSMR', 'Barbara', 'Garcia', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (28, 'chewbinnacle', 'Y2hld2Jpbm5hY2xlOmNoZXdiaW5uYWNsZQ==', 'chewbinnacle@example.com', 'ROLE_USER', 1, '1984-09-19', NULL, 'https://photos.google.com/photo/AF1QipNEDcrEO0KW7f6D-O5FSD_hGkx4dfjGHqln5YnP', 'Lawrence', 'Howard', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (29, 'vouchthole', 'dm91Y2h0aG9sZTp2b3VjaHRob2xl', 'vouchthole@example.com', 'ROLE_USER', 1, '1972-10-31', NULL, 'https://photos.google.com/photo/AF1QipM5e-xjNVwqLp03cJ4n6dAQQTKrmDz1A4qYRW77', 'Edward', 'Clark', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (30, 'adjustluxurious', 'YWRqdXN0bHV4dXJpb3VzOmFkanVzdGx1eHVyaW91cw==', 'adjustluxurious@example.com', 'ROLE_USER', 1, '1977-01-25', NULL, 'https://photos.google.com/photo/AF1QipMdKGZD47DJzDTv7XOXBfKRENaYdjawl8Vdf60r', 'Cheryl', 'Rogers', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (31, 'prickgrind', 'cHJpY2tncmluZDpwcmlja2dyaW5k', 'prickgrind@example.com', 'ROLE_USER', 1, '1963-06-18', NULL, 'https://photos.google.com/photo/AF1QipOMlYG_9IObHP7WcUi9IFLqlyIs27zi29j-ZVdy', 'Jose', 'Evans', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (32, 'frameworkmanner', 'ZnJhbWV3b3JrbWFubmVyOmZyYW1ld29ya21hbm5lcg==', 'frameworkmanner@example.com', 'ROLE_USER', 1, '1948-02-28', NULL, 'https://photos.google.com/photo/AF1QipP6rXZsEsnXSsKML2SaRtFxY8EcB-RBmNbg9sYJ', 'Steven', 'Taylor', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (33, 'pebblestadium', 'cGViYmxlc3RhZGl1bTpwZWJibGVzdGFkaXVt', 'pebblestadium@example.com', 'ROLE_USER', 1, '1937-09-09', NULL, 'https://photos.google.com/photo/AF1QipO5_XV1hoaPK5-oN3k_4kUdfH0VVjFkrux0RYA2', 'Patricia', 'Johnson', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (34, 'undermangoes', 'dW5kZXJtYW5nb2VzOnVuZGVybWFuZ29lcw==', 'undermangoes@example.com', 'ROLE_USER', 1, '1922-03-14', NULL, 'https://photos.google.com/photo/AF1QipOxvi1JXuMhtrJduWDEPUy32PhKfmdHgamZKt5m', 'Christopher', 'Hernandez', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (35, 'obtainablesexy', 'b2J0YWluYWJsZXNleHk6b2J0YWluYWJsZXNleHk=', 'obtainablesexy@example.com', 'ROLE_USER', 1, '1949-08-23', NULL, 'https://photos.google.com/photo/AF1QipMqOplzIrVMiCEiix3flMCin1UzX_kV4CKduVIn', 'Jacqueline', 'Ortiz', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (36, 'chocolateulna', 'Y2hvY29sYXRldWxuYTpjaG9jb2xhdGV1bG5h', 'chocolateulna@example.com', 'ROLE_USER', 1, '1937-07-16', NULL, 'https://photos.google.com/photo/AF1QipNN4nXdck4Tkcm9ofXeq7ClIOS4kmwuwMkBewmi', 'Amy', 'Young', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (37, 'pillstockings', 'cGlsbHN0b2NraW5nczpwaWxsc3RvY2tpbmdz', 'pillstockings@example.com', 'ROLE_USER', 1, '1954-10-28', NULL, 'https://photos.google.com/photo/AF1QipOTXW9gqgCDHngs1jG6d-cN5uUqYHDHwDxmAPay', 'Jean', 'Cox', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (38, 'coalibis', 'Y29hbGliaXM6Y29hbGliaXM=', 'coalibis@example.com', 'ROLE_USER', 1, '1904-05-17', NULL, 'https://photos.google.com/photo/AF1QipN8CJc9Bt5eA1-YDaorQS2GylOwnO1QCyRAP-4d', 'Robert', 'Johnson', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (39, 'actualclumsy', 'YWN0dWFsY2x1bXN5OmFjdHVhbGNsdW1zeQ==', 'actualclumsy@example.com', 'ROLE_USER', 1, '1990-12-13', NULL, 'https://photos.google.com/photo/AF1QipMm0PN5OIqpFDzpeKulaiw5DZyZJgK-8Radv2XR', 'Isabella', 'Price', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (40, 'chickenperturbed', 'Y2hpY2tlbnBlcnR1cmJlZDpjaGlja2VucGVydHVyYmVk', 'chickenperturbed@example.com', 'ROLE_USER', 1, '1904-01-01', NULL, 'https://photos.google.com/photo/AF1QipOBom6-kMi-EaE14F8jnfaRTREh8zuvO6Ayouwg', 'Noah', 'Morales', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (41, 'carrotstudent', 'Y2Fycm90c3R1ZGVudDpjYXJyb3RzdHVkZW50', 'carrotstudent@example.com', 'ROLE_USER', 1, '1917-12-08', NULL, 'https://photos.google.com/photo/AF1QipNLWJRZUnV5OOV_bGosdvQLgpOrC6le6jgswWol', 'Joan', 'Stewart', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (42, 'intentquartering', 'aW50ZW50cXVhcnRlcmluZzppbnRlbnRxdWFydGVyaW5n', 'intentquartering@example.com', 'ROLE_USER', 1, '1968-08-24', NULL, 'https://photos.google.com/photo/AF1QipNYd8ocI34kcG8kSYw77tb9VkX419LAknaFy90k', 'Kathryn', 'Ramos', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (43, 'plonkliar', 'cGxvbmtsaWFyOnBsb25rbGlhcg==', 'plonkliar@example.com', 'ROLE_USER', 1, '1976-09-04', NULL, 'https://photos.google.com/photo/AF1QipNZcar5OBq940i_iDWnB7r3k3RkoUM_T5DJmUsx', 'Henry', 'Parker', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (44, 'scoldingwhether', 'c2NvbGRpbmd3aGV0aGVyOnNjb2xkaW5nd2hldGhlcg==', 'scoldingwhether@example.com', 'ROLE_USER', 1, '1945-10-06', NULL, 'https://photos.google.com/photo/AF1QipOR9YwWPvttPG6CBjkg551qptmryUVudnJ3Vuvd', 'Jason', 'Ramirez', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (45, 'mustrichesse', 'bXVzdHJpY2hlc3NlOm11c3RyaWNoZXNzZQ==', 'mustrichesse@example.com', 'ROLE_USER', 1, '1944-08-28', NULL, 'https://photos.google.com/photo/AF1QipOYKlnDj6C4Ji0MSbDgpxwjKjeGqvqAb1s9LSkT', 'Adam', 'Turner', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (46, 'gappredict', 'Z2FwcHJlZGljdDpnYXBwcmVkaWN0', 'gappredict@example.com', 'ROLE_USER', 1, '1989-09-01', NULL, 'https://photos.google.com/photo/AF1QipOLrjahfrbPSPzroVupXFlQo23KpTXQh4wJdBER', 'Jesse', 'Kim', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (47, 'veneratedpies', 'dmVuZXJhdGVkcGllczp2ZW5lcmF0ZWRwaWVz', 'veneratedpies@example.com', 'ROLE_USER', 1, '1989-05-05', NULL, 'https://photos.google.com/photo/AF1QipPo5jULauV8K1C2BDMXa6CKeEZtR4KdfKsXLm7Z', 'Nicholas', 'Allen', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (48, 'technicianoracle', 'dGVjaG5pY2lhbm9yYWNsZTp0ZWNobmljaWFub3JhY2xl', 'technicianoracle@example.com', 'ROLE_USER', 1, '1957-07-07', NULL, 'https://photos.google.com/photo/AF1QipNEZmkZlqR_Xt1LFWuqRr2jzH27VYPsblmjBIyV', 'Roger', 'Gutierrez', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (49, 'strutfighting', 'c3RydXRmaWdodGluZzpzdHJ1dGZpZ2h0aW5n', 'strutfighting@example.com', 'ROLE_USER', 1, '2021-06-04', NULL, 'https://photos.google.com/photo/AF1QipMHG1A56nLN-1clgSI_7EgZ1h4NaVWYF3ZoqOpF', 'George', 'White', 'I like beef.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (50, 'marbledscreech', 'bWFyYmxlZHNjcmVlY2g6bWFyYmxlZHNjcmVlY2g=', 'marbledscreech@example.com', 'ROLE_USER', 1, '1969-08-31', NULL, 'https://photos.google.com/photo/AF1QipNTr4DJ1HB9zCQbQRiwLrowuzVRh6te6CnFIt_e', 'Betty', 'Gonzales', 'My sweet tooth means I\'m here for dessert!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (51, 'smileyblotched', 'c21pbGV5YmxvdGNoZWQ6c21pbGV5YmxvdGNoZWQ=', 'smileyblotched@example.com', 'ROLE_USER', 1, '2015-12-17', NULL, 'https://photos.google.com/photo/AF1QipOVEx0_7M7maduJek9thpu5r5UY8kSK-JQ0O4c3', 'Russell', 'Myers', 'We\'re makin\' bacon!');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (52, 'bowermuscle', 'Ym93ZXJtdXNjbGU6Ym93ZXJtdXNjbGU=', 'bowermuscle@example.com', 'ROLE_USER', 1, '1924-01-26', NULL, 'https://photos.google.com/photo/AF1QipO8vVzL5RFr_EuvJDI5DSOgjeOM6ZfAB9Q_KYPF', 'Randy', 'Price', 'Raised in a small village full of large vegetables. Avid home cook, avid gardener. Ready to use up these treasures before they spoil.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (53, 'advisorcathead', 'YWR2aXNvcmNhdGhlYWQ6YWR2aXNvcmNhdGhlYWQ=', 'advisorcathead@example.com', 'ROLE_USER', 1, '1973-10-02', NULL, 'https://photos.google.com/photo/AF1QipOUCmDuHpXrja5lN5kyY0REoQR8ecTIVvAdB3CZ', 'Debra', 'Baker', 'I like beef.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (1, 'Peanut Butter', 'Peanut butter is a food paste or spread made from ground, dry-roasted peanuts. It commonly contains additional ingredients that modify the taste or texture, such as salt, sweeteners, or emulsifiers.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/PeanutButter.jpg/1024px-PeanutButter.jpg', NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (2, 'Jelly', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (3, 'Bread', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (4, 'White Truffle', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (5, 'Tagliolini', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (6, 'Heavy Cream', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (7, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (8, 'Black Pepper', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (9, 'Parmesan Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (10, 'Salt', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (11, 'Shrimp', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (12, 'Spaghetti', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (13, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (14, 'Meyer Lemon', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (15, 'Broccoli', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (16, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (17, 'Quark', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (18, 'Crushed Red Pepper Flakes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (19, 'Egg Noodles', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (20, 'Fontina Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (21, 'Sunchokes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (22, 'Whole Mile', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (23, 'Kale', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (24, 'All-Purpose Flour', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (25, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (26, 'Shallot', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (27, 'Casserole Spice Blend', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (28, 'Cod Fillets', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (29, 'Jasmine Rice', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (30, 'Carrots', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (31, 'Radishes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (32, 'Scallions', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (33, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (34, 'Baby Kale', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (35, 'Tempura Mix', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (36, 'Rice Vinegar', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (37, 'Golden Mountain Sauce', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (38, 'Sambal Oelek', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (39, 'Tamarind Concentrate', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (40, 'Verjus Rouge', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (41, 'Capers', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (42, 'Crushed Red Pepper Flakes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (43, 'Ground Lamb & Beef Blend', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (44, 'Cremini Mushrooms', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (45, 'Scallions', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (46, 'Russet Potatoes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (47, 'Celery', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (48, 'Chives', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (49, 'Grated Parmesan Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (50, 'Tomato Paste', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (51, 'Soy Glaze', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (52, 'Lamb & Beef Spice Blend', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (53, 'Boneless, Center-Cut Pork Chops', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (54, 'Cracked Freekah', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (55, 'Clementine', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (56, 'Brussels Sprouts', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (57, 'Piece Ginger', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (58, 'Shallot', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (59, 'Apple Cider Vinegar', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (60, 'Sugar', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (61, 'Pearl Couscous', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (62, 'Boneless, Skinless Chicken Breasts', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (63, 'butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (64, 'Blood Orange', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (65, 'Broccoli', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (66, 'Shallot', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (67, 'Boneless, Skinless Chicken Breasts', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (68, 'Wooden Skewers', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (69, 'Semi-Pearled Khorasan Wheat', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (70, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (71, 'Persimmon', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (72, 'Kale', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (73, 'Red Wine Vinegar', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (74, 'Red Harissa Paste', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (75, 'Labneh Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (76, 'Shrimp', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (77, 'Bucatini Pasta', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (78, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (79, 'Scallions', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (80, 'Kale', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (81, 'Lemon', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (82, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (83, 'Crushed Red Pepper Flakes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (84, 'Fettuccine Pasta', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (85, 'Cremini Mushrooms', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (86, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (87, 'Hakurei Turnips', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (88, 'Fennel Bulb', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (89, 'Parsley', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (90, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (91, 'Mascarpone Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (92, 'Shallot', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (93, 'Catfish Fillets', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (94, 'Jasmine Rice', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (95, 'Lime', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (96, 'Kale', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (97, 'Rice Flour', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (98, 'Yellow Curry Paste', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (99, 'Ginger', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (100, 'Bird&#39;s Eye Chile', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (101, 'Coconut Palm Sugar', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (102, 'Ponzu Sauce', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (103, 'Coconut Milk Powder', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (104, 'Empanada Wrappers', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (105, 'Monterey Jack Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (106, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (107, 'Butternut Squash', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (108, 'Green Tomato', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (109, 'Lime', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (110, 'Yellow Onion', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (111, 'Cilantro', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (112, 'Jalapeno Pepper', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (113, 'Mexican Crema', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (114, 'Mexican Spice Blend', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (115, 'Skin-on Salmon Fillets', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (116, 'Brussels Sprouts', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (117, 'Granny Smith Apple', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (118, 'Lemon', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (119, 'Purple Top Turnip', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (120, 'Yukon Gold Potato', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (121, 'Parsley', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (122, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (123, 'Brown & Yellow Mustard Seeds', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (124, 'Whole Wheat Rigatoni Pasta', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (125, 'Fontina Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (126, 'Milk', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (127, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (128, 'Cone Cabbage', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (129, 'Yukon Gold Potato', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (130, 'Yellow Onion', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (131, 'Sage', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (132, 'All-Purpose Flour', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (133, 'Butter', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (134, 'Grated Parmesan Cheese', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (135, 'Catfish Fillets', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (136, 'White Basmati Rice', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (137, 'Green Beans', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (138, 'Garlic', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (139, 'Lime', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (140, 'Cilantro & Mint', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (141, 'Golden Raisins', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (142, 'Ginger', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (143, 'Dried Coconut Flakes', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (144, 'Curry Catfish Spice Blend', NULL, NULL, NULL);
INSERT INTO `ingredient` (`id`, `name`, `description`, `image_url`, `kcals_per_serving`) VALUES (145, 'Chutney Spice Blend', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (1, 'Gourmet Peanut Butter and Jelly', 'Could you ever imagine a peanut butter and jelly sandwich as decadent? Try this gourmet PB&J, and you\'ll reassess everything you\'ve previously understood about this classic.', '1. Gather the ingredients. 2. Prepare peanut butter sandwich using desired jelly or jam. Make sure it isn\'t too runny because the sandwich will be heated and jam could leak out. 3. Heat a frying pan to melt 1 tablespoon of butter. Tilt pan so butter covers pan evenly. This is key to get a perfectly crispy crust on the bread. 3. Heat a frying pan to melt 1 tablespoon of butter. Tilt pan so butter covers pan evenly. This is key to get a perfectly crispy crust on the bread.\n4. Butter one side of sandwich. Place buttered-side down in the pan. If possible, place a steak weight or bacon press on sandwich so it cooks evenly. When one side is golden brown, butter other side. Turn sandwich over and place weight back on sandwich. The second side will cook faster because sandwich is already heated.\n5. Remove sandwich from pan, cut diagonally and serve immediately.\n Looking for other ways to perk up your beloved PB&J? Here are some other ways to enjoy this common childhood favorite:\n\nTry spreading it on French toast that\'s fresh off the griddle.\n\nFor a fun twist, try a sandwich with waffles instead of bread. Just slather some peanut butter and jelly onto waffles. You will not necessarily need syrup in this case, but you can, of course, add it if you\'d like.\n\nInstead of bulky bread, try putting the peanut butter and jelly on a healthy wrap. It may be slimmer in volume, but the taste will shine.', '2022-06-22', NULL, 2, 1, 15, 0, 'https://www.thespruceeats.com/thmb/FmaSdft8pDaACmAOOQYihT10bmY=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-05-c0dfd1a8315b4762907829c6dd10358c.jpg');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (2, 'Tagliolini with White Truffle', 'It’s truffle season here in Northern Italy and tagliolini are among the most popular pastas eaten with this king of the Italian kitchen. Truffles are most definitely an acquired taste and not everybody likes them. However, those who do will tell you there’s almost nothing better in the world of mother nature’s culinary delicacies.', '1. Put a pan of water on to boil. Add salt when it starts to boil and bring to the boil again. Cook the tagliolini as per the instructions on the packet until they are \'al dente\'. Save some of the cooking water before draining. 2. In the meantime wipe the truffle with a damp cloth to remove any soil particles and grate half of it. 3. Melt the butter in a large frying pan until it foams. 4. Add the grated truffle to the butter and 1 or 2 tablespoons of the pasta cooking water. 5. Add the cooked pasta to the butter, sprinkle with some grated Parmesan and cook over a gentle heat for a minute whilst stirring the pasta to coat it with the sauce. 6. Divide the pasta among 4 warmed plates, sprinkle a little more Parmesan onto the pasta and finally shave the remaining truffle over the top of the dish. 7. Serve immediately. Buon appetito!', '2022-06-22', NULL, 1, 1, 10, 20, 'https://www.the-pasta-project.com/wp-content/uploads/2016/11/tagliolini-with-white-truffle-2-590x433.jpg');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (3, ' Creamy Shrimp Spaghetti', ' \'with Broccoli & Meyer Lemon\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-02-02', NULL, 6, 1, 25, 25, 'https://media.blueapron.com/recipes/2098/square_newsletter_images/1484849088-4-5728/130-2PF-creamy-shrimp-spaghetti-14497_v2_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (4, ' Sunchoke & Egg Noodle Casserole', ' \'with Kale & Mornay Sauce\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-02-02', NULL, 2, 1, 15, 15, 'https://media.blueapron.com/recipes/2100/square_newsletter_images/1485203052-4-1675/130-2PV1-Sunchoke-Egg-Noodle-Casserole-20345_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (5, ' Tempura Fried Cod', ' \'with Thai-Style Vegetable Salad & Jasmine Rice\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-02-02', NULL, 5, 1, 15, 35, 'https://media.blueapron.com/recipes/2132/square_newsletter_images/1486678508-4-0006-5209/220-2PF-Tempura-Fried-Cod-20606_x1c_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (6, ' Baked Whole Wheat Rigatoni', ' \'With Cone Cabbage & Sage\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-10-10', NULL, 30, 1, 15, 50, 'https://media.blueapron.com/recipes/1858/square_newsletter_images/1473297201-4-7818/101016_V1_RigatoniBake0714_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (7, ' Seared Salmon & Fall Vegetables', ' \'With Apple-Brown Butter Vinaigrette\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-10-10', NULL, 22, 1, 20, 25, 'https://media.blueapron.com/recipes/1856/square_newsletter_images/1475270682-4-8523/101016_2PF_SearedSalmon-0969_Reshoot_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (8, ' Harissa Chicken Skewers', ' \'With Khorasan Wheat & Persimmon Salad\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-01-01', NULL, 25, 1, 50, 45, 'https://media.blueapron.com/recipes/2008/square_newsletter_images/1478206004-4-6235/120516_2PP_HarissaChickenSkewers-2798_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (9, ' Spicy Shrimp & Bucatini Pasta', ' \'With Kale\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-12-12', NULL, 11, 1, 55, 55, 'https://media.blueapron.com/recipes/1933/square_newsletter_images/1478203767-4-2532/120516_2PF_ShrimpPasta-3205_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (10, ' Mushroom & Fennel Fettuccine', ' \'With Hakurei Turnips & Mascarpone Cheese\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-11-11', NULL, 37, 1, 50, 50, 'https://media.blueapron.com/recipes/1870/square_newsletter_images/1474051642-4-8225/101716_2V2_MushroomFettucine-1155_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (11, ' Crispy Catfish', ' \'With Yellow Curry & Bird&#39;s Eye Chile Sauce\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-11-11', NULL, 47, 1, 25, 30, 'https://media.blueapron.com/recipes/1867/square_newsletter_images/1475789651-4-4870/101716_2F_ThaiCatfishCurry_Reshoot1377_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (12, ' Lamb', ' \'Beef & Mushroom Stew with Parmesan Potatoes & Chives\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 51, 1, 50, 5, 'https://media.blueapron.com/recipes/2133/square_newsletter_images/1486678488-4-0003-9207/220-2PM-Lamb-Beef-Mushroom-Stew-20835_x1b_WEB_Center.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (13, ' Pork Chops & Freekeh Salad', ' \'with Brussels Sprouts & Clementine Chutney\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-01-01', NULL, 7, 1, 30, 35, 'https://media.blueapron.com/recipes/2020/square_newsletter_images/1478808801-4-5222/121216_2PM_PorkChopswithFreekahSalad-3391_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (14, ' Seared Chicken & Pearl Couscous', ' \'With Crispy Capers & Blood Orange Souce\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-03-03', NULL, 51, 1, 0, 40, 'https://media.blueapron.com/recipes/2131/square_newsletter_images/1486756671-4-0003-1796/220-2PP-Seared-Chicken-Crispy-Capers-19997_x1b_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (15, ' Spicy Butternut Squash Empanadas', ' \'With Green Tomato Salsa & Lime Crema\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-10-10', NULL, 19, 1, 55, 20, 'https://media.blueapron.com/recipes/1859/square_newsletter_images/1473297229-4-9647/101016_V2_ButternutSquashEmpenadas0687_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (16, ' Curried Catfish & Coconut Rice', ' \'With Green Beans & Golden Raisin Chutney\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-08-08', NULL, 44, 1, 0, 30, 'https://media.blueapron.com/recipes/1765/square_newsletter_images/1468006980-4-4201/080816_2PF_CrispyCurryCatfish-5329_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (17, ' Brown Butter Cod', ' \'With Corn,  Shishito Peppers & Purple Potatoes\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 7, 1, 55, 45, 'https://media.blueapron.com/recipes/1751/square_newsletter_images/1467322979-4-8882/080116_2PF_CodRoastedCorn-4521_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (18, ' Seared Pork Chops & Plum Salsa', ' \'With Corn', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 30, 1, 5, 30, 'https://media.blueapron.com/recipes/1759/square_newsletter_images/1469550840-4-7776/080116_2PM_SearedPorkChops-4837_SQ_v2.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (19, ' Grilled Brie Cheese & Strawberry Jam Sandwiches', ' \'With Arugula & Walnut Salad\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-05-05', NULL, 53, 1, 10, 5, 'https://media.blueapron.com/recipes/1648/square_newsletter_images/1460744683-4-7049/2P_040516_2_GrilledBrieCheeseSandwiche-6182_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (20, ' Mushroom & Goat Cheese Quiches', ' \'With Arugula Salad & Pink Lemon Vinaigrette\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-03-03', NULL, 25, 1, 10, 50, 'https://media.blueapron.com/recipes/2174/square_newsletter_images/1488843839-4-0024-7468/313_2PV2_Mushroom_Quiches_37106_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (21, ' Spring Chicken Fettuccine', ' \'With Sauteed Asparagus, Kale & Rosemary\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 13, 1, 5, 30, 'https://media.blueapron.com/recipes/1609/square_newsletter_images/20160401-1911-4-3822/2P_032216_2_ChickenFettucine_20-_207416_20-_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (22, ' Zucchini & Parmesan Quiches', ' \'With Red Leaf Lettuce Salad & Pink Lemon Vinagrette\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-05-05', NULL, 15, 1, 40, 35, 'https://media.blueapron.com/recipes/1602/square_newsletter_images/1460750989-4-2395/2P_R_041216_1_ZucchiniGruyereQuiches-6581_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (23, ' Sumac-Spiced Salmon & Labneh', ' \'With Freekeh, Kale & Almond Salad\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 25, 1, 50, 15, 'https://media.blueapron.com/recipes/1544/square_newsletter_images/20160218-1953-4-2732/2P_021016_1_SumacSpicedSalmon_20-_203386_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (24, ' Alsatian Spiced Chicken', ' \'With Smashed Potatoes & Glazed Red Cabbage\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-04-04', NULL, 50, 1, 0, 10, 'https://media.blueapron.com/recipes/1509/square_newsletter_images/20160129-1943-3-5039/2P_012016_4_AlsationSpicedChicken_20-_201633_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (25, ' Mushroom & Collard Green Calzones', ' \'With Fresh Mozzarella & Tomato Dipping Sauce\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-04-04', NULL, 50, 1, 20, 5, 'https://media.blueapron.com/recipes/1554/square_newsletter_images/20160311-1939-4-7590/2P_020916_3_MushroomSwissChardCalzone---3244_SQ-web.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (26, ' English Pea & Goat Cheese Quiches', ' \'With Pea Shoot & Shaved Parmesan Salad\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-04-04', NULL, 17, 1, 0, 10, 'https://media.blueapron.com/recipes/1549/square_newsletter_images/20160218-2003-4-0021/2P_020916_2_EnglishPeaGoatCheeseQuiche_20-_203190_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (27, ' Steaks Au Poivre', ' \'With Crispy Fingerling Potatoes & Sauteed Kale\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-04-04', NULL, 7, 1, 15, 45, 'https://media.blueapron.com/recipes/1514/square_newsletter_images/20160128-2254-3-3533/2P_011916_3_SteakAuPoivre_20-_201517_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (28, ' Seared Salmon & Spinach-Walnut Pesto', ' \'With Purple Potato & Red Onion Hash\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-03-03', NULL, 51, 1, 0, 30, 'https://media.blueapron.com/recipes/1526/square_newsletter_images/20160206-0021-3-4127/2P_012616_2_SearedSalmonRoastedPurplePotatoes_20-_201821_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (29, ' Trinidadian Chicken Curry', ' \'With Coconut Grits & Collard Greens\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-03-03', NULL, 29, 1, 10, 0, 'https://media.blueapron.com/recipes/1524/square_newsletter_images/20160122-1646-3-9213/2P_010516_4_TriniWestIndianRoti_20-_201098_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (30, ' Spicy Shrimp Spaghetti', ' \'With Cabbage & Toasted Breadcrumbs\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-03-03', NULL, 11, 1, 25, 35, 'https://media.blueapron.com/recipes/1523/square_newsletter_images/20160122-1650-3-9793/2P_010516_1_SpicyShrimpPasta_20-_201058_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (31, ' Fresh Beet Linguine', ' \'With Goat Cheese, Swiss Chard & Toasted Walnuts\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 12, 1, 5, 40, 'https://media.blueapron.com/recipes/1489/square_newsletter_images/20160106-2301-77-7751/02082016_2PV1_20Beet_20Pasta_20with_20Greens__20Goat_20Cheese__20Fennel_20__20Walnuts-0791.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (32, ' Shiitake Mushroom & Cabbage Dumplings', ' \'With Garlic-Roasted Tatsoi\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-02-02', NULL, 31, 1, 5, 0, 'https://media.blueapron.com/recipes/1490/square_newsletter_images/20160201-1814-3-7969/02082016_2PV2_20Mushroom_20__20Cabbage_20Dumplings_20with_20Sauteed_20Garlic_20Tatsoi-0776_EDIT_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (33, ' Shrimp & Pineapple Fried Rice', ' \'With Toasted Cashews & Sambal Oelek\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-02-02', NULL, 50, 1, 45, 30, 'https://media.blueapron.com/recipes/583/square_newsletter_images/20160118-1600-95-3134/R_011316_3_PineappleFriedRice_20-_201371_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (34, ' Chicken Meatballs & Creamy Polenta', ' \'With Tomato Sugo $ Lacinato Kale\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-01-01', NULL, 45, 1, 25, 50, 'https://media.blueapron.com/recipes/1474/square_newsletter_images/20151216-1824-36-0483/2P_120715_2_ChickenMeatballs_20-_200144_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (35, ' Roast Pork', ' \'With Sauteed Spinach & Olive Smashed Potatoes\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2016-01-01', NULL, 3, 1, 40, 40, 'https://media.blueapron.com/recipes/1178/square_newsletter_images/20160111-1845-31-3479/R_120815_5_SearedPorkSmashedPotatoes_20-_201252_20SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (36, ' Smoky Seared Cod', ' \'With Roasted Potatoes & Dates\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-03-03', NULL, 43, 1, 40, 20, 'https://media.blueapron.com/recipes/2194/square_newsletter_images/1486752672-4-0004-1037/313-2PF-Smoky-Seared-Cod-26766_20copy_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (37, ' Seared Salmon & Lemon Labneh', ' \'With Freekeh, Kale & Dates\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 34, 1, 15, 45, 'https://media.blueapron.com/recipes/2210/square_newsletter_images/1488395992-4-0003-4634/403_2PF_Salmon_Labneh_34597_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (38, ' Spinach & Fresh Mozzarella Pizza', ' \'With Olives, Bell Pepper & Ricotta Salata\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2022-06-06', NULL, 36, 1, 55, 30, 'https://media.blueapron.com/recipes/2211/square_newsletter_images/1488398923-4-0003-0078/403_2PV1_Spinach_Mozzarella_Pizza_34221_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (39, ' Penne & Arrabbiata Sauce', ' \'With Roasted Carrot & Tangelo Salad\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-04-04', NULL, 39, 1, 5, 15, 'https://media.blueapron.com/recipes/2173/square_newsletter_images/1488843878-4-0027-5511/313_2PV1_Penne_Pasta_37509_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (40, ' Chicken Under A Brick', ' \'With Roasted Vegetables & Italian Dressing\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-04-04', NULL, 49, 1, 0, 0, 'https://media.blueapron.com/recipes/2207/square_newsletter_images/1488397153-4-0003-7300/403_2PP_Brick_Style_Chicken_34725_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (41, ' Spanish-Style Potato & Chickpea Stew', ' \'With Swiss Chard & Aioli\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-04-04', NULL, 4, 1, 55, 15, 'https://media.blueapron.com/recipes/2223/square_newsletter_images/1489179624-4-0003-6122/410_2PV1_Spanish_Chickpea_Stew_35837_WEB_SQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (42, ' Spaghetti Bolognese', ' \'With Butter Lettuce Salad & Creamy Italian Dressing\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-04-04', NULL, 37, 1, 15, 0, 'https://media.blueapron.com/recipes/2220/square_newsletter_images/1491247090-4-0017-8259/410_2PM_Spaghetti_Bolognese_WEBSQ.jpg?quality=80&width=850');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (43, ' Zaatar-Spiced Chicken', ' \'With Pink Lemon Pan Sauce & Pearl Couscous\'', '1. Choppy choppy. 2. Mixy mixy. 3. Stirry stirry 4. Cooky cooky. 5. Servey Servey. 6. Yummy yummy.', '2017-04-04', NULL, 42, 1, 10, 15, 'https://media.blueapron.com/recipes/2218/square_newsletter_images/1491247013-4-0011-3221/410_2PP_Zaatar_Chicken_WEBSQ.jpg?quality=80&width=850');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `comment` (`id`, `title`, `comment`, `created`, `updated`, `user_id`, `recipe_id`, `active`, `in_reply_to`) VALUES (1, 'Mmmm....Delicious!', 'This is the best PB&J I have ever tasted!', '2022-06-22', NULL, 2, 1, 1, NULL);
INSERT INTO `comment` (`id`, `title`, `comment`, `created`, `updated`, `user_id`, `recipe_id`, `active`, `in_reply_to`) VALUES (2, 'Get out of my kitchen.', 'I like cardboard white bread. If it ain\'t broke, don\'t fix it.', '2022-06-22', NULL, 1, 1, 1, 1);
INSERT INTO `comment` (`id`, `title`, `comment`, `created`, `updated`, `user_id`, `recipe_id`, `active`, `in_reply_to`) VALUES (3, 'Food quality rises with price.', 'The more expensive a meal, the better a meal tastes. My favorite dish includes these expensive and rare white truffles.', '2022-06-22', NULL, 1, 2, 1, NULL);
INSERT INTO `comment` (`id`, `title`, `comment`, `created`, `updated`, `user_id`, `recipe_id`, `active`, `in_reply_to`) VALUES (4, 'Why must it be expensive?', 'Good food can be cheap food.', '2022-06-23', NULL, 2, 2, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (2, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (9, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (7, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (31, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (23, 40);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (33, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (12, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (5, 43);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 8);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (38, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (12, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (33, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (7, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (42, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (16, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 34);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (11, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (51, 8);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (48, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 4);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 43);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (11, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 2);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (10, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (7, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (14, 8);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (27, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (5, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (10, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (1, 6);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (14, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (10, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (36, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (51, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (36, 15);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 27);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (6, 34);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (48, 10);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (37, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 40);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (28, 15);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 34);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (32, 43);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 10);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (38, 8);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 6);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 30);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (30, 6);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 30);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 37);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (44, 6);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 35);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 4);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (22, 34);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 2);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (50, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (32, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (13, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (50, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (12, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 27);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (36, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (23, 5);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 9);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (28, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (32, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (5, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (31, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (2, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (50, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 10);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (16, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 9);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (48, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (13, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (9, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (3, 4);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (18, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 23);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (9, 35);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (44, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (27, 40);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (31, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (22, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (28, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (37, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 27);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (32, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (22, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (11, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 27);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (13, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (6, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 41);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (48, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (37, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (21, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 2);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (11, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 29);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (28, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 7);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (2, 10);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 43);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (9, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (5, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (15, 27);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (2, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (33, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (12, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (42, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (1, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (22, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 35);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (27, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (23, 33);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 23);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (3, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (38, 6);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 34);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (29, 15);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (6, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (51, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 36);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 32);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (14, 2);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 30);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 20);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (38, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (14, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (32, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 23);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (27, 23);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (28, 5);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (40, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 4);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (24, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (16, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (13, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (19, 10);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 9);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (16, 23);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (1, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 4);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 11);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (26, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (2, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (14, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (33, 12);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (49, 21);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (53, 17);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 40);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (7, 14);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (30, 9);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (12, 8);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (45, 18);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (43, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (39, 24);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (36, 38);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (16, 1);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (23, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (35, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 9);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (17, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 28);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (37, 13);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (10, 2);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 15);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (9, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (37, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (52, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (44, 39);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (30, 16);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (31, 26);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (47, 37);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (20, 25);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 19);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (34, 5);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 22);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (41, 31);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (8, 42);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (23, 15);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (25, 3);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (7, 43);
INSERT INTO `favorite` (`user_id`, `recipe_id`) VALUES (46, 19);

COMMIT;


-- -----------------------------------------------------
-- Data for table `made_this`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `made_this` (`user_id`, `recipe_id`, `makedate`, `rating`, `comment`, `image_url`, `active`) VALUES (2, 1, '2022-03-14', 5, 'What a sandwich!', 'https://cdn.pixabay.com/photo/2021/01/26/16/54/food-5952237_960_720.jpg', 1);
INSERT INTO `made_this` (`user_id`, `recipe_id`, `makedate`, `rating`, `comment`, `image_url`, `active`) VALUES (1, 1, '2022-06-22', 1, 'Get out of my kitchen.', 'https://cdn.pixabay.com/photo/2021/01/26/16/54/food-5952237_960_720.jpg', 1);
INSERT INTO `made_this` (`user_id`, `recipe_id`, `makedate`, `rating`, `comment`, `image_url`, `active`) VALUES (1, 2, '2022-06-22', 5, 'The only time food tastes good is when it costs $1000 per plate.', 'https://www.eataly.com/wp/wp-content/uploads/2019/01/Untitled-design-11.jpg', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `keyword`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (1, 'pbnj', 'Peanut Butter and Jelly', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (2, 'peanut butter', 'Peanut Butter', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (3, 'jelly', 'Jelly', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (4, 'bread', 'Bread', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (5, 'fried', 'Fried', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (6, 'frying', 'Frying', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (7, 'pasta', 'Pasta', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (8, 'tagliolini', 'Tagliolini pasta', NULL);
INSERT INTO `keyword` (`id`, `name`, `description`, `image_url`) VALUES (9, 'truffles', 'Truffles', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 1);
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 2);
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 3);
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 4);
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 5);
INSERT INTO `tag` (`recipe_id`, `keyword_id`) VALUES (1, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_photo`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (1, 'https://www.thespruceeats.com/thmb/SVQ74a8W5PcgeZRsKN3sNozZJRw=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-01-5426378fe0a84f508e40081292fe5289.jpg', 1, 'Gather ingredients for your sandwich.', 1);
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (2, 'https://www.thespruceeats.com/thmb/b0je5oYV05JuIvalCnKkra1gPmw=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-02-f6b7aa8478aa44fb9e841989bfcaf13f.jpg', 2, 'Put peanut butter and jelly on your bread.', 1);
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (3, 'https://www.thespruceeats.com/thmb/fzru-y5YeqrYv8CRCMFjBISz6lc=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-03-e24807863964437fa2b1b930c2e59af5.jpg', 3, 'Heat a skillet with some butter in the pan.', 1);
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (4, 'https://www.thespruceeats.com/thmb/RP7FsoHH72349Uz_BCN8e8lOSDI=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-04-03-247a1df5b3d4484ca4cf6fc4dcef598f.jpg', 4, 'Fry your sandwich.', 1);
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (5, 'https://www.thespruceeats.com/thmb/FmaSdft8pDaACmAOOQYihT10bmY=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-05-c0dfd1a8315b4762907829c6dd10358c.jpg', 5, 'Remove your sandwich from the pan, cut diagonally, and serve immediately.', 1);
INSERT INTO `recipe_photo` (`id`, `image_url`, `sequence_number`, `caption`, `recipe_id`) VALUES (6, 'https://www.the-pasta-project.com/wp-content/uploads/2016/11/white-truffle-1.jpg', 1, 'White truffles from Italy', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (1, 1, '2', 'tbsp', NULL);
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 5, '350', 'g', 'boiled');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 9, '60', 'g', 'grated');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 7, '80', 'g', 'melted');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 4, '1', 'each', 'sliced/shaved');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 10, '1', 'pinch', 'for boiled water');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 8, '1', 'dash', 'to taste');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 11, '10', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 12, '6', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 13, '3', 'cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 14, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 15, '1/2', 'lb', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 16, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 17, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (3, 18, '1/4', 'tsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 19, '6', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 20, '3', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 21, '4', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 22, '3/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 23, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 24, '3', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 25, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 26, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (4, 27, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 28, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 29, '3/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 30, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 31, '3', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 32, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 33, '2', 'cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 34, '1', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 35, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 36, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 37, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 38, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (5, 39, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 43, '10', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 44, '4', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 45, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 46, '1', 'lb', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 47, '1', 'stalk', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 48, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 49, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 50, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 51, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (6, 52, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 53, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 54, '1/2', 'Cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 55, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 56, '1/2', 'lb', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 57, '1', '1-inch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 58, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 59, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (7, 60, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 63, '1', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 40, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 41, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 42, '1/4', 'tsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 61, '1', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 62, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 64, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 65, '1/2', 'lb', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (8, 66, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 67, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 68, '8', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 69, '3', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 70, '2', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 71, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 72, '1/2', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 73, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 74, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (9, 75, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 76, '10', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 77, '1/2', 'lb', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 78, '3', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 79, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 80, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 81, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 82, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (10, 83, '1/4', 'tsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 84, '6', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 85, '4', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 86, '2', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 87, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 88, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 89, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 90, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 91, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (11, 92, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 93, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 94, '1/2', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 95, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 96, '1/2', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 97, '3', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 98, '1 1/2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 99, '1', '1-inch piece', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 100, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 101, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 102, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (12, 103, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 104, '6', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 105, '2', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 106, '3', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 107, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 108, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 109, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 110, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 111, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 112, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 113, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (13, 114, '1', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 115, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 116, '4', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 117, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 118, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 119, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 120, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 121, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 122, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (14, 123, '1', 'tsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 124, '6', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 125, '3', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 126, '3/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 127, '4', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 128, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 129, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 130, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 131, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 132, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 133, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (15, 134, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 135, '2', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 136, '3/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 137, '4', 'oz', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 138, '3', 'Cloves', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 139, '1', '', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 140, '1', 'bunch', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 141, '3', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 142, '1', '1-inch piece', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 143, '1/4', 'cup', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 144, '2', 'tbsp', '');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (16, 145, '2', 'tsp', '');

COMMIT;

