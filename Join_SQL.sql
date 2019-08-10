CREATE VIEW boston_crime_dataset AS
Select 
bpd."District_Codes" as district_code
,bpd."District" as district
,offense_code
, offense_code_grp
, offense_desc
, reporting_area
, shooting
, ocurred_on_date
, yr
, mon
, day_of_week
, hr
, ucr_part
, street, lat, long
, loc
,white_pop
,aa_pop
,asian_pop
,napi_pop
,other_pop
,multi_pop
,incident_no
FROM 
(
Select
"District" as district
,Sum(cast("White Pop" as float)) as white_pop
,Sum(cast("Afr Am Pop" as float)) as aa_pop
, Sum(cast("Asian Pop" as float)) as asian_pop
, Sum(cast("Native Am Pacific Pop" as float)) as napi_pop
, Sum(cast("Other Pop" as float)) as other_pop
, Sum(cast("Multi Race Pop" as float)) as multi_pop
FROM
bostonracestats
group by "District"
) A
,(
SELECT 
"INCIDENT_NUMBER" as incident_no
,"OFFENSE_CODE" as offense_code
, "OFFENSE_CODE_GROUP" as offense_code_grp
, "OFFENSE_DESCRIPTION" as offense_desc
, "DISTRICT" as district
, "REPORTING_AREA" as reporting_area
, "SHOOTING" as shooting
, "OCCURRED_ON_DATE" as ocurred_on_date
, "YEAR" as yr
, "MONTH" as mon
, "DAY_OF_WEEK" as day_of_week
, "HOUR" as hr
, "UCR_PART" as ucr_part
, "STREET" as street, "Lat" as lat, "Long" as long, "Location" as loc
FROM bostoncrime
)B
,bostonpd bpd
WHERE
trim(A.district) = trim(bpd."District")
AND
trim(bpd."District_Codes") = trim(B."district")
