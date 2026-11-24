-- Camada Semântica: Cálculo de Tempo de Ciclo e Classificação de SLA (Meta <= 3.0h)
CREATE OR REPLACE VIEW public.vw_fatos_operacao AS
SELECT 
    id_ordem,
    placa_veiculo,
    data_chamado,
    data_conclusao,
    ROUND(EXTRACT(EPOCH FROM (data_conclusao - data_chamado)) / 3600::numeric, 2) AS horas_ciclo,
    CASE
        WHEN (EXTRACT(EPOCH FROM (data_conclusao - data_chamado)) / 3600::numeric) > 3.0 THEN 'Atrasado'
        ELSE 'No Prazo'
    END AS status_sla
FROM tb_operacoes;
