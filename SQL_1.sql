SELECT 
  pilot_id, 
  name 
FROM 
  Пилоты 
  INNER JOIN (
    SELECT 
      second_pilot_id, 
      COUNT(destination) AS cnt 
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
  on pilot_id = q_in.second_pilot_id 
  AND q_in.cnt = 3;
