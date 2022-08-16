SELECT 
  pilot_id, 
  name, 
  COUNT(flight_id) AS flights 
FROM 
  Пилоты 
  INNER JOIN (
    SELECT 
      first_pilot_id, 
      second_pilot_id, 
      flight_id 
    FROM 
      Рейсы 
      INNER JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id 
      AND cargo_flg = 1
  ) q_in 
  ON pilot_id = q_in.first_pilot_id 
GROUP BY 
  pilot_id 
ORDER BY 
  flights DESC 
LIMIT 10
