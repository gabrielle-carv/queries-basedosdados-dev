# -*- coding: utf-8 -*-
"""
Constant values for the projects
"""

from enum import Enum


class constants(Enum):  # pylint: disable=c0103
    """
    Constant values for the br_anatel_telefonia_movel project
    """

    rename_afd = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede', 'ED_INF_CAT_1':'afd_ei_grupo_1', 'ED_INF_CAT_2':'afd_ei_grupo_2',
              'ED_INF_CAT_3':'afd_ei_grupo_3', 'ED_INF_CAT_4':'afd_ei_grupo_4', 'ED_INF_CAT_5':'afd_ei_grupo_5', 'FUN_CAT_1':'afd_ef_grupo_1', 
              'FUN_CAT_2':'afd_ef_grupo_2', 'FUN_CAT_3':'afd_ef_grupo_3', 'FUN_CAT_4':'afd_ef_grupo_4', 'FUN_CAT_5':'afd_ef_grupo_5', 'FUN_AI_CAT_1':'afd_ef_anos_iniciais_grupo_1',
              'FUN_AI_CAT_2':'afd_ef_anos_iniciais_grupo_2', 'FUN_AI_CAT_3':'afd_ef_anos_iniciais_grupo_3', 'FUN_AI_CAT_4':'afd_ef_anos_iniciais_grupo_4',
              'FUN_AI_CAT_5':'afd_ef_anos_iniciais_grupo_5', 'FUN_AF_CAT_1':'afd_ef_anos_finais_grupo_1', 'FUN_AF_CAT_2':'afd_ef_anos_finais_grupo_2',
              'FUN_AF_CAT_3':'afd_ef_anos_finais_grupo_3', 'FUN_AF_CAT_4':'afd_ef_anos_finais_grupo_4', 'FUN_AF_CAT_5':'afd_ef_anos_finais_grupo_5',
              'MED_CAT_1':'afd_em_grupo_1', 'MED_CAT_2':'afd_em_grupo_2', 'MED_CAT_3':'afd_em_grupo_3', 'MED_CAT_4':'afd_em_grupo_4', 'MED_CAT_5':'afd_em_grupo_5',
              'EJA_FUN_CAT_1':'afd_eja_fundamental_grupo_1', 'EJA_FUN_CAT_2':'afd_eja_fundamental_grupo_2', 'EJA_FUN_CAT_3':'afd_eja_fundamental_grupo_3',
              'EJA_FUN_CAT_4':'afd_eja_fundamental_grupo_4', 'EJA_FUN_CAT_5':'afd_eja_fundamental_grupo_5', 'EJA_MED_CAT_1':'afd_eja_medio_grupo_1',
              'EJA_MED_CAT_2':'afd_eja_medio_grupo_2', 'EJA_MED_CAT_3':'afd_eja_medio_grupo_3', 'EJA_MED_CAT_4':'afd_eja_medio_grupo_4', 
              'EJA_MED_CAT_5':'afd_eja_medio_grupo_5'}

    rename_atu = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'ED_INF_CAT_0':'atu_ei', 'CRE_CAT_0':'atu_ei_creche', 'PRE_CAT_0':'atu_ei_pre_escola', 'FUN_CAT_0':'atu_ef',
              'FUN_AI_CAT_0':'atu_ef_anos_iniciais', 'FUN_AF_CAT_0':'atu_ef_anos_finais', 'FUN_01_CAT_0':'atu_ef_1_ano',
              'FUN_02_CAT_0':'atu_ef_2_ano', 'FUN_03_CAT_0':'atu_ef_3_ano', 'FUN_04_CAT_0':'atu_ef_4_ano',
              'FUN_05_CAT_0':'atu_ef_5_ano', 'FUN_06_CAT_0':'atu_ef_6_ano', 'FUN_07_CAT_0':'atu_ef_7_ano', 
              'FUN_08_CAT_0':'atu_ef_8_ano', 'FUN_09_CAT_0':'atu_ef_9_ano', 'MULT_ETA_CAT_0':'atu_ef_turmas_unif_multi_fluxo',
              'MED_CAT_0':'atu_em', 'MED_01_CAT_0':'atu_em_1_ano', 'MED_02_CAT_0':'atu_em_2_ano', 'MED_03_CAT_0':'atu_em_3_ano',
              'MED_04_CAT_0':'atu_em_4_ano', 'MED_NS_CAT_0':'atu_em_nao_seriado'}

    rename_dsu = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'ED_INF_CAT_0':'dsu_ei', 'CRE_CAT_0':'dsu_ei_creche', 'PRE_CAT_0':'dsu_ei_pre_escola', 'FUN_CAT_0':'dsu_ef',
              'FUN_AI_CAT_0':'dsu_ef_anos_iniciais', 'FUN_AF_CAT_0':'dsu_ef_anos_finais', 'MED_CAT_0':'dsu_em',
              'PROF_CAT_0':'dsu_ep', 'EJA_CAT_0':'dsu_eja', 'EDU_BAS_CAT_0':'dsu_ee'}


    rename_had = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'ED_INF_CAT_0':'had_ei', 'CRE_CAT_0':'had_ei_creche', 'PRE_CAT_0':'had_ei_pre_escola',
              'FUN_CAT_0':'had_ef', 'FUN_AI_CAT_0':'had_ef_anos_iniciais', 'FUN_AF_CAT_0':'had_ef_anos_finais', 'FUN_01_CAT_0':'had_ef_1_ano',
              'FUN_02_CAT_0':'had_ef_2_ano', 'FUN_03_CAT_0':'had_ef_3_ano', 'FUN_04_CAT_0':'had_ef_4_ano', 'FUN_05_CAT_0':'had_ef_5_ano',
              'FUN_06_CAT_0':'had_ef_6_ano', 'FUN_07_CAT_0':'had_ef_7_ano', 'FUN_08_CAT_0':'had_ef_8_ano', 'FUN_09_CAT_0':'had_ef_9_ano',
              'MED_CAT_0':'had_em', 'MED_01_CAT_0':'had_em_1_ano', 'MED_02_CAT_0':'had_em_2_ano', 'MED_03_CAT_0':'had_em_3_ano',
              'MED_04_CAT_0':'had_em_4_ano', 'MED_NS_CAT_01':'had_em_nao_seriado'}


    rename_icg = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'EDU_BAS_CAT_1':'icg_nivel_1', 'EDU_BAS_CAT_2':'icg_nivel_2', 'EDU_BAS_CAT_3':'icg_nivel_3',
              'EDU_BAS_CAT_4':'icg_nivel_4', 'EDU_BAS_CAT_5':'icg_nivel_5', 'EDU_BAS_CAT_6':'icg_nivel_6'}


    rename_ied = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'FUN_CAT_1':'ied_ef_nivel_1', 'FUN_CAT_2':'ied_ef_nivel_2', 'FUN_CAT_3':'ied_ef_nivel_3',
              'FUN_CAT_4':'ied_ef_nivel_4', 'FUN_CAT_5':'ied_ef_nivel_5', 'FUN_CAT_6':'ied_ef_nivel_6',
              'FUN_AI_CAT_1':'ied_ef_anos_iniciais_nivel_1', 'FUN_AI_CAT_2':'ied_ef_anos_iniciais_nivel_2',
              'FUN_AI_CAT_3':'ied_ef_anos_iniciais_nivel_3', 'FUN_AI_CAT_4':'ied_ef_anos_iniciais_nivel_4',
              'FUN_AI_CAT_5':'ied_ef_anos_iniciais_nivel_5', 'FUN_AI_CAT_6':'ied_ef_anos_iniciais_nivel_6',
              'FUN_AF_CAT_1':'ied_ef_anos_finais_nivel_1', 'FUN_AF_CAT_2':'ied_ef_anos_finais_nivel_2',
              'FUN_AF_CAT_3':'ied_ef_anos_finais_nivel_3', 'FUN_AF_CAT_4':'ied_ef_anos_finais_nivel_4',
              'FUN_AF_CAT_5':'ied_ef_anos_finais_nivel_5', 'FUN_AF_CAT_6':'ied_ef_anos_finais_nivel_6',
              'MED_CAT_1':'ied_em_nivel_1', 'MED_CAT_2':'ied_em_nivel_2', 'MED_CAT_3':'ied_em_nivel_3',
              'MED_CAT_4':'ied_em_nivel_4', 'MED_CAT_5':'ied_em_nivel_5', 'MED_CAT_6':'ied_em_nivel_6'}

    rename_ird = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'EDU_BAS_CAT_1':'ird_baixa_regularidade', 'EDU_BAS_CAT_2':'ird_media_baixa', 
              'EDU_BAS_CAT_3':'ird_media_alta', 'EDU_BAS_CAT_4':'ird_alta'}
              
    rename_tdi = {'NU_ANO_CENSO':'ano', 'CO_MUNICIPIO':'id_municipio', 'NO_CATEGORIA':'localizacao', 'NO_DEPENDENCIA':'rede',
              'FUN_CAT_0':'tdi_ef', 'FUN_AI_CAT_0':'tdi_ef_anos_iniciais', 'FUN_AF_CAT_0':'tdi_ef_anos_finais',
              'FUN_01_CAT_0':'tdi_ef_1_ano', 'FUN_02_CAT_0':'tdi_ef_2_ano', 'FUN_03_CAT_0':'tdi_ef_3_ano',
              'FUN_04_CAT_0':'tdi_ef_4_ano', 'FUN_05_CAT_0':'tdi_ef_5_ano', 'FUN_06_CAT_0':'tdi_ef_6_ano',
              'FUN_07_CAT_0':'tdi_ef_7_ano', 'FUN_08_CAT_0':'tdi_ef_8_ano', 'FUN_09_CAT_0':'tdi_ef_9_ano',
              'MED_CAT_0':'tdi_em', 'MED_01_CAT_0':'tdi_em_1_ano', 'MED_02_CAT_0':'tdi_em_2_ano',
              'MED_03_CAT_0':'tdi_em_3_ano', 'MED_04_CAT_0':'tdi_em_4_ano'}              