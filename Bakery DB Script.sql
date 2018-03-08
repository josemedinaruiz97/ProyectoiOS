CREATE DATABASE bakeryproyecto;

USE bakeryproyecto;


CREATE TABLE member (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    login varchar(40) UNIQUE,
    password varchar(250)
);

CREATE TABLE client (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(40) UNIQUE,
    surname varchar(60) UNIQUE,
    tin varchar(20) UNIQUE,
    address varchar(100),
    location varchar(100),
    postalcode varchar(5),
    province varchar(30),
    email varchar(100)
);

CREATE TABLE family (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    family varchar(100) UNIQUE
);

CREATE TABLE ticket (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    date datetime,
    idmember bigint(20),
    idclient bigint(20),
    FOREIGN KEY (idmember) REFERENCES member(id),
    FOREIGN KEY (idclient) REFERENCES client(id)
);

CREATE TABLE product (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idfamily bigint(20),
    product varchar(100) UNIQUE,
    price decimal(10,2),
    description text,
    FOREIGN KEY (idfamily) REFERENCES family(id)
);

CREATE TABLE ticketdetail (
    id bigint(20) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idticket bigint(20),
    idproduct bigint(20),
    quantity tinyint(4),
    price decimal(10,2),
    FOREIGN KEY (idticket) REFERENCES ticket(id),
    FOREIGN KEY (idproduct) REFERENCES product(id)
);

insert into member (`login`,`password`) values("pepe","pepe");
INSERT INTO family(family) VALUES ("pan");
INSERT INTO family(family) VALUES ("bolleria");
INSERT INTO family(family) VALUES ("croissant");
INSERT INTO family(family) VALUES ("navidad");
INSERT INTO family(family) VALUES ("otros");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (1,"pan blanco",0.50,"es el mejor pan del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (2,"donut",0.50,"es el mejor donut del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (1,"pan integral",1.00,"es el mejor pan del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (1,"rosca",0.70,"es el mejor pan del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (1,"bollillo",0.50,"es el mejor pan del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (2,"napolitana",1.00,"es la mejor napolitana del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (3,"croissant",0.30,"es el mejor croissant del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (4,"magdalena reno",1.20,"es la mejor magdalena del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (4,"galleta fresa",0.50,"es la mejor galleta del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (3,"magdalena frutos",1.00,"es la mejor magdalena del mundo");
INSERT INTO `product`(`idfamily`, `product`, `price`, `description`) VALUES (4,"arbol",0.50,"es el mejor arbol del mundo");
