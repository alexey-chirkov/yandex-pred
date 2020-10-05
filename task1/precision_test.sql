--SELECT strftime('%Y-%m-%d %H',datetime(timestamp/1000, 'unixepoch')), COUNT(new_t) FROM fact GROUP BY 1 LIMIT 10;
--SELECT strftime('%Y-%m-%d %H', start_of_hour), prediction FROM pred1 LIMIT 10;
/*Среднеквадратичная ошибка(MSE)*/
WITH load AS(
    SELECT queueId, strftime('%Y-%m-%d %H',datetime(fact.timestamp/1000, 'unixepoch')) AS intime, COUNT(new_t) as obs
    FROM fact
    GROUP BY intime)
SELECT SUM((IFNULL(load.obs, 0) - pred1.prediction) * (IFNULL(load.obs, 0) - pred1.prediction)) * 1.0 / COUNT(pred1.queueId) AS Pred1_MSE, SUM((IFNULL(load.obs, 0) - pred2.prediction) * (IFNULL(load.obs, 0) - pred2.prediction)) * 1.0 / COUNT(pred1.queueId) AS Pred2_MSE 
FROM pred1
LEFT JOIN pred2
    ON pred1.start_of_hour = pred2.start_of_hour AND pred1.queueId = pred2.queueId
LEFT JOIN load
    ON strftime('%Y-%m-%d %H', pred1.start_of_hour) = load.intime AND pred1.queueId = load.queueId;
