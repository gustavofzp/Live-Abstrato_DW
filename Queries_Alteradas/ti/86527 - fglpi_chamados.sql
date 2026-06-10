-----------------------------------------------------
-- fglpi_chamados
----------------------------------------------------- 
SELECT
    chamado.id,
    chamado.date,
    chamado.closedate,
    chamado.solvedate,
    chamado.slas_id_tto,
    chamado.slas_id_ttr,
    chamado.sla_waiting_duration,
    chamado.slalevels_id_ttr,
    chamado.time_to_resolve as tempo_para_solucao,
    chamado.status,
    chamado.priority,
    chamado.urgency as urgencia,
    chamado.impact as impacto,
    (chamado.priority * chamado.impact * chamado.urgency) as gut,
    chamado.itilcategories_id as categoria_id,
    categoria.name AS categoria,
    -- Tipo Chamado
    case
        when categoria.completename like 'MELH.%' then
            case
                when categoria.completename like 'MELH.SERVIÇO%' then 'SERVIÇO'
                when categoria.completename like 'MELH.PROJETO%' then 'PROJETO'
                else 'MELHORIA'
            end
        WHEN categoria.completename like 'ATEND.%' THEN 'ATENDIMENTO'
        WHEN categoria.completename like 'SERVIÇO%' then 'SERVIÇO'
        ELSE 'INDEFINIDO'
    end as tipo_chamado,    
    tkt_tec.users_id    as id_tecnico,
    tecnico.name        as tecnico,
    solicitante.id      AS id_solicitante,
    solicitante.name    AS solicitante,
    grupo.id as id_grupo_solicitante,
    TIMESTAMPDIFF(HOUR, chamado.date, chamado.closedate) AS horas_resolucao,
    CASE
        when chamado.solvedate is not null then TIMESTAMPDIFF(HOUR, chamado.date, chamado.solvedate)
        ELSE TIMESTAMPDIFF(HOUR, chamado.date, sysdate())
    END AS horas_solucao,
    sla_ttr.number_time as SLA_esperado,
    CASE
        -- Regra para MELHORIA (Tipo 1): Converte horas para dias (/24) e compara
        WHEN categoria.completename like 'MELH.%' AND 
             CAST((CASE WHEN chamado.solvedate is not null THEN TIMESTAMPDIFF(HOUR, chamado.date, chamado.solvedate) ELSE TIMESTAMPDIFF(HOUR, chamado.date, sysdate()) END) / 24 AS UNSIGNED) > sla_ttr.number_time 
             THEN 'Fora SLA'
        WHEN categoria.completename like 'MELH.%' AND 
             CAST((CASE WHEN chamado.solvedate is not null THEN TIMESTAMPDIFF(HOUR, chamado.date, chamado.solvedate) ELSE TIMESTAMPDIFF(HOUR, chamado.date, sysdate()) END) / 24 AS UNSIGNED) <= sla_ttr.number_time 
             THEN 'Dentro SLA'
        -- Regra para ATENDIMENTO (Tipo 2): Compara horas diretamente
        WHEN categoria.completename like 'ATEND.%' AND 
             (CASE WHEN chamado.solvedate is not null THEN TIMESTAMPDIFF(HOUR, chamado.date, chamado.solvedate) ELSE TIMESTAMPDIFF(HOUR, chamado.date, sysdate()) END) > sla_ttr.number_time 
             THEN 'Fora SLA'
        WHEN categoria.completename like 'ATEND.%' AND 
             (CASE WHEN chamado.solvedate is not null THEN TIMESTAMPDIFF(HOUR, chamado.date, chamado.solvedate) ELSE TIMESTAMPDIFF(HOUR, chamado.date, sysdate()) END) <= sla_ttr.number_time 
             THEN 'Dentro SLA'
        ELSE 'Indefinido'
    END as sla,
    ps.satisfaction     AS nota_survey,
    ps.comment          AS comentario_survey,
    ps.date_submission  AS data_survey,
    CONCAT('https://sistemas.liveoficial.ind.br/front/ticket.form.php?id=', chamado.id) AS link_chamado,
    chamado.name as titulo,
    cust.name as tipo_prioridade,
    CASE 
       when (cust.cost_material is null 
            and cust.name = 'PR') then 0
       else cust.cost_material
    END as prioridade_cs,
    CASE 
       when (entrega.cost_material is null 
            and entrega.name = 'SPRINT') then 0
       else entrega.cost_material
    END as sprint,
    CASE 
       when (orcam.cost_material is null 
            and orcam.name = 'ORCA') then 0
       else orcam.cost_fixed
    END as valor_orcamento
