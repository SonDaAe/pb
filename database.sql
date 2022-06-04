grant all privileges on  *.* to 'root'@'%' identified by 'mysql1234';
delete from mysql.user where host="localhost" and user="root";
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

#####
DROP DATABASE IF EXISTS `pbdb` ;

CREATE DATABASE IF NOT EXISTS `pbdb` 
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

USE `pbdb` ;

CREATE TABLE `team` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  `tname` VARCHAR(45) NOT NULL,
  `members` INT NOT NULL,
  `leader` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `member` (
  `mid` INT NOT NULL AUTO_INCREMENT,
  `mname` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
  CREATE TABLE `breads` (
  `bid` INT NOT NULL, # AUTO_INCREMENT,
  `bname` VARCHAR(255) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `kcal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bid`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;
  
CREATE TABLE `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bread_id` INT NOT NULL,
  `filename` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX (`bread_id`),
  FOREIGN KEY (`bread_id`) REFERENCES `breads` (`bid`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE `member's_pick_bread` (
  `team_id` INT NOT NULL,
  `bread_id` INT NOT NULL,
  INDEX (`team_id`),
  FOREIGN KEY (`team_id`) REFERENCES `team` (`tid`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX (`bread_id`),
  FOREIGN KEY (`bread_id`) REFERENCES `breads` (`bid`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

###############################################

INSERT INTO `team` (tid, tname, members, leader) VALUES
    (1, '평일오픈', 3, '한아름'),
    (2, '평일미들', 2, '성진하'),
    (3, '평일마감', 2, '남현모'),
    (4, '평일오픈', 3, '손다애'),
    (5, '평일미들', 2, '강예지'),
    (6, '평일마감', 2, '김보경');
    
# 평일오픈 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (1, '한아름', '여'),
    (2, '강민정', '여'),
    (3, '성진하', '여');

# 평일미들 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (4, '성진하', '여'),
    (5, '박은지', '여');
    
# 평일미들 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (6, '남현모', '남'),
    (7, '김보경', '여');
    
# 주말오픈 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (8, '손다애', '여'),
    (9, '정지영', '여'),
    (10, '장은비', '여');
    
# 주말미들 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (11, '강예지', '여'),
    (12, '정다연', '여');    
    
# 주말마감 멤버
INSERT INTO `member` (mid, mname, gender) VALUES
    (13, '김보경', '여'),
    (14, '이다영', '여');   
 
 

INSERT INTO `breads` (bid, bname, price, kcal) VALUES
    (1, '양파치즈브레드', '3300원', '795kcal'),
    (2, '미니초코칩트위스트', '800원', '80kcal'),
    (3, '골든크림메론빵', '1900원', '320kcal'),
    (4, '에그베이컨토스트', '3500원', '315kcal'),
    (5, '치즈듬뿍어니언', '3200원', '565kcal'),
    (6, '치즈소시지페스츄리', '2700원','390kcal'),
    (7, '촉촉한 고구마케익', '1500원', '275kcal'),
    (8, '스위트 몽블랑', '5400원', '462kcal' ),
    (9, '카스테라구마', '2700원','335kcal'),
    (10, '치즈감자봉', '2600원', '335kcal'),
    (11, '초코츄잉스타', '1600원', '240kcal' ),
    (12, '로스트 치킨 샐러드', '6800원', '240kcal'),
    (13, '칠리크랩샌드위치', '6000원', '545kcal'),
    (14, '햄치즈오리지널머핀', '2800원', '345kcal');


# 멤버들 픽 빵 이미지
INSERT INTO `image` (id, bread_id, filename, description) VALUES
    (null, 1, 'onionpacheese.png', '양파치즈브레드'),
    (null, 2, 'minichoco.png', '미니초코칩트위스트'),
    (null, 3, 'melon.png', '골든크림메론빵'),
    (null, 4, 'eggbacon.png', '에그베이컨토스트'),
    (null, 5, 'cheeseonion.png', '치즈듬뿍어니언'),
    (null, 6, 'cheesesausage.png', '치즈소시지페스츄리'),
    (null, 7, 'sweetpotato.png', '촉촉한고구마케익'),
    (null, 8, 'sweet.png', '스위트 몽블랑'),
    (null, 9, 'castella.png', '카스테라구마'),
    (null, 10, 'cheesepotato.png', '치즈감자봉'),
    (null, 11, 'chewing.png', '초코츄잉스타'),
    (null, 12, 'roastchicken.png', '로스트 치킨 샐러드'),
    (null, 13, 'crab.png', '칠리크랩샌드위치'),
    (null, 14, 'original.png', '햄치즈오리지널머핀');
    
# 멤버들 픽 빵
INSERT INTO `member's_pick_bread` (team_id, bread_id) VALUES
    (1, 1), (1, 2), (1, 3), #평일오픈
    (2, 4), (2, 5), #평일미들
    (3, 6), (3, 7), #평일마감
    (4, 8), (4, 9), (4, 10), #주말오픈
    (5, 11), (5, 12), #주말미들
    (6, 13), (6, 14); #주말마감 