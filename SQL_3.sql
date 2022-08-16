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
