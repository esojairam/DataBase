/* update */

-- documento
select * from tbdocumento;
update tbdocumento set rg='5415618' where id_cliente='5';
update tbdocumento set rg='3657345' where id_cliente='14';
update tbdocumento set rg='8785220' where id_cliente='17';

-- endereco
select * from tbendereco;
update tbendereco set uf='AV' where idendereco='13';
update tbendereco set cidade='New York' where idendereco='12';
update tbendereco set quadra='8' where idendereco='6';

-- entrega
select * from tbentrega;
update tbentrega set tipo_encomenda='sólido' where identrega='1';
update tbentrega set status_entrega='preparando' where identrega='8';
update tbentrega set dt_saida=null where identrega='8';

-- produto_venda
select * from tbproduto_tbvenda;
update tbproduto_tbvenda set qtd_produto='4' where idprod_venda='1';
update tbproduto_tbvenda set qtd_produto='16' where idprod_venda='9';
update tbproduto_tbvenda set qtd_produto='21' where idprod_venda='10';

-- venda
select * from tbvenda;
update tbvenda set percent_desconto='10' where idvenda='9';
update tbvenda set dt_venda='2017-06-20' where idvenda='15';
update tbvenda set status_venda='pendente' where idvenda='7';

-- cliente
select * from tbcliente;
update tbcliente set tipo_cliente='pf' where idcliente='2';
update tbcliente set tipo_cliente='pf' where idcliente='4';
update tbcliente set tipo_cliente='pj' where idcliente='15';

-- contato
select * from tbcontato;
update tbcontato set telefone='654654418' where idcontato='1';
update tbcontato set email='joseaocontrario@gmail.com' where idcontato='3';
update tbcontato set linkedin='tianeidedoces' where idcontato='10';

-- distribuidor
select * from tbdistribuidor;
update tbdistribuidor set observacao='produtos de chocolate' where iddistribuidor='2';
update tbdistribuidor set nome_dist='João salgados e doces' where iddistribuidor='17';
update tbdistribuidor set observacao='Aqui não tem doce nem salgado' where iddistribuidor='17';

-- distribuidor_produto
select * from tbdistribuidor_tbproduto;
update tbdistribuidor_tbproduto set dt_compra='2022-05-16' where iddist_prod='5';
update tbdistribuidor_tbproduto set valor_custo='440.00' where iddist_prod='17';
update tbdistribuidor_tbproduto set qtd_estoque='32' where iddist_prod='9';

-- funcionario
select * from tbfuncionario;
update tbfuncionario set carga_horaria='6' where idfuncionario='1';
update tbfuncionario set funcao='balconista' where idfuncionario='7';
update tbfuncionario set numero_cracha='151' where idfuncionario='11';

-- pessoa
select * from tbpessoa;
update tbpessoa set nome='ze', sobrenome='ninguem' where idpessoa='4';
update tbpessoa set nome_social='carla' where idpessoa='9';
update tbpessoa set dt_nasc='1998-01-23' where idpessoa='11';

-- produto
select * from tbproduto;
update tbproduto set dt_fabricacao='2020-10-13' where idproduto='7';
update tbproduto set dt_fabricacao='2020-10-13' where idproduto='8';
update tbproduto set dt_fabricacao='2020-10-13' where idproduto='16';

/* delete */
-- documento
delete from tbdocumento where iddoc='15';

-- endereco
select * from tbendereco;
delete from tbendereco where idendereco='16';
delete from tbendereco where idendereco='7';
delete from tbendereco where idendereco='9';

-- entrega
delete from tbentrega where identrega='2';
delete from tbentrega where identrega='8';

-- produto_venda
delete from tbproduto_tbvenda where idprod_venda='2';
delete from tbproduto_tbvenda where idprod_venda='8';

-- venda
delete from tbvenda where idvenda='2';
delete from tbvenda where idvenda='8';

-- cliente
delete from tbcliente where idcliente='3';
delete from tbcliente where idcliente='15';