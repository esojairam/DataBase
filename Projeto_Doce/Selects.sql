/* selects/joins */

SELECT nome, sobrenome, sexo, nome_social FROM tbpessoa;
SELECT p.nome, c.idcliente, p.idpessoa FROM tbpessoa p, tbcliente c WHERE p.idpessoa=c.id_pessoa ORDER BY idcliente;
SELECT nome,sobrenome FROM tbpessoa WHERE nome LIKE 'J%';
SELECT COUNT(idcliente), tipo_cliente FROM tbcliente WHERE tipo_cliente='pj';
SELECT DISTINCT tipo_pagamento FROM tbvenda;
SELECT SUM(valor_total) FROM tbvenda;
SELECT AVG(valor_total)FROM tbvenda;
SELECT cnpj,inscricao_estadual FROM tbdocumento WHERE cnpj=inscricao_estadual;
SELECT telefone, linkedin FROM tbcontato WHERE telefone LIKE '1%' AND linkedin LIKE '%';
SELECT dt_venda,dt_pagamento,tipo_pagamento FROM tbvenda WHERE tipo_pagamento='crédito' ORDER BY dt_venda;
SELECT DISTINCT nome_prod FROM tbproduto ORDER BY nome_prod;
SELECT MIN(valor_total) FROM tbvenda;
SELECT nome_social,sobrenome, sexo FROM tbpessoa WHERE sexo='o';
SELECT dt_saida,status_entrega,tipo_entrega FROM tbentrega WHERE dt_saida BETWEEN '2020-01-01' AND '2022-01-01';
SELECT nome_prod, dt_validade FROM tbproduto WHERE nome_prod LIKE 'C%';
SELECT cidade,uf,numero,pais FROM tbendereco WHERE numero>'10';
SELECT nome,sobrenome,nome_social,carga_horaria,dt_contratamento FROM tbpessoa p JOIN tbfuncionario f ON p.idpessoa=f.id_pessoa ORDER BY nome;
SELECT email, ddd_telefone, telefone, nome_dist, observacao FROM tbdistribuidor d JOIN tbcontato c ON d.iddistribuidor=c.id_distribuidor;
SELECT tipo_entrega,dt_saida,dt_recebimento FROM tbentrega GROUP BY dt_recebimento HAVING dt_recebimento>'2020-01-01';
SELECT nome_prod,valor_prod,qtd_produto,dt_venda,status_venda FROM tbproduto_tbvenda pv JOIN tbproduto p ON pv.id_produto=p.idproduto JOIN tbvenda v ON pv.id_venda=v.idvenda ORDER BY nome_prod;
SELECT nome_dist, nome_prod, valor_custo FROM tbdistribuidor_tbproduto dp JOIN tbdistribuidor d ON dp.id_distribuidor=d.iddistribuidor JOIN tbproduto p ON dp.id_produto=p.idproduto ORDER BY nome_dist;
SELECT nome,sobrenome,sexo,dt_contratamento,carga_horaria FROM tbpessoa p JOIN tbfuncionario f ON p.idpessoa=f.id_pessoa WHERE carga_horaria>'5';
SELECT nome_prod,valor_custo,qtd_estoque,dt_validade,
	CASE
		WHEN idproduto='17' THEN 'ele tá chorando até agora'
		WHEN dt_validade < '2022-06-20' THEN 'vai vencer(repor)'
        WHEN qtd_estoque < '15' THEN 'tem pouco (repor)'
        WHEN valor_custo <(SELECT AVG(valor_custo) FROM tbdistribuidor_tbproduto) THEN 'aproveita que ta baratinho'
		ELSE 'ta de boa ainda'
    END AS reposicao
FROM tbproduto p JOIN tbdistribuidor_tbproduto dp ON p.idproduto=dp.id_produto;
SELECT nome, sobrenome, sexo, dt_nasc,
	CASE
		WHEN sexo IN ('o','m') THEN 'não é mulher'
		WHEN dt_nasc>'2004-01-01' THEN 'jovem de mais'
        ELSE 'pode dirigir'
	END AS status
FROM tbpessoa ORDER BY status= 'pode dirigir' DESC;
select pv.id_venda, p.nome, p.nome_social, pv.qtd_produto, v.dt_venda, v.valor_total, v.percent_desconto from tbproduto_tbvenda pv join tbvenda v on pv.id_venda=v.idvenda join tbcliente c on v.id_cliente=c.idcliente join tbpessoa p on c.id_pessoa=p.idpessoa;
select p.nome_prod, p.valor_prod, dp.qtd_estoque, p.dt_validade, d.nome_dist, p.descricao_prod from tbdistribuidor_tbproduto dp join tbproduto p on dp.id_produto=p.idproduto join tbdistribuidor d on dp.id_distribuidor=d.iddistribuidor order by dp.qtd_estoque desc;
SELECT nome, sobrenome, funcao FROM tbpessoa p JOIN tbfuncionario f ON p.idpessoa=f.id_pessoa ORDER BY nome DESC;
select v.idvenda, en.status_entrega, en.tipo_entrega, en.tipo_encomenda, e.uf, e.cidade, e.numero, e.cep, e.bairro, e.quadra, e.edificio, e.pais from tbendereco e  join tbentrega en on e.id_entrega=en.identrega join tbvenda v on en.id_venda=v.idvenda;
select f.idfuncionario, p.nome, p.nome_social, f.dt_contratamento, f.numero_cracha, f.funcao, c.linkedin, c.ddd_telefone, c.telefone from tbcontato c right join tbfuncionario f on c.id_funcionario=f.idfuncionario join tbpessoa p on f.id_pessoa=p.idpessoa;
select d.iddistribuidor, d.nome_dist, e.uf, e.cidade, e.numero, e.cep, e.bairro, e.quadra, e.edificio, e.pais, doc.cnpj, doc.inscricao_estadual, c.ddd_telefone, c.telefone, c.email, c.fax, c.linkedin from tbdistribuidor d left join tbendereco e on e.id_distribuidor=d.iddistribuidor left join tbdocumento doc on doc.id_distribuidor=d.iddistribuidor left join tbcontato c on c.id_distribuidor=d.iddistribuidor;
SELECT AVG(valor_custo), nome_prod, qtd_estoque FROM tbdistribuidor_tbproduto dp JOIN tbproduto p ON dp.id_produto=p.idproduto GROUP BY dp.valor_custo HAVING dp.valor_custo < (SELECT AVG(valor_custo) FROM tbdistribuidor_tbproduto) AND dp.qtd_estoque <'20';
SELECT nome,sobrenome,nome_social, tipo_cliente,cpf FROM tbpessoa p JOIN tbcliente c ON p.idpessoa=c.id_pessoa JOIN tbdocumento d ON c.idcliente=d.id_cliente WHERE cpf LIKE '3%';