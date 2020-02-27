-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-02-2020 a las 20:42:25
-- Versión del servidor: 5.7.17
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `accesodatos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizardatosxml` (IN `v_director` VARCHAR(300), IN `v_anyo` YEAR(4), IN `v_categoria` VARCHAR(150), IN `v_titulo` VARCHAR(300))  NO SQL
update movies set director=v_director, year_released=v_anyo, 
category_id=(select category_id from categories where category_name=v_categoria) where title=v_titulo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `damelacategoria` (IN `v_id` INT(11))  NO SQL
select * from categories where category_id=v_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletemiembros` ()  begin SET FOREIGN_KEY_CHECKS=0; delete from members where membership_number IN (select membership_number from payments where payment_date not between subdate(curdate(), interval 3 month) and curdate()); SET FOREIGN_KEY_CHECKS=1; end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertandomiscategorias` (IN `v_cate` VARCHAR(20), IN `v_remark` VARCHAR(20))  NO SQL
INSERT into categories (category_name, remarks) 
values (v_cate, v_remark)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_pelicula` (IN `v_title` VARCHAR(300), IN `v_director` VARCHAR(150), IN `v_year_released` YEAR(4), IN `v_category_id` INT(11))  NO SQL
insert into movies (title, director, year_released, category_id) values (v_title, v_director, v_year_released, v_category_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarmiscategorias` ()  NO SQL
select * from categories$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarpelis` ()  NO SQL
select * from movies$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mirutina` ()  NO SQL
begin
delete from movierentals where membership_number=1;
delete from payments where membership_number=1;
delete from members where membership_number=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_director` (IN `v_category_name` VARCHAR(150))  NO SQL
update movies set director='director modificado' where category_id=(select category_id from categories where category_name=v_category_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_miembros_rental` (IN `v_title` VARCHAR(150))  NO SQL
SELECT m.membership_number, m.full_names, m.contact_number, m.date_of_birth, m.email, m.gender, m.physical_address, m.postal_address FROM members m, movies mo, movierentals r where m.membership_number=r.membership_number and mo.movie_id=r.movie_id and mo.title=v_title and transaction_date between subdate(curdate(), interval 1 month) and curdate()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peliculasbefore2011` ()  NO SQL
SELECT m.movie_id, m.title, ifnull(m.director,''), m.year_released, c.category_name, ifnull(c.remarks,'')
FROM movies m, categories c
where m.category_id=c.category_id
and m.year_released<=2011$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(150) DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `remarks`) VALUES
(1, 'Comedy', 'Movies with humour'),
(2, 'Romantic', 'Love stories'),
(3, 'Epic', 'Story acient movies'),
(4, 'Horror', NULL),
(5, 'Science Fiction', NULL),
(6, 'Thriller', NULL),
(7, 'Action', NULL),
(8, 'Romantic Comedy', NULL),
(9, 'TERROR', 'para mayores de edad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `members`
--

CREATE TABLE `members` (
  `membership_number` int(11) NOT NULL,
  `full_names` varchar(350) NOT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `physical_address` varchar(255) DEFAULT NULL,
  `postal_address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(75) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `members`
--

