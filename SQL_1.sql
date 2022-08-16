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
