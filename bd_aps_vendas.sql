CREATE SEQUENCE IF NOT EXISTS aps_clientes_aps_idcliente_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS public.aps_clientes (
    aps_idcliente integer NOT NULL DEFAULT nextval('aps_clientes_aps_idcliente_seq'::regclass),
    aps_nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    aps_data_nascimento date NOT NULL,
    aps_cpf character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT aps_clientes_pkey PRIMARY KEY (aps_idcliente)
);

CREATE SEQUENCE IF NOT EXISTS aps_produtos_aps_idproduto_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS public.aps_produtos (
    aps_idproduto integer NOT NULL DEFAULT nextval('aps_produtos_aps_idproduto_seq'::regclass),
    aps_nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    aps_marca character varying(80) COLLATE pg_catalog."default" NOT NULL,
    aps_modelo character varying(80) COLLATE pg_catalog."default" NOT NULL,
    aps_valor double precision NOT NULL,
    CONSTRAINT aps_produtos_pkey PRIMARY KEY (aps_idproduto)
);

CREATE SEQUENCE IF NOT EXISTS aps_vendas_aps_idvenda_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS public.aps_vendas (
    aps_idvenda integer NOT NULL DEFAULT nextval('aps_vendas_aps_idvenda_seq'::regclass),
    aps_data_venda date NOT NULL,
    aps_total_venda double precision NOT NULL,
    aps_idcliente integer NOT NULL,
    CONSTRAINT aps_vendas_pkey PRIMARY KEY (aps_idvenda),
    CONSTRAINT aps_vendas_aps_idcliente_fkey FOREIGN KEY (aps_idcliente)
        REFERENCES public.aps_clientes (aps_idcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.aps_venda_produtos (
    aps_idvenda integer NOT NULL,
    aps_idproduto integer NOT NULL,
    aps_quantidade double precision NOT NULL,
    aps_total_item double precision NOT NULL,
    aps_desconto_item double precision NOT NULL,
    CONSTRAINT aps_venda_produtos_pkey PRIMARY KEY (aps_idvenda, aps_idproduto),
    CONSTRAINT aps_venda_produtos_aps_idvenda_fkey FOREIGN KEY (aps_idvenda)
        REFERENCES public.aps_vendas (aps_idvenda) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT aps_venda_produtos_aps_idproduto_fkey FOREIGN KEY (aps_idproduto)
        REFERENCES public.aps_produtos (aps_idproduto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
