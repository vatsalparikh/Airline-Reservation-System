create database database_project;

#drop database database_project;
use database_project;

create table airlines(
airline_id char(2), 
airline_name varchar(20) NOT NULL, 
primary key(airline_id));

create table airports(
airport_id char(3),
airport_name varchar(255) NOT NULL, 
city varchar(40), 
country varchar(40), 
primary key(airport_id));

create table customers(
last_name varchar(30), 
first_name varchar(30), 
address varchar(50), 
city varchar(30), 
state varchar(20), 
zipcode varchar(10),
telephone varchar(20), 
email varchar(40) unique, 
account_password varchar(20), 
country varchar(20),
credit_card_number varchar(30)  NOT NULL, 
account_number int,
primary key(account_number));

create table managers(
account_number int, 
manager_password varchar(30), 
employee_number int, 
primary key(employee_number, manager_password));

create table flights(
flight_number int, 
flights_airline_id char(2),
firstclass_seats int, 
economy_seats int,
business_seats int,
advance_purchase int,
discount float,
primary key(flight_number, flights_airline_id), 
foreign key(flights_airline_id) references airlines(airline_id));

create table legs(
legs_flight_number int, 
legs_airline_id char(2), 
departing_airport_id char(3) NOT NULL, 
arriving_airport_id char(3) NOT NULL, 
departure_time datetime, 
actual_departure datetime, 
arrival_time datetime NOT NULL, 
actual_arrival datetime, 
firstclass_fare int, 
business_fare int, 
economy_fare int, 
primary key(legs_flight_number, legs_airline_id, departure_time), 
foreign key(legs_flight_number,legs_airline_id) references flights(flight_number,flights_airline_id) on delete cascade, 
foreign key(arriving_airport_id) references airports(airport_id), 
foreign key(departing_airport_id) references airports(airport_id));

create table reservations(
reservation_number int, 
reservations_account_number int NOT NULL, 
reservation_date datetime NOT NULL, 
booking_fee int NOT NULL, 
total_fare float NOT NULL,
customer_rep_id int, 
primary key(reservation_number), 
foreign key(reservations_account_number) references customers(account_number));

create table travels(
travels_flight_number int, 
travels_airline_id char(3), 
travels_departure_time datetime, 
travels_reservation_number int NOT NULL, 
seat_number int, 
passenger_first_name varchar(30), 
passenger_last_name varchar(30), 
special_meal_ordered varchar(20), 
class varchar(10) NOT NULL, 
primary key(travels_flight_number, travels_airline_id, travels_departure_time, seat_number), 
foreign key(travels_flight_number, travels_airline_id, travels_departure_time) references legs(legs_flight_number, legs_airline_id, departure_time), 
foreign key(travels_reservation_number) references reservations(reservation_number) on delete cascade);

insert into airlines values
('AA', 'American Airlines'),
('LF', 'Lufthansa'),
('EM', 'Emirates'),
('JB', 'JetBlue'),
('BA', 'British Airways'),
('ET', 'Etihad'),
('AI', 'Air India'),
('JA', 'Japan Airlines'),
('SA', 'Singapore Airlines'),
('VA', 'Virgin Atlantic');

insert into airports values
('ATL', 'Hartsfield Jackson Atlanta International', 'Atlanta', 'GA'),
('AUS', 'Austin Bergstrom International', 'Austin', 'TX'),
('BNA', 'Nashville International', 'Nashville', 'TN'),
('BOS', 'General Edward Lawrence Logan International', 'Boston', 'MA'),
('BWI', 'Baltimore/Washington International Thurgood Marshall', 'Baltimore', 'MD'),
('CLE', 'Cleveland Hopkins International', 'Cleveland', 'OH'),
('CLT', 'Charlotte Douglas International', 'Charlotte', 'NC'),
('DCA', 'Ronald Reagan Washington National', 'Washington', 'DC'),
('DEN', 'Denver International', 'Denver', 'CO'),
('DFW', 'Dallas Fort Worth International', 'Dallas-Fort Worth', 'TX');

INSERT INTO customers VALUES ("Middleton","Jade","Ap #984-6910 Eget Av.","Colombes","Île-de-France","862441","1-829-568-6214","mattis.velit@Utnec.edu","FTQ05YGX9BR","GA","7022",100),("Hubbard","Angela","8693 Semper Rd.","Cork","Munster","26880-806","1-424-555-8013","adipiscing@Fusce.co.uk","TX","2018-02-04 06:08:11","6624",101),("Steele","Raven","Ap #207-7822 Accumsan Av.","Fuenlabrada","Madrid","99524-741","948-2312","nulla@egetlacus.co.uk","YIK22BJJ4SH","TN","3016",102),("Jenkins","Xena","267-5543 Ut Road","Alphen aan den Rijn","Zuid Holland","89226","1-328-875-0723","sed.pede.nec@sitametorci.edu","YQI21NLY0NG","MA","5842",103),("Freeman","Rooney","P.O. Box 712, 1802 Purus Avenue","Marbella","AN","752704","1-841-148-0613","lorem.fringilla.ornare@magnis.edu","HFP60CNH3SF","MD","3211",104),("Fernandez","Lynn","9322 Donec Ave","Málaga","Andalucía","79664","978-2205","Sed.congue@Duisa.com","LMD99PFI1LN","OH","2939",105),("Arnold","Thor","Ap #960-4531 Fusce St.","Meux","NA","47304","1-791-913-7249","eget@ipsumdolorsit.edu","KJO60UQN4TY","NC","2297",106),("Delacruz","Connor","4936 Cras Av.","Angers","Pays de la Loire","989859","779-7423","semper.Nam@necurnasuscipit.com","SGR60EGS4FM","DC","8451",107),("Patrick","Hammett","420-3193 Nulla St.","Ikot Ekpene","Akwa Ibom","59671","269-5450","felis@Donecfeugiat.co.uk","PSP08WTD8MW","MA","7766",108),("Yang","Howard","587-6659 Cursus St.","Ottawa-Carleton","ON","10429","1-350-902-5030","est@nulla.co.uk","OSO52ZPD4NE","TX","9097",109);

