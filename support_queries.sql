USE transparencia;

SELECT COUNT(*) FROM fato_orcado_liquidado;
SELECT * FROM dimensao_programa;

SELECT * FROM fato_orcado_liquidado;

SELECT orgao_superior, dimensao_orgao_id_orgao, SUM(valor_liquidado), SUM(valor_orcado) FROM fato_orcado_liquidado as fato
JOIN dimensao_orgao as orgao ON fato.dimensao_orgao_id_orgao = orgao.id_orgao GROUP BY dimensao_orgao_id_orgao;

SELECT orgao_superior FROM dimensao_orgao GROUP BY orgao_superior;

DELETE FROM dimensao_orgao_superior;
SET SQL_SAFE_UPDATES = 0;
 
 
SELECT SUM(valor_liquidado), id_orgao_superior, dimensao_ano_orgao_superior.id_ano FROM fato_orcado_liquidado AS fato_liquid 
JOIN dimensao_orgao ON fato_liquid.dimensao_orgao_id_orgao = dimensao_orgao.id_orgao 
JOIN dimensao_temporal ON fato_liquid.dimensao_temporal_id_dimensao_temporal = dimensao_temporal.id_dimensao_temporal
JOIN dimensao_orgao_superior ON dimensao_orgao.orgao_superior = dimensao_orgao_superior.nome_orgao_superior
JOIN dimensao_ano_orgao_superior ON dimensao_temporal.ano = dimensao_ano_orgao_superior.ano
WHERE dimensao_temporal.ano = '2019'
GROUP BY id_orgao_superior, dimensao_ano_orgao_superior.id_ano;

SELECT funcao FROM dimensao_area_atuacao GROUP BY funcao;
SELECT * FROM dimensao_funcao;

SELECT SUM(valor_liquidado), dimensao_funcao.id_funcao, dimensao_ano_funcao.id_ano_funcao FROM fato_orcado_liquidado AS fato_liquid
JOIN dimensao_area_atuacao AS area_atuacao ON fato_liquid.dimensao_area_atuacao_id_dimensao_area_atuacao = area_atuacao.id_dimensao_area_atuacao 
JOIN dimensao_temporal ON fato_liquid.dimensao_temporal_id_dimensao_temporal = dimensao_temporal.id_dimensao_temporal
JOIN dimensao_ano_funcao ON dimensao_temporal.ano = dimensao_ano_funcao.ano
JOIN dimensao_funcao ON area_atuacao.funcao = dimensao_funcao.nome_funcao
WHERE dimensao_temporal.ano = '2019'
GROUP BY dimensao_funcao.id_funcao,  dimensao_ano_funcao.id_ano_funcao;

SELECT programa_orcamentario FROM dimensao_programa GROUP BY programa_orcamentario;
SELECT * FROM dimensao_programas;

SELECT SUM(valor_liquidado), programas.id_programas, dimensao_ano_programa.id_ano_programa FROM fato_orcado_liquidado AS fato_liquid 
JOIN dimensao_programa AS programa ON fato_liquid.dimensao_programa_id_dimensao_programa = programa.id_dimensao_programa
JOIN dimensao_temporal ON fato_liquid.dimensao_temporal_id_dimensao_temporal = dimensao_temporal.id_dimensao_temporal
JOIN dimensao_ano_programa ON dimensao_temporal.ano = dimensao_ano_programa.ano
JOIN dimensao_programas as programas ON programa.programa_orcamentario = programas.nome_programa
WHERE dimensao_temporal.ano = '2019'
GROUP BY programas.id_programas, dimensao_ano_programa.id_ano_programa;

SELECT * FROM fato_programa_total;