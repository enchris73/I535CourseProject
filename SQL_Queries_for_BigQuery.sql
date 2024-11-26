-- Please replace all table names with the names of your own tables within BigQuery. I have left my names unaltered as an example.

-----------------------------
-- Build StateTotals Table --
-----------------------------

DECLARE states ARRAY<STRING>;
DECLARE statenames ARRAY<STRING>;
DECLARE x INT64;
DECLARE total INT64;

SET states = ["AK", "AL", "AR", "AS", "AZ", "BP2", "CA", "CO", "CT", "DC", "DD2", "DE", "FL", "FM", "GA", "GU", "HI", "IA", "ID", "IH2", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MH", "MI", "MN", "MO", "MP", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "PW*", "SC", "SD", "TN", "TX", "US", "UT", "VA2", "VA", "VI", "VT", "WA", "WI", "WV", "WY"];

SET statenames = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "Bureau of Prisons", "California", "Colorado", "Connecticut", "District of Columbia", "Dept of Defense", "Delaware", "Florida", "Federated States of Micronesia", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Indian Health Services", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Marshall Islands", "Michigan", "Minnesota", "Missouri", "Northern Mariana Islands", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York State", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "Republic of Palau", "South Carolina", "South Dakota", "Tennessee", "Texas", "United States", "Utah", "Veterans Affairs", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"];

SET x = 0;
WHILE x < 64 DO
  SET total = (SELECT SUM(Administered_Daily) FROM `fa24-i535-elichri-covid19stats.COVID19CDCData.Vaccinations` WHERE Location = states[x]);
  INSERT INTO `COVID19CDCDataUS.StateTotals` (State,TotalVaccinations)
  VALUES (statenames[x],total);
  SET x = x+1;
END WHILE;

---------------------------------
-- Top 10 - Administered Daily --
---------------------------------

SELECT ID, Date, Administered_Daily FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Administered_Daily DESC
LIMIT 10;

-------------------------------
-- Top 10 - Bivalent Booster --
-------------------------------

SELECT ID, Date, Administered_Daily FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Administered_Daily DESC
LIMIT 10;

-------------------------
-- Top 10 - First Dose --
-------------------------

SELECT ID, Date, Admin_Dose_1_Daily AS First_Dose FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Admin_Dose_1_Daily DESC
LIMIT 10;

------------------------------
-- Top 10 - Initial Booster --
------------------------------

SELECT ID, Date, Admin_Dose_1_Daily AS First_Dose FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Admin_Dose_1_Daily DESC
LIMIT 10;

---------------------------------------
-- Top 10 - Initial Series Completed --
---------------------------------------

SELECT ID, Date, Series_Complete_Daily AS Initial_Series_Completed FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Series_Complete_Daily DESC
LIMIT 10;

-------------------------------------
-- Top 10 - Second Booster 50 Plus --
-------------------------------------

SELECT ID, Date, Second_Booster_50Plus_Daily AS Second_Booster_50Plus FROM `fa24-i535-elichri-covid19stats.COVID19CDCDataUS.VaccinationData`
ORDER BY Second_Booster_50Plus_Daily DESC
LIMIT 10;