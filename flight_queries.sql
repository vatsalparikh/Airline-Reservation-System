Delimiter //
create function air_time(arrival_tz varchar(80),departure_tz varchar(80),arrival_time datetime,departure_time datetime)
returns time
return timediff(convert_tz(arrival_time,arrival_tz,departure_tz), departure_time);

create function available(airline_id char(2), flight_num int, departure_time datetime, preffered_class varchar(15))
returns bool
return (select count(*) from Travels t where t.class=preffered_class and t.travels_flight_number=flight_num and t.travels_airline_id=airline_id and t.travels_departure_time=departure_time)<(select (if (preffered_class='economy',economy_seats,if(preffered_class='buisness',buisness_seats,firstclass_seats))) from Flights where flight_number=flight_num and flights_airline_id=airline_id);

create function fair_calc(class_fair int,booking_date date,departure_time datetime,num_of_passengers int,airline_id char(2),flight_num int)
returns int
return class_fair*num_of_passengers*
   (select if(date_add(booking_date,interval f.advance_purchace day)<=date(departure_time),f.discount,1)
	from flights f
	where f.flights_airline_id=airline_id and f.flight_number=flight_num
); 
delimiter //

create procedure list_of_flights(flight_date date, book_date date, preffered_class varchar(15), passengers int, start_port char(3), end_port char(3),date_offset int)

begin

	declare lower_date datetime default date_sub(flight_date,interval date_offset day);
	declare upper_date datetime default date_add(flight_date,interval date_offset day);
    
	create temporary table timetable as
	(select (select city_timezone from Airports where airport_id=start_port) start_zone, (select city_timezone from Airports where airport_id=end_port) endzone);
    
    create temporary table output as
    
	select * 
    from
	(select
	l.departure_time leg1_departure_time, l.arrival_time leg1_arrival_time, l.legs_airline_id leg_1_airline_id, l.legs_flight_number leg1_flight_number, 
	NULL leg1_arriving_airport, NULL leg2_departure_time, NULL leg2_airline_id , NULL leg2_flight_number, 
	(select airtime((select end_zone from time_table),(select start_zone from time_table),l.arrival_time,l.departure_time)) flight_time,
	(select fair_calc(if (preffered_class='economy',l.economy_fair,if(preffered_class='buisness',l.buisness_fair,l.firstclass_fair)), book_date, l.departure_time, passengers,l.legs_airline_id, l.legs_flight_number)) fair,
    false best_seller
	from Legs l
	where date(l.departure_time)>=lower_date and date(l.departure_time)<=upper_date and l.departing_airport_id=start_port and l.arriving_airport_id=end_port and (select available(l.legs_airline_id,l.legs_flight_number,l.departure_time,preffered_class))

	union

	select
	l1.departure_time leg1_departure_time, l1.arrival_time leg1_arrival_time, l1.legs_airline_id leg1_airline_id, l1.legs_flight_number leg1_flight_number, 
	l1.arriving_airport_id leg1_arriving_airport, l2.departure_time leg2_arrival_time, l2.legs_airline_id leg2_airline_id, l2.legs_flight_number leg2_flight_number, 
	(select airtime((select end_zone from time_table),(select start_zone from time_table),l2.arrival_time,l1.departure_time)) flight_time, 
	(select fair_calc(if (preffered_class='economy',l1.economy_fair,if(preffered_class='buisness',l1.buisness_fair,l1.firstclass_fair)), book_date, l1.departure_time, passengers, l1.legs_airline_id, l1.legs_flight_number))+(select fair_calc(if (preffered_class='economy',l2.economy_fair,if(preffered_class='buisness',l2.buisness_fair,l2.firstclass_fair)), booking_date, l2.departure_time, passengers,l2.legs_airline_id, l2.legs_flight_number)) fair,
    false best_seller
	from (select * from Legs where legs_departure_airport=start_port and date(departure_time)>=lower_date and date(departure_time)<=upper_date and (select available(legs_airline_id,legs_flight_number,departure_time,preffered_class))) l1
	join (select *from Legs where arriving_airport_id=end_port)l2 on l1.arriving_airport_id=l2.departing_airport_id and (select airtime((select end_zone from time_table),(select start_zone from time_table),l2.arrival_time,l1.departure_time))<'48:00:00')
    
    order by departure_time;
    
    update output
    set best_seller=True
    where fair=(select max(fair) from output);
    
    select * from output;
    
end//

delimiter ;