FROM glpi_tickets chamado
    /* ===== SLA ===== */
    LEFT JOIN glpi_slas sla_ttr 
       ON chamado.slas_id_ttr = sla_ttr.id
    /* ===== Usuários Solicitantes ===== */
    LEFT JOIN glpi_tickets_users tkt_user
       ON tkt_user.tickets_id = chamado.id
       AND tkt_user.type = 1
    LEFT JOIN glpi_users solicitante
       ON solicitante.id = tkt_user.users_id
    /* ===== Técnicos Responsáveis ===== */
    LEFT JOIN glpi_tickets_users tkt_tec
       ON tkt_tec.tickets_id = chamado.id
       AND tkt_tec.type = 2
    LEFT JOIN glpi_users tecnico
       ON tecnico.id = tkt_tec.users_id
       and tecnico.is_active = 1
       /*and tecnico.locations_id = 6 -- tecnicos TI*/   /*Regra removida pelo chamado 3469 - Cris 02/02/2026 */
    /* ===== Grupos Solicitantes ===== */
    left join glpi_groups_users grp_solicitante
        on grp_solicitante.users_id = solicitante.id
    left join glpi_groups grupo
        on grupo.id = grp_solicitante.groups_id
        and grupo.id not in (593, 594)
    /* ===== Survey ===== */
    LEFT JOIN glpi_plugin_live_ticketsatisfactionsurvey ps
      ON chamado.id = ps.tickets_id
    left join glpi_itilcategories categoria
        on chamado.itilcategories_id = categoria.id
    /* ===== Prioridade ===== */
    LEFT join glpi_ticketcosts cust
        on cust.tickets_id = chamado.id
        and cust.name = 'PR'
    /* ===== Entrega Valor ===== */
    LEFT join glpi_ticketcosts entrega
        on entrega.tickets_id = chamado.id
        and entrega.name = 'SPRINT'
    /* ===== Valor Orcamento ===== */
    LEFT join glpi_ticketcosts orcam
        on orcam.tickets_id = chamado.id
        and orcam.name = 'ORCA'
WHERE 1=1
    and chamado.is_deleted = 0
    and chamado.`date` >= '2026-01-01'
GROUP BY
    chamado.id,
    chamado.date,
    chamado.closedate,
    chamado.solvedate,
    chamado.slas_id_tto,
    chamado.slas_id_ttr,
    chamado.sla_waiting_duration,
    chamado.slalevels_id_ttr,
    chamado.time_to_resolve,
    chamado.status,
    chamado.priority,
    chamado.urgency,
    chamado.impact,
    chamado.itilcategories_id,
    categoria.name,
    categoria.completename,
    tkt_tec.users_id,
    tecnico.name,
    solicitante.id,
    solicitante.name,
    TRIM(SUBSTRING_INDEX(grupo.completename, '>', 1)),
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(grupo.completename, '>', 2), '>', -1)),
    TRIM(SUBSTRING_INDEX(grupo.completename, '>', -1)),
    TIMESTAMPDIFF(HOUR, chamado.date, chamado.closedate),
    ps.satisfaction,
    ps.comment,
    ps.date_submission,
    chamado.name,
    cust.name,
    cust.cost_material,
    sla_ttr.number_time;