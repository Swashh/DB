# знайти всі машини старші за 2000 р.
select year
from cars
where year > 2000
order by year;

# знайти всі машини молодші 2015 р.
select year
from cars
where year < 2015
order by year desc;

# знайти всі машини 2008, 2009, 2010 років
select year, model
from cars
where year in (2008, 2009, 2010);

# знайти всі машини не з цих років 2008, 2009, 2010
select year, model
from cars
where year not in (2008, 2009, 2010)
order by year desc;

# знайти всі машини де year==price
select model, year, price
from cars
where year = price;


# знайти всі машини bmw старші за 2014 р.
select model, year
from cars
where model = 'bmw'
  and year > 2014
order by year;

# знайти всі машини audi молодші 2014 р.
select model, year
from cars
where model = 'audi'
  and year < 2014
order by year desc;

# знайти перші 5 машин
select *
from cars
order by id
limit 5;

# знайти останні 5 машин
select *
from cars
order by id desc
limit 5;

# знайти середнє арифметичне цін машини KIA
select model, avg(cars.price) as avg_price
from cars
where model = 'KIA';

# знайти середнє арифметичне цін для кожної марки машин окремо
select model, avg(cars.price) as avg_price
from cars
group by model
order by model;

# підрахувати кількість кожної марки
select model, count(model) as count_model
from cars
group by model;

# знайти марку машин кількість яких найбільше
select model, count(model) as max_count_model
from cars
group by model
order by max_count_model desc
limit 1;

# знайти марку машини в назві яких друга та передостання буква "a"
select *
from cars
where model like '_a%a_';

#знайти всі машини назва моделі яких більше за 8 символів
select model
from cars
where length(model) >= 8;

# ***знайти машини ціна котрих більше ніж ціна середнього арифметичного всіх машин
select *
from cars
where price > (SELECT AVG(price) FROM cars);
