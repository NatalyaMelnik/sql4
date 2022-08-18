select g.name, count(e.name) 
from genre as g 
left join genreexecutor as ge on g.id = ge.genre_id
left join executor as e on ge.executor_id = e.id 
group by g.name
order by count(e.name) DESC;

select count(t.name), a.year_of_issue
from album as a 
left join track t on a.id = t.album_id 
where a.year_of_issue between 2019 and 2020
group by a.year_of_issue
order by count(t.name);

select a.name, AVG(t.duration)
from album a
left join track t on a.id = t.album_id
group by a.name
order by AVG(t.duration);

--исправленный запрос: все исполнители, которые не выпустили альбомы в 2020 году
select distinct e.name
from executor as e
left join executoralbum as ea on e.id = ea.executor_id
left join album a on a.id = ea.album_id 
where a.year_of_issue not in (select a.year_of_issue from album a2 where a.year_of_issue = 2020);


select distinct c.name
from compilation c 
left join compilationtrack ct on ct.compilation_id = c.id 
left join track t on t.id = ct.track_id  
left join album a on a.id = t.album_id 
left join executoralbum ea on ea.album_id = a.id 
left join executor e on e.id = ea.executor_id 
where e.name like '%%Баста%%'
order by c.name;

select a.name
from album a 
left join executoralbum ea on ea.album_id = a.id 
left join executor e on e.id  = ea.executor_id 
left join genreexecutor ge on e.id = ge.executor_id 
left join genre g on g.id = ge.genre_id 
group by a.name
having count(distinct g.name) > 1
order by a.name;

select t.name
from track t 
left join CompilationTrack as ct on t.id=ct.track_id
where ct.track_id is null;

--исправленный запрос: исполнителя(-ей), написавшего самый короткий по продолжительности трек
select e.name, t.duration
from track as t
left join album as a on t.album_id = a.id 
left join executoralbum as ea on a.id = ea.album_id 
left join executor as e on e.id = ea.executor_id
group by e.name, t.duration 
having t.duration = (select min(duration) from track as t2)
order by e.name;

select distinct a.name
from album a 
left join track t on t.album_id = a.id 
where t.album_id in (select t.album_id
from track t 
group by album_id
having count(id)=( 
select count(id)
from track t 
group by album_id 
order by count(id)
limit 1))
order by a.name;