
insert into dim_date
select to_number(to_char(datum,'yyyymmdd'), '99999999') as sk_tempo,
datum as nk_date,
to_char(datum,'dd/mm/yyyy') as complete_date_description,
extract (year from datum) as year_number,
'T' || to_char(datum, 'q') as trimester_name,
to_char(datum, '"T"q/yyyy') as year_trimestrer_name,
extract(month from datum) as month_number,
to_char(datum, 'tmMonth') as month_name,
to_char(datum, 'yyyy/mm') as year_month,
extract(week from datum) as week_number,
to_char(datum, 'iyyy/iw') as year_week,
extract(day from datum) as day_number,
extract(doy from datum) as day_year_number,
to_char(datum, 'tmDay') as weekday_name,
case when extract(isodow from datum) in (6, 7) then 'Sim' else 'Não'
end as flag_final_semana,
case when to_char(datum, 'mmdd') in ('0101','0421','0501','0907','1012','1102','1115','1120','1225') then 'Sim' else 'Não'
end as flag_feriado,
case 
---incluir aqui os feriados
when to_char(datum, 'mmdd') = '0101' then 'Ano Novo' 
when to_char(datum, 'mmdd') = '0329' then 'Sexta Feira Santa'
when to_char(datum, 'mmdd') = '0421' then 'Tiradentes'
when to_char(datum, 'mmdd') = '0501' then 'Dia do Trabalhador'
when to_char(datum, 'mmdd') = '0907' then 'Dia da Pátria' 
when to_char(datum, 'mmdd') = '1012' then 'Nossa Senhora Aparecida' 
when to_char(datum, 'mmdd') = '1102' then 'Finados' 
when to_char(datum, 'mmdd') = '1115' then 'Proclamação da República'
when to_char(datum, 'mmdd') = '1120' then 'Dia da Consciência Negra'
when to_char(datum, 'mmdd') = '1225' then 'Natal' 
else 'Não é Feriado'
end as nm_feriado,
current_timestamp as data_carga,
'2199-12-31',
1
from (
---incluir aqui a data de início do script, criaremos 15 anos de datas
select '2020-01-01'::date + sequence.day as datum
from generate_series(0,5479) as sequence(day)
group by sequence.day
) dq
order by 1;
SELECT * FROM dim_date;