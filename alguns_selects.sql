use db_bilheteria_digital_cinema;

/*1*/
SELECT titulo, titulo_original,group_concat(ds_genero) as genero 
FROM tb_filme f
JOIN rl_filme_genero rfg ON f.id_filme=rfg.fk_filme
JOIN tb_genero g ON g.cod_genero=rfg.fk_genero
GROUP BY f.titulo;

/*2*/
SELECT c.nome as cinema,tela as sala,cep,bairro,logradouro,numero,m.nome as municipio,es.nome as estado, sigla 
FROM tb_cinema c
JOIN tb_sala s ON c.cnpj=s.fk_cinema
JOIN tb_endereco e ON e.id_endereco=c.fk_endereco
JOIN tb_municipio m ON m.id_municipio=e.fk_municipio
JOIN tb_estado es ON es.id_estado=m.fk_estado;

/*3*/
SELECT c.nome as cinema,tela as sala,id_sessao,cep,bairro,logradouro,numero,m.nome as municipio,es.nome as estado, sigla 
FROM tb_cinema c
JOIN tb_sala s ON c.cnpj=s.fk_cinema
JOIN tb_sessao ss ON s.id_sala=ss.fk_sala
JOIN tb_endereco e ON e.id_endereco=c.fk_endereco
JOIN tb_municipio m ON m.id_municipio=e.fk_municipio
JOIN tb_estado es ON es.id_estado=m.fk_estado;

/*4*/
SELECT f.titulo as filme,i.ds_idioma as idioma,c.nome as cinema,tela as sala,id_sessao as sessao,hr_inicio,cep,bairro,logradouro,numero,m.nome as municipio,es.nome as estado, sigla
FROM tb_cinema c
JOIN tb_sala s ON c.cnpj=s.fk_cinema
JOIN tb_sessao ss ON s.id_sala=ss.fk_sala
JOIN tb_endereco e ON e.id_endereco=c.fk_endereco
JOIN tb_municipio m ON m.id_municipio=e.fk_municipio
JOIN tb_estado es ON es.id_estado=m.fk_estado
JOIN tb_filme f ON f.id_filme=ss.fk_filme
JOIN tb_idioma i ON i.id_idioma=ss.fk_idioma;

/*5*/
SELECT f.titulo as Filme,COUNT(fk_ingresso) as 'Qtd Ingressos Vendidos',SUM(preco_pago) as 'Faturamento'
FROM tb_filme f
JOIN tb_sessao s ON f.id_filme=s.fk_filme
JOIN rl_compra_assento_sessao rcas ON rcas.fk_sessao=s.id_sessao
JOIN tb_compra c ON c.cod_compra=rcas.fk_compra
JOIN rl_status_compra rsc ON c.cod_compra=rsc.fk_compra
WHERE fk_status='2'
GROUP BY Filme
ORDER BY FIELD(Filme,'O Esquadrão Suicida','Shadow','O Empregado e o Patrão',
'O Poderoso Chefinho 2 - Negócios da Família',
'Um Lugar Silencioso - Parte 2','Jungle Cruise',
'Os Croods 2: Uma Nova Era','Velozes & Furiosos 9',
'Free Guy - Assumindo o Controle','Doutor Gama');

/*6*/
SELECT c.nome as Nome,cnpj CNPJ,email "E-mail",es.nome as Estado,m.nome as Cidade,bairro Bairro,logradouro Logradouro,e.numero "Número",cep CEP,IFNULL(complemento,"Não Cadastrado") Complemento,CONCAT('(',(t.ddd),') ',(t.numero)) as Telefone,tt.tipo as 'Tipo De Telefone'
FROM tb_cinema c
JOIN tb_endereco e ON e.id_endereco=c.fk_endereco
JOIN tb_municipio m ON m.id_municipio=e.fk_municipio
JOIN tb_estado es ON es.id_estado=m.fk_estado
JOIN tb_telefone t ON t.fk_cinema=c.cnpj
JOIN tb_tipo_telefone tt ON tt.id_tipo_telefone=t.fk_tipo_telefone
ORDER BY Cidade DESC;


/*7*/
SELECT ds_status as 'Status do Pagamento' , CONCAT('R$',REPLACE(REPLACE(REPLACE(FORMAT(SUM(preco_pago),2),'.','|'),',','.'),'|',',')) as 'Montante dos ingressos',COUNT(preco_pago) as 'Quantidade de assentos' 
FROM tb_compra c
JOIN rl_status_compra rsc ON c.cod_compra=rsc.fk_compra
JOIN tb_status s ON s.cod_status=rsc.fk_status
JOIN rl_compra_assento_sessao rcas ON c.cod_compra=rcas.fk_compra
GROUP BY ds_status
ORDER BY FIELD(ds_status,'Pagamento Cancelado','Pagamento Confirmado','Aguardando Pagamento');

/*8*/
SELECT  cod_ingresso,turno,preco_ingresso,tipo_sessao,
CASE
	WHEN e_promocional=0 THEN 'Não'
    WHEN e_promocional THEN 'Sim'
END AS 'Promoção',IFNULL(ds_promocao,'') as 'Descrição Promoção',
CASE
	WHEN dia_semana='0' THEN 'Segunda-Feira'
    WHEN dia_semana='1' THEN 'Terça-Feira'
    WHEN dia_semana='2' THEN 'Quarta-Feira'
    WHEN dia_semana='3' THEN 'Quinta-Feira'
    WHEN dia_semana='4' THEN 'Sexta-Feira'
    WHEN dia_semana='5' THEN 'Sábado'
    WHEN dia_semana='6' THEN 'Domingo'
END AS 'Dia da Semana'
FROM tb_ingresso i
JOIN tb_dia_semana ds ON i.cod_ingresso=ds.fk_ingresso
WHERE cod_ingresso IN('12','13') OR cod_ingresso="11" AND dia_semana="3"
ORDER BY cod_ingresso;

/*9*/
CREATE VIEW vw_rcas_M AS 
	SELECT 
    CASE
		WHEN sexo = 'M' THEN 'Homem'
	END sexo,
    sum(preco_pago) pagamento, count(co.cod_compra) qtd_compras
    FROM tb_cliente c JOIN tb_compra co ON c.cpf=co.fk_cpf 
    JOIN rl_compra_assento_sessao rcas ON co.cod_compra=rcas.fk_compra
    WHERE sexo='M'
    GROUP BY co.cod_compra;

CREATE VIEW vw_rcas_F AS 
	SELECT 
    CASE
		WHEN sexo = 'F' THEN 'Mulher'
	END sexo,
    sum(preco_pago) pagamento, count(co.cod_compra) qtd_compras
    FROM tb_cliente c JOIN tb_compra co ON c.cpf=co.fk_cpf 
    JOIN rl_compra_assento_sessao rcas ON co.cod_compra=rcas.fk_compra
    WHERE sexo='F'
    GROUP BY co.cod_compra;

SELECT sexo, MAX(pagamento) 'maior compra', MIN(pagamento) 'menor compra', 
FORMAT(AVG(pagamento),2) 'valor médio das compras', COUNT(qtd_compras) 'qtd_compras'
FROM vw_rcas_M GROUP BY sexo
UNION 
SELECT sexo, MAX(pagamento) 'maior compra', MIN(pagamento) 'menor compra', 
FORMAT(AVG(pagamento),2) 'valor médio das compras', COUNT(qtd_compras) 'qtd_compras'
FROM vw_rcas_F GROUP BY sexo;
