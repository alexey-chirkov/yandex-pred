.headers ON
.separator "\t"
create table pred1 (start_of_hour datetime, prediction int, queueId int);
.import prediction_1.tsv pred1
DELETE FROM pred1 WHERE queueId LIKE "%queueId%";
create table pred2 (start_of_hour datetime, prediction int, queueId int);
.import prediction_2.tsv pred2
DELETE FROM pred2 WHERE queueId LIKE "%queueId%";
create table fact (queueId int, timestamp datetime, new_t string);
.import fact_incoming.tsv fact
DELETE FROM fact WHERE queueId LIKE "%queueId%";


