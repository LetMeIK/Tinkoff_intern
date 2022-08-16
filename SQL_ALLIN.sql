Задача 1. Напишите запрос, который выведет пилотов, которые в качестве второго пилота в
августе этого года трижды ездили в аэропорт Шереметьево.

SELECT 
  pilot_id, /*Для информативности данные пилота вывожу как id и Имя*/
  name 
FROM 
  Пилоты 
  INNER JOIN ( /*Соединяю выборки Пиолотов и Рейсов с нужными аэропортом и датой*/
    SELECT 
      second_pilot_id, 
      COUNT(destination) AS cnt /*Счетчик рейсов с подходящими условиями*/
    FROM 
      Рейсы 
    WHERE 
      destination = 'Шереметьево' 
      AND (
        flight_dt BETWEEN '2022-08-01' AND '2022-08-31'
      ) 
    GROUP BY 
      second_pilot_id
  ) q_in 
  ON pilot_id = q_in.second_pilot_id 
     AND q_in.cnt = 3;  /*Учитываем счетчик*/
     
----------------------------------------------------------------------------------------------------

Задача 2. Выведите пилотов старше 45 лет, совершали полеты на самолетах с количеством
пассажиров больше 30.

SELECT 
  pilot_id, 
  name 
FROM 
  Пилоты 
  INNER JOIN (  /*Соединяю выборки Пилотов и Рейсов с пассажирскими самолетами и кол-вом пассажиров > 30*/
    SELECT 
      first_pilot_id,   /*Нахожу id подходящих пилотов (без возраста)*/
      second_pilot_id 
    FROM 
      Рейсы 
      INNER JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id 
      AND cargo_flg = 0                           
      AND quantity > 30
  ) q_in 
  ON pilot_id = q_in.first_pilot_id   /*Пилот может быть как первым, так и вторым*/
  OR pilot_id = q_in.second_pilot_id 
WHERE 
  age > 45   /*Учитываю условие на возраст*/
  
----------------------------------------------------------------------------------------------------

Задача 3. Выведите ТОП 10 пилотов-капитанов (first_pilot_id), которые совершили наибольшее
число грузовых перелетов в этом году.

SELECT 
  pilot_id, 
  name, 
  COUNT(flight_id) AS flights /*Счетчик полетов для каждого пилота*/
FROM 
  Пилоты 
  INNER JOIN (  /*Соединяю выборки Пилотов и Рейсов с грузовыми самолетами*/
    SELECT 
      first_pilot_id, /*Выбираю id подходящих пилотов и соотв. им id полетов*/
      flight_id 
    FROM 
      Рейсы 
      INNER JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id 
      AND cargo_flg = 1
  ) q_in 
  ON pilot_id = q_in.first_pilot_id 
GROUP BY 
  pilot_id      /*Сортирую по убыванию полетов*/
ORDER BY 
  flights DESC 
LIMIT 10   /*Выбираю первые 10 = "Топ 10"*/
