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
  `name` VARCHAR(45) NULL,
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
  `amount` INT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (1, 'chef', '$2a$10$lKJKCiDz1aLg.wfBkdkipueBmNpuWGwz8UWqCEx66tDPyWNqgFlE6', 'chef@example.com', 'ROLE_ADMIN', 1, '2022-06-22', NULL, NULL, 'Chef', 'Supreme', 'I make Gordon Ramsey look compassionate. Get out of my kitchen.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (2, 'amateur', '$2a$10$s/dQwtE1EgUB5iLCFVBtY.BcNdLGNG85b2hS3.qbe.WIuVkwXPG9C', 'amateur@example.com', 'ROLE_USER', 1, '2022-06-22', NULL, NULL, 'Amateur', 'Cook', 'I grew up smelling the amazing foods my grandmother used to make in the kitchen. Since then, I\'ve been seeking the best peanut butter and jelly recipe the world has to offer.');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `created`, `updated`, `image_url`, `firstname`, `lastname`, `biography`) VALUES (3, 'TEMP', '$2a$10$nuZxWkvxgY797dKfJ0Kwle5Ukqw1BEDULB2NVv9DCbpez12zOKv3m', 'TEMP@example.com', 'ROLE_USER', 1, '2022-06-22', NULL, NULL, 'Tempus', 'Fugit', 'Time is fleeting, get to cooking.');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipedb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (1, 'Gourmet Peanut Butter and Jelly', 'Could you ever imagine a peanut butter and jelly sandwich as decadent? Try this gourmet PB&J, and you\'ll reassess everything you\'ve previously understood about this classic.', '1. Gather the ingredients. 2. Prepare peanut butter sandwich using desired jelly or jam. Make sure it isn\'t too runny because the sandwich will be heated and jam could leak out. 3. Heat a frying pan to melt 1 tablespoon of butter. Tilt pan so butter covers pan evenly. This is key to get a perfectly crispy crust on the bread. 3. Heat a frying pan to melt 1 tablespoon of butter. Tilt pan so butter covers pan evenly. This is key to get a perfectly crispy crust on the bread.\n4. Butter one side of sandwich. Place buttered-side down in the pan. If possible, place a steak weight or bacon press on sandwich so it cooks evenly. When one side is golden brown, butter other side. Turn sandwich over and place weight back on sandwich. The second side will cook faster because sandwich is already heated.\n5. Remove sandwich from pan, cut diagonally and serve immediately.\n Looking for other ways to perk up your beloved PB&J? Here are some other ways to enjoy this common childhood favorite:\n\nTry spreading it on French toast that\'s fresh off the griddle.\n\nFor a fun twist, try a sandwich with waffles instead of bread. Just slather some peanut butter and jelly onto waffles. You will not necessarily need syrup in this case, but you can, of course, add it if you\'d like.\n\nInstead of bulky bread, try putting the peanut butter and jelly on a healthy wrap. It may be slimmer in volume, but the taste will shine.', '2022-06-22', NULL, 2, 1, 15, 0, 'https://www.thespruceeats.com/thmb/FmaSdft8pDaACmAOOQYihT10bmY=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-05-c0dfd1a8315b4762907829c6dd10358c.jpg');
INSERT INTO `recipe` (`id`, `name`, `description`, `directions`, `created`, `updated`, `user_id`, `active`, `prepminutes`, `cookminutes`, `image_url`) VALUES (2, 'Tagliolini with White Truffle', 'It’s truffle season here in Northern Italy and tagliolini are among the most popular pastas eaten with this king of the Italian kitchen. Truffles are most definitely an acquired taste and not everybody likes them. However, those who do will tell you there’s almost nothing better in the world of mother nature’s culinary delicacies.', '1. Put a pan of water on to boil. Add salt when it starts to boil and bring to the boil again. Cook the tagliolini as per the instructions on the packet until they are \'al dente\'. Save some of the cooking water before draining. 2. In the meantime wipe the truffle with a damp cloth to remove any soil particles and grate half of it. 3. Melt the butter in a large frying pan until it foams. 4. Add the grated truffle to the butter and 1 or 2 tablespoons of the pasta cooking water. 5. Add the cooked pasta to the butter, sprinkle with some grated Parmesan and cook over a gentle heat for a minute whilst stirring the pasta to coat it with the sauce. 6. Divide the pasta among 4 warmed plates, sprinkle a little more Parmesan onto the pasta and finally shave the remaining truffle over the top of the dish. 7. Serve immediately. Buon appetito!', '2022-06-22', NULL, 1, 1, 10, 20, 'https://www.the-pasta-project.com/wp-content/uploads/2016/11/tagliolini-with-white-truffle-2-590x433.jpg');

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
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (1, 1, 2, 'tbsp', NULL);
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 5, 350, 'g', 'boiled');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 9, 60, 'g', 'grated');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 7, 80, 'g', 'melted');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 4, 1, 'each', 'sliced/shaved');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 10, 1, 'pinch', 'for boiled water');
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`, `amount`, `measure`, `preparation`) VALUES (2, 8, 1, 'dash', 'to taste');

COMMIT;