INSERT INTO `members` (`membership_number`, `full_names`, `gender`, `date_of_birth`, `physical_address`, `postal_address`, `contact_number`, `email`) VALUES
(1, 'Janet Jones', 'Female', '1980-07-21', 'First Street Plot No 4', 'Private Bag', '0759 253 542', 'janetjones@yagoo.cm'),
(2, 'Janet Smith Jones', 'Female', '1980-06-23', 'Melrose 123', NULL, NULL, 'jj@fstreet.com'),
(3, 'Robert Phil', 'Male', '1989-07-12', '3rd Street 34', NULL, '12345', 'rm@tstreet.com'),
(4, 'Gloria Williams', 'Female', '1984-02-14', '2nd Street 23', NULL, NULL, NULL),
(50, 'Pedro', NULL, '2020-02-14', 'calle', '2111', '666666', NULL),
(80, 'Javier', NULL, NULL, 'calle javier', '1233', '23322', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movierentals`
--

CREATE TABLE `movierentals` (
  `reference_number` int(11) NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `membership_number` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `movie_returned` bit(1) DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `movierentals`
--

INSERT INTO `movierentals` (`reference_number`, `transaction_date`, `return_date`, `membership_number`, `movie_id`, `movie_returned`) VALUES
(13, '2012-06-22', '2012-06-25', 3, 2, b'0'),
(14, '2012-06-21', '2012-06-24', 2, 2, b'0'),
(15, '2012-06-23', NULL, 3, 3, b'0'),
(16, '2020-01-09', NULL, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movies`
--

CREATE TABLE `movies` (
  `movie_id` int(11) NOT NULL,
  `title` varchar(300) DEFAULT NULL,
  `director` varchar(150) DEFAULT NULL,
  `year_released` year(4) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `movies`
--

INSERT INTO `movies` (`movie_id`, `title`, `director`, `year_released`, `category_id`) VALUES
(1, 'Pirates of the Caribean 4', ' Rob Marshall', 2011, 1),
(2, 'Forgetting Sarah Marshal', 'Nicholas Stoller', 2008, 2),
(3, 'X-Men', 'Carlos', 2008, 3),
(4, 'Code Name Black', 'Edgar Jimz', 2010, NULL),
(5, 'Daddy\'s Little Girls', NULL, 2007, 8),
(6, 'Angels and Demons', NULL, 2007, 6),
(7, 'Davinci Code', NULL, 2007, 6),
(9, 'Honey mooners', 'John Schultz', 2005, 8),
(16, '67% Guilty', 'pepe', 1980, 1),
(17, 'el titulo', 'yo', 2016, 1),
(40, 'Indiana Jones', 'Lucas L', 1983, 1),
(98, 'untitulo', 'director', 1915, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `membership_number` int(11) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `description` varchar(75) DEFAULT NULL,
  `amount_paid` float DEFAULT NULL,
  `external_reference_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `payments`
--

INSERT INTO `payments` (`payment_id`, `membership_number`, `payment_date`, `description`, `amount_paid`, `external_reference_number`) VALUES
(1, 1, '2012-07-23', 'Movie rental payment', 2500, 11),
(2, 1, '2012-07-25', 'Movie rental payment', 2000, 12),
(3, 3, '2012-07-30', 'Movie rental payment', 6000, NULL),
(4, 50, NULL, NULL, 50, NULL),
(5, 50, NULL, NULL, 75, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indices de la tabla `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`membership_number`);

--
-- Indices de la tabla `movierentals`
--
ALTER TABLE `movierentals`
  ADD PRIMARY KEY (`reference_number`),
  ADD KEY `fk_MovieRentals_Members1` (`membership_number`),
  ADD KEY `fk_MovieRentals_Movies1` (`movie_id`);

--
-- Indices de la tabla `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `fk_Movies_Categories1` (`category_id`),
  ADD KEY `title_index` (`title`),
  ADD KEY `qw` (`title`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_Payments_Members1` (`membership_number`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `members`
--
ALTER TABLE `members`
  MODIFY `membership_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT de la tabla `movierentals`
--
ALTER TABLE `movierentals`
  MODIFY `reference_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `movies`
--
ALTER TABLE `movies`
  MODIFY `movie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movierentals`
--
ALTER TABLE `movierentals`
  ADD CONSTRAINT `fk_MovieRentals_Members1` FOREIGN KEY (`membership_number`) REFERENCES `members` (`membership_number`),
  ADD CONSTRAINT `fk_MovieRentals_Movies1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`);

--
-- Filtros para la tabla `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `fk_Movies_Categories1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_Payments_Members1` FOREIGN KEY (`membership_number`) REFERENCES `members` (`membership_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