INSERT INTO managers (account_number,manager_password,employee_number) VALUES (1000,"XZM04UZO7QE",1),(1001,"HMA20ENY3DZ",2),(1002,"RDQ54EXC9LJ",3),(1003,"DZD87CYD5LP",4),(1004,"EAS29OGV8SM",5),(1005,"PDF20WOD3QH",6),(1006,"UZL06UMN5VV",7),(1007,"MDS16YNH9CF",8),(1008,"MKM26EML9MY",9),(1009,"DXW93WXU1CD",10);

INSERT INTO flights VALUES (10000,"VA",13,158,26,"60","0.20"),(10010,"VA",11,174,29,"90","0.20"),(10020,"EM",10,174,40,"30","0.10"),(10030,"VA",19,157,39,"30","0.10"),(10040,"AI",15,171,38,"30","0.20"),(10050,"ET",16,189,25,"60","0.30"),(10060,"JA",11,169,27,"60","0.20"),(10070,"SA",19,158,22,"60","0.30"),(10080,"SA",13,184,38,"60","0.30"),(10090,"BA",16,152,27,"60","0.10");

INSERT INTO reservations VALUES (33333,105,"2018-02-23 15:07:03",15,564,3),(33334,109,"2018-01-06 08:28:14",20,718,7),(33335,100,"2018-06-23 22:34:44",15,430,8),(33336,104,"2018-01-27 12:08:01",20,260,2),(33337,100,"2018-07-26 04:40:22",19,881,4),(33338,106,"2017-09-28 12:07:39",16,673,1),(33339,101,"2018-05-20 03:01:04",14,671,2),(33340,105,"2018-08-18 20:24:34",14,263,5),(33341,100,"2017-10-29 09:35:38",13,917,8),(33342,102,"2018-06-26 17:06:46",15,205,10);

INSERT INTO legs VALUES (10040,"AI","DEN","DEN","2018-05-24 07:16:17","2018-05-24 07:16:17","2018-05-24 15:03:44","2018-05-24 18:03:44",309,277,183),(10020,"EM","DCA","DFW","2017-07-25 21:30:11","2017-07-25 22:30:11","2017-07-27 12:02:21","2017-07-27 12:02:21",303,240,113),(10070,"SA","BOS","CLE","2018-05-25 14:05:53","2018-05-25 14:05:53","2018-05-25 18:19:26","2018-05-25 18:19:26",378,213,160),(10060,"JA","DFW","BWI","2018-01-03 15:10:20","2018-01-03 15:10:20","2018-01-03 23:48:41","2018-01-03 23:48:41",371,247,118),(10020,"EM","CLE","DEN","2019-02-08 01:27:34","2019-02-09 01:27:34","2019-02-10 20:22:51","2019-02-10 20:22:51",377,299,106),(10020,"EM","CLE","CLE","2018-07-19 09:26:16","2018-07-19 09:26:16","2018-07-20 02:26:22","2018-07-20 10:26:22",353,228,200),(10040,"AI","CLE","CLT","2017-06-01 15:59:11","2017-06-01 15:59:11","2017-06-03 14:57:12","2017-06-03 14:57:12",301,268,141),(10090,"BA","DFW","CLE","2019-01-13 13:38:51","2019-01-13 13:58:51","2019-01-14 23:41:52","2019-01-14 23:41:52",300,283,162),(10050,"ET","AUS","CLT","2018-06-21 17:34:13","2018-06-21 17:34:13","2018-06-21 23:17:45","2018-06-21 23:17:45",311,207,187),(10090,"BA","BWI","DEN","2018-07-08 12:05:27","2018-07-08 22:05:27","2018-07-09 08:22:20","2018-07-09 08:22:20",317,238,160);

INSERT INTO travels VALUES (10040,"AI","2018-05-24 07:16:17",33340,460,"Lynn","Fernandez","kosher","business"),(10020,"EM","2019-02-08 01:27:34",33337,317,"Jade","Middleton","vegetarian","firstclass"),(10070,"SA","2018-05-25 14:05:53",33340,18,"Lynn","Fernandez","allergen_free","economy"),(10060,"JA","2018-01-03 15:10:20",33342,16,"Raven","Steele","kosher","economy"),(10060,"JA","2018-01-03 15:10:20",33338,290,"Thor","Arnold","allergen_free","firstclass"),(10020,"EM","2019-02-08 01:27:34",33342,315,"Raven","Steele","religious","business"),(10020,"EM","2019-02-08 01:27:34",33337,457,"Jade","Middleton","seafood","firstclass"),(10040,"AI","2018-05-24 07:16:17",33337,449,"Jade","Middleton","kosher","firstclass"),(10090,"BA","2018-07-08 12:05:27",33339,498,"Angela","Hubbard","allergen_free","firstclass"),(10090,"BA","2018-07-08 12:05:27",33335,458,"Jade","Middleton","religious","business");