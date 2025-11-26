import streamlit as st
import pandas as pd
import psycopg2
from datetime import date

st.set_page_config(page_title="Sistema de Gestão - CRUD", layout="wide")

@st.cache_resource
def init_connection():
    return psycopg2.connect(
        host="localhost",
        database="postgres",  # Mude para o nome do seu banco
        user="postgres",      # Seu usuário
        password="123"        # Sua senha (ATENÇÃO: MUDE AQUI)
    )

conn = init_connection()

# buscar dados (READ)
def ler_tabela(nome_tabela):
    query = f"SELECT * FROM {nome_tabela};"
    return pd.read_sql(query, conn)

# executar inserção (CREATE)
def executar_insert(query, dados):
    try:
        cur = conn.cursor()
        cur.execute(query, dados)
        conn.commit()
        cur.close()
        st.success("Registro inserido com sucesso!")
        st.rerun() # Recarrega a página para mostrar o dado novo
    except Exception as e:
        conn.rollback()
        st.error(f"Erro ao inserir: {e}")

# pegar listas de IDs (para preencher Dropdowns de Foreign Keys)
def get_opcoes(tabela, coluna_id, coluna_nome):
    df = ler_tabela(tabela)
    # Cria um dicionário: {1: '1 - João', 2: '2 - Maria'}
    return {row[coluna_id]: f"{row[coluna_id]} - {row[coluna_nome]}" for index, row in df.iterrows()}


# INTERFACE (FRONT-END)
st.title("📦 Sistema de Gestão Integrado")

# Menu Lateral
menu = st.sidebar.selectbox(
    "Selecione o Módulo",
    ["Clientes", "Funcionários", "Produtos", "Fornecedores", "Pedidos", "Atendimentos"]
)

st.header(f"Gerenciar: {menu}")
tab1, tab2 = st.tabs(["🔍 Visualizar Dados", "➕ Adicionar Novo"])

# MÓDULO CLIENTE
if menu == "Clientes":
    with tab1:
        st.dataframe(ler_tabela("cliente"), use_container_width=True)
    
    with tab2:
        with st.form("form_cliente"):
            c_id = st.number_input("ID Cliente", min_value=1, step=1)
            c_cpf = st.text_input("CPF/CNPJ")
            c_tel = st.text_input("Telefone")
            c_nome = st.text_input("Nome Completo")
            c_end = st.text_input("Endereço")
            
            submitted = st.form_submit_button("Salvar Cliente")
            if submitted:
                query = "INSERT INTO cliente (id_cliente, cpf_cnpj, telefone, nome, endereco) VALUES (%s, %s, %s, %s, %s)"
                executar_insert(query, (c_id, c_cpf, c_tel, c_nome, c_end))

# MÓDULO FUNCIONÁRIO
elif menu == "Funcionários":
    with tab1:
        st.dataframe(ler_tabela("funcionario"), use_container_width=True)
    
    with tab2:
        with st.form("form_func"):
            f_id = st.number_input("ID Funcionário", min_value=1)
            f_cpf = st.text_input("CPF")
            f_mat = st.number_input("Matrícula", min_value=1)
            
            if st.form_submit_button("Salvar Funcionário"):
                query = "INSERT INTO funcionario (id_funcionario, cpf, matricula) VALUES (%s, %s, %s)"
                executar_insert(query, (f_id, f_cpf, f_mat))

# MÓDULO PRODUTO
elif menu == "Produtos":
    with tab1:
        st.dataframe(ler_tabela("produto"), use_container_width=True)
    
    with tab2:
        with st.form("form_prod"):
            p_id = st.number_input("ID Produto", min_value=1)
            p_nome = st.text_input("Nome do Produto")
            p_est = st.number_input("Estoque", min_value=0)
            p_preco = st.number_input("Preço (R$)", min_value=0.01, format="%.2f")
            
            if st.form_submit_button("Salvar Produto"):
                query = "INSERT INTO produto (id_produto, nome, estoque, preco) VALUES (%s, %s, %s, %s)"
                executar_insert(query, (p_id, p_nome, p_est, p_preco))

# MÓDULO PEDIDO
elif menu == "Pedidos":
    with tab1:
        st.subheader("Pedidos Realizados")
        st.dataframe(ler_tabela("pedido"), use_container_width=True)
        st.subheader("Itens dos Pedidos")
        st.dataframe(ler_tabela("pedido_produto"), use_container_width=True)
    
    with tab2:
        st.info("Para criar um pedido, selecione um cliente existente.")
        opcoes_clientes = get_opcoes("cliente", "id_cliente", "nome")
        
        with st.form("form_pedido"):
            ped_id = st.number_input("ID Pedido", min_value=1)
            ped_data = st.date_input("Data Emissão", date.today())
            ped_valor = st.number_input("Valor Total", format="%.2f")
            ped_status = st.selectbox("Status", ["pendente", "pago", "cancelado"])
            
            cliente_selecionado = st.selectbox("Cliente", options=list(opcoes_clientes.keys()), format_func=lambda x: opcoes_clientes[x])
            
            if st.form_submit_button("Salvar Pedido"):
                query = "INSERT INTO pedido (id_pedido, dataemissao, valor_total, status, id_cliente) VALUES (%s, %s, %s, %s, %s)"
                executar_insert(query, (ped_id, ped_data, ped_valor, ped_status, cliente_selecionado))

# MÓDULO ATENDIMENTO
elif menu == "Atendimentos":
    with tab1:
        st.dataframe(ler_tabela("atendimento"), use_container_width=True)
    
    with tab2:
        opcoes_func = get_opcoes("funcionario", "id_funcionario", "cpf") # Usando CPF como label pois func nao tem nome na tabela
        opcoes_cli = get_opcoes("cliente", "id_cliente", "nome")

        with st.form("form_atend"):
            at_id = st.number_input("ID Atendimento", min_value=1)
            at_data = st.date_input("Data Atendimento", date.today())
            
            sel_func = st.selectbox("Funcionário", options=list(opcoes_func.keys()), format_func=lambda x: opcoes_func[x])
            sel_cli = st.selectbox("Cliente", options=list(opcoes_cli.keys()), format_func=lambda x: opcoes_cli[x])

            if st.form_submit_button("Registrar Atendimento"):
                query = "INSERT INTO atendimento (id_atendimento, data_atend, id_funcionario, id_cliente) VALUES (%s, %s, %s, %s)"
                executar_insert(query, (at_id, at_data, sel_func, sel_cli))

# MÓDULO GENÉRICO 
else:
    # Exibe qualquer outra tabela selecionada de forma simples
    tabela_atual = "fornecedor" if menu == "Fornecedores" else menu.lower()
    st.dataframe(ler_tabela(tabela_atual), use_container_width=True)
    st.warning("Formulário de cadastro específico ainda não implementado para este módulo.")

# RODAPÉ
st.markdown("---")
st.caption("Desenvolvido para aula de Engenharia de Software - Integração Python/PostgreSQL")