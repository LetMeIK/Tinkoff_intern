SELECT 
  pilot_id, 
  name 
FROM 
  Пилоты 
  INNER JOIN (
    SELECT 
      first_pilot_id, 
      second_pilot_id 
    FROM 
      Рейсы 
      INNER JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id 
      AND cargo_flg = 0 
      AND quantity > 30
  ) q_in 
  ON pilot_id = q_in.first_pilot_id 
  OR pilot_id = q_in.second_pilot_id 
WHERE 
  age > 45
