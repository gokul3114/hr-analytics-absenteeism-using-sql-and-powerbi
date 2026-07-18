create database hr_work;
use hr_work;

select * from reasons;
select * from compensation;
select * from absenteeism_at_work;

select * from absenteeism_at_work a
left join compensation c on
a.ID=c.ID;

select ID,`Reason for absence`,Reason from absenteeism_at_work a
left join reasons r on
a.`Reason for absence`=r.Number;

--- find the healthiest

select * from absenteeism_at_work 
where `Social smoker`=0
and
`Social drinker`=0
and 
`Body mass index`<25
and  `Absenteeism time in hours`<
(select avg(`Absenteeism time in hours`) from absenteeism_at_work);

--- compensation rate increase for non-smokers/budget $983,221 so .68 cent increase per hour

select count(*) as nonsmokers from absenteeism_at_work
where `Social smoker`=0 ;

select a.ID,
r.Reason,
`Month of absence`,
`Body mass index`,
case 
when `Body mass index`<18.5 then "UnderWeight"
when `Body mass index`between 18.5  and 25 then "Healthy"
when `Body mass index`between 25 and 30 then "OverWeight"
when `Body mass index`>30 then "Obese"
else "UnKnown"
end as BMI_Category,
case
when `Month of absence` in (12,1,2) then "Winter"
when `Month of absence` in (3,4,5) then "Spring"
when `Month of absence` in (6,7,8) then "Summer"
when `Month of absence` in (9,10,11) then "Fall"
else "unknown"
end as season_names,
`Month of absence`,
`Day of the week`,
`Transportation expense`,
Education,
Son,
`Social smoker`,
`Social drinker`,
pet,
`Disciplinary failure`,
Age,
`Work load Average/day`,
`Absenteeism time in hours`
from absenteeism_at_work a
left join compensation c on
a.ID=c.ID
left join reasons r on
a.`Reason for absence`=r.Number;


