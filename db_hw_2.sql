-- # 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
select *
from client
where length(FirstName) < 6;

-- # 2.Вибрати львівські відділення банку.
select *
from department
where DepartmentCity = 'Lviv';

-- # 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
select FirstName, LastName, Education
from client
where Education = 'high'
order by LastName;

-- # 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
select *
from application
order by idApplication desc
limit 5;

-- # 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
select *
from client
where LastName like '%ov'
   or LastName like '%ova';

-- # 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.
select *
from client
         join swashh.department d on d.idDepartment = client.Department_idDepartment and DepartmentCity = 'Kyiv';

-- # 7.Знайти унікальні імена клієнтів.
select distinct client.FirstName
from client;

-- # 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 гривень.
select idClient, FirstName, Sum
from client
         join swashh.application a on client.idClient = a.Client_idClient
where Sum > 5000
order by Sum;

-- # 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
select count(*)
from client
         join swashh.department d on d.idDepartment = client.Department_idDepartment;


select count(*)
from client
         join department d2 on d2.idDepartment = client.Department_idDepartment
where DepartmentCity = 'lviv';

-- # 11. Визначити кількість заявок на кредити для кожного клієнта.
select FirstName, count(*) as order_count
from client
         join application a on client.idClient = a.Client_idClient
group by idClient;

-- # 12. Визначити найбільший та найменший кредити.
select min(Sum), max(Sum)
from application;

-- # 13. Порахувати кількість кредитів для клієнтів, які мають вищу освіту.
select count(*), idClient, FirstName, LastName, Education
from client
         join application a on client.idClient = a.Client_idClient
where Education = 'high'
group by idClient;

-- # 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
select avg(Sum) avg_sum, client.*
from client
         join application a on client.idClient = a.Client_idClient
group by idClient
order by avg_sum desc
limit 1;

-- # 15. Вивести відділення, яке видало в кредити найбільше грошей
-- # (це було складно, піддивлявся у відповіді)
select sum(Sum) as sum, idDepartment, DepartmentCity
from department
         join swashh.client c on department.idDepartment = c.Department_idDepartment
         join swashh.application a on c.idClient = a.Client_idClient
group by idDepartment
order by sum desc
limit 1;

-- # 16. Вивести відділення, яке видало найбільший кредит.
-- # (це було складно, піддивлявся у відповіді)
select max(Sum) as max_sum, department.*
from department
         join swashh.client c on department.idDepartment = c.Department_idDepartment
         join swashh.application a on c.idClient = a.Client_idClient
group by idDepartment
order by max_sum desc
limit 1;

-- # 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
update application join swashh.client c on application.Client_idClient = c.idClient
set Sum=6000
where Education = 'high';

-- # 18. Усіх клієнтів київських відділень пересилити до Києва.
update client join swashh.department d on client.Department_idDepartment = d.idDepartment
set City='Kyiv'
where DepartmentCity = 'Kyiv';


-- # 19. Видалити усі кредити, які є повернені.
delete application
from application
where CreditState = 'Returned';

-- # 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
-- # це сам не зміг зробити, піддивився у розв'язок
delete application
from application
         join client c on c.idClient = application.Client_idClient
where LastName like '_e%'
   or LastName like '_y%'
   or LastName like '_u%'
   or LastName like '_o%'
   or LastName like '_a%';


-- # 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
select sum(Sum) as sum, DepartmentCity, idDepartment
from department
         join swashh.client c on department.idDepartment = c.Department_idDepartment
         join swashh.application a on c.idClient = a.Client_idClient
where DepartmentCity = 'lviv'
group by idDepartment
having sum(Sum) > 5000;

# 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
select idClient, FirstName, CreditState, Sum
from client
         join swashh.application a on client.idClient = a.Client_idClient
where CreditState = 'Returned'
  and Sum > 5000;


# 23.Знайти максимальний неповернений кредит.
select *
from application
where CreditState = 'Not returned'
order by Sum desc
limit 1;


# 24.Знайти клієнта, сума кредиту якого найменша
select *
from client
         join application a on client.idClient = a.Client_idClient
order by Sum
limit 1;

# 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів
select *
from application
where Sum > (select avg(Sum) from application);


# 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
# це не зміг зробити сам
select *
from client
where City = (select c.City
              from client c
                       join application a on c.idclient = a.client_idclient
              group by idclient
              order by count(*) desc
              limit 1);


# 27. Місто клієнта з найбільшою кількістю кредитів
select c.City
from client c
         join application a on c.idclient = a.client_idclient
group by idclient
order by count(*) desc
limit 1;