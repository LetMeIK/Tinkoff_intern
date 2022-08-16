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
