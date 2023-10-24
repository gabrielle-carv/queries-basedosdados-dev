{{ config(
    alias='rendimentos_outras_fontes',
    schema='br_ibge_pnadc',
    materialized='table',
    partition_by={
    "field": "ano",
    "data_type": "int64",
    "range": {
        "start": 2012,
        "end": 2022,
        "interval": 1}
    },
    cluster_by = "sigla_uf",
    labels = {'project_id': 'basedosdados-dev'})
}}
SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(trimestre AS INT64) trimestre,
SAFE_CAST(id_uf AS STRING) id_uf,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(CASE WHEN capital IS NULL THEN id_uf ELSE capital END AS STRING) capital,
SAFE_CAST(CASE WHEN id_uf IN ('13','15','16','21','22','23','24','25','26','27','28','29','31','32','33','35','41','42','43','51','52') THEN id_uf ELSE NULL END AS STRING) rm_ride,
SAFE_CAST(id_upa AS STRING) id_upa,
SAFE_CAST(id_estrato AS STRING) id_estrato,
SAFE_CAST(id_domicilio AS STRING) id_domicilio,
SAFE_CAST(id_pessoa AS STRING) id_pessoa,
SAFE_CAST(V1008 AS STRING) V1008,
SAFE_CAST(V1014 AS STRING) V1014,
SAFE_CAST(V1022 AS STRING) V1022,
SAFE_CAST(V1023 AS STRING) V1023,
SAFE_CAST(V1030 AS INT64) V1030,
SAFE_CAST(V1031 AS FLOAT64) V1031,
SAFE_CAST(V1032 AS FLOAT64) V1032,
SAFE_CAST(V1034 AS INT64) V1034,
SAFE_CAST(posest AS STRING) posest,
SAFE_CAST(posest_sxi AS STRING) posest_sxi,
SAFE_CAST(V2001 AS INT64) V2001,
SAFE_CAST(V2003 AS INT64) V2003,
SAFE_CAST(V5001 AS STRING) V5001,
SAFE_CAST(V50011 AS STRING) V50011,
SAFE_CAST(V500111 AS FLOAT64) V500111,
SAFE_CAST(V5002 AS STRING) V5002,
SAFE_CAST(V50021 AS STRING) V50021,
SAFE_CAST(V500211 AS FLOAT64) V500211,
SAFE_CAST(V5003 AS STRING) V5003,
SAFE_CAST(V50031 AS STRING) V50031,
SAFE_CAST(V500311 AS FLOAT64) V500311,
SAFE_CAST(V5004 AS STRING) V5004,
SAFE_CAST(V50041 AS STRING) V50041,
SAFE_CAST(V500411 AS FLOAT64) V500411,
SAFE_CAST(V5005 AS STRING) V5005,
SAFE_CAST(V50051 AS STRING) V50051,
SAFE_CAST(V500511 AS FLOAT64) V500511,
SAFE_CAST(V5006 AS STRING) V5006,
SAFE_CAST(V50061 AS STRING) V50061,
SAFE_CAST(V500611 AS FLOAT64) V500611,
SAFE_CAST(V5007 AS STRING) V5007,
SAFE_CAST(V50071 AS STRING) V50071,
SAFE_CAST(V500711 AS FLOAT64) V500711,
SAFE_CAST(V5008 AS STRING) V5008,
SAFE_CAST(V50081 AS STRING) V50081,
SAFE_CAST(V500811 AS FLOAT64) V500811,
SAFE_CAST(V5009 AS STRING) V5009,
SAFE_CAST(V50091 AS STRING) V50091,
SAFE_CAST(V500911 AS FLOAT64) V500911,
SAFE_CAST(V5010 AS STRING) V5010,
SAFE_CAST(V50101 AS STRING) V50101,
SAFE_CAST(V501011 AS FLOAT64) V501011,
SAFE_CAST(V5011 AS STRING) V5011,
SAFE_CAST(V50111 AS STRING) V50111,
SAFE_CAST(V501111 AS FLOAT64) V501111,
SAFE_CAST(V5012 AS STRING) V5012,
SAFE_CAST(V50121 AS STRING) V50121,
SAFE_CAST(V501211 AS FLOAT64) V501211,
SAFE_CAST(V5013 AS STRING) V5013,
SAFE_CAST(V50131 AS STRING) V50131,
SAFE_CAST(V501311 AS FLOAT64) V501311,
SAFE_CAST(V5001A AS STRING) V5001A,
SAFE_CAST(V5001A2 AS FLOAT64) V5001A2,
SAFE_CAST(V5002A AS STRING) V5002A,
SAFE_CAST(V5002A2 AS FLOAT64) V5002A2,
SAFE_CAST(V5003A AS STRING) V5003A,
SAFE_CAST(V5003A2 AS FLOAT64) V5003A2,
SAFE_CAST(V5004A AS STRING) V5004A,
SAFE_CAST(V5004A2 AS FLOAT64) V5004A2,
SAFE_CAST(V5005A AS STRING) V5005A,
SAFE_CAST(V5005A2 AS FLOAT64) V5005A2,
SAFE_CAST(V5006A AS STRING) V5006A,
SAFE_CAST(V5006A2 AS FLOAT64) V5006A2,
SAFE_CAST(V5007A AS STRING) V5007A,
SAFE_CAST(V5007A2 AS FLOAT64) V5007A2,
SAFE_CAST(V5008A AS STRING) V5008A,
SAFE_CAST(V5008A2 AS FLOAT64) V5008A2,
SAFE_CAST(VD4046 AS FLOAT64) VD4046,
SAFE_CAST(VD4047 AS FLOAT64) VD4047,
SAFE_CAST(VD4048 AS FLOAT64) VD4048,
SAFE_CAST(VD4052 AS FLOAT64) VD4052,
SAFE_CAST(VD5001 AS FLOAT64) VD5001,
SAFE_CAST(VD5002 AS FLOAT64) VD5002,
SAFE_CAST(VD5003 AS STRING) VD5003,
SAFE_CAST(VD5004 AS FLOAT64) VD5004,
SAFE_CAST(VD5005 AS FLOAT64) VD5005,
SAFE_CAST(VD5006 AS STRING) VD5006,
SAFE_CAST(VD5007 AS FLOAT64) VD5007,
SAFE_CAST(VD5008 AS FLOAT64) VD5008,
SAFE_CAST(VD5009 AS STRING) VD5009,
SAFE_CAST(VD5010 AS FLOAT64) VD5010,
SAFE_CAST(VD5011 AS FLOAT64) VD5011,
SAFE_CAST(VD5012 AS STRING) VD5012,
SAFE_CAST(V1032001 AS FLOAT64) V1032001,
SAFE_CAST(V1032002 AS FLOAT64) V1032002,
SAFE_CAST(V1032003 AS FLOAT64) V1032003,
SAFE_CAST(V1032004 AS FLOAT64) V1032004,
SAFE_CAST(V1032005 AS FLOAT64) V1032005,
SAFE_CAST(V1032006 AS FLOAT64) V1032006,
SAFE_CAST(V1032007 AS FLOAT64) V1032007,
SAFE_CAST(V1032008 AS FLOAT64) V1032008,
SAFE_CAST(V1032009 AS FLOAT64) V1032009,
SAFE_CAST(V1032010 AS FLOAT64) V1032010,
SAFE_CAST(V1032011 AS FLOAT64) V1032011,
SAFE_CAST(V1032012 AS FLOAT64) V1032012,
SAFE_CAST(V1032013 AS FLOAT64) V1032013,
SAFE_CAST(V1032014 AS FLOAT64) V1032014,
SAFE_CAST(V1032015 AS FLOAT64) V1032015,
SAFE_CAST(V1032016 AS FLOAT64) V1032016,
SAFE_CAST(V1032017 AS FLOAT64) V1032017,
SAFE_CAST(V1032018 AS FLOAT64) V1032018,
SAFE_CAST(V1032019 AS FLOAT64) V1032019,
SAFE_CAST(V1032020 AS FLOAT64) V1032020,
SAFE_CAST(V1032021 AS FLOAT64) V1032021,
SAFE_CAST(V1032022 AS FLOAT64) V1032022,
SAFE_CAST(V1032023 AS FLOAT64) V1032023,
SAFE_CAST(V1032024 AS FLOAT64) V1032024,
SAFE_CAST(V1032025 AS FLOAT64) V1032025,
SAFE_CAST(V1032026 AS FLOAT64) V1032026,
SAFE_CAST(V1032027 AS FLOAT64) V1032027,
SAFE_CAST(V1032028 AS FLOAT64) V1032028,
SAFE_CAST(V1032029 AS FLOAT64) V1032029,
SAFE_CAST(V1032030 AS FLOAT64) V1032030,
SAFE_CAST(V1032031 AS FLOAT64) V1032031,
SAFE_CAST(V1032032 AS FLOAT64) V1032032,
SAFE_CAST(V1032033 AS FLOAT64) V1032033,
SAFE_CAST(V1032034 AS FLOAT64) V1032034,
SAFE_CAST(V1032035 AS FLOAT64) V1032035,
SAFE_CAST(V1032036 AS FLOAT64) V1032036,
SAFE_CAST(V1032037 AS FLOAT64) V1032037,
SAFE_CAST(V1032038 AS FLOAT64) V1032038,
SAFE_CAST(V1032039 AS FLOAT64) V1032039,
SAFE_CAST(V1032040 AS FLOAT64) V1032040,
SAFE_CAST(V1032041 AS FLOAT64) V1032041,
SAFE_CAST(V1032042 AS FLOAT64) V1032042,
SAFE_CAST(V1032043 AS FLOAT64) V1032043,
SAFE_CAST(V1032044 AS FLOAT64) V1032044,
SAFE_CAST(V1032045 AS FLOAT64) V1032045,
SAFE_CAST(V1032046 AS FLOAT64) V1032046,
SAFE_CAST(V1032047 AS FLOAT64) V1032047,
SAFE_CAST(V1032048 AS FLOAT64) V1032048,
SAFE_CAST(V1032049 AS FLOAT64) V1032049,
SAFE_CAST(V1032050 AS FLOAT64) V1032050,
SAFE_CAST(V1032051 AS FLOAT64) V1032051,
SAFE_CAST(V1032052 AS FLOAT64) V1032052,
SAFE_CAST(V1032053 AS FLOAT64) V1032053,
SAFE_CAST(V1032054 AS FLOAT64) V1032054,
SAFE_CAST(V1032055 AS FLOAT64) V1032055,
SAFE_CAST(V1032056 AS FLOAT64) V1032056,
SAFE_CAST(V1032057 AS FLOAT64) V1032057,
SAFE_CAST(V1032058 AS FLOAT64) V1032058,
SAFE_CAST(V1032059 AS FLOAT64) V1032059,
SAFE_CAST(V1032060 AS FLOAT64) V1032060,
SAFE_CAST(V1032061 AS FLOAT64) V1032061,
SAFE_CAST(V1032062 AS FLOAT64) V1032062,
SAFE_CAST(V1032063 AS FLOAT64) V1032063,
SAFE_CAST(V1032064 AS FLOAT64) V1032064,
SAFE_CAST(V1032065 AS FLOAT64) V1032065,
SAFE_CAST(V1032066 AS FLOAT64) V1032066,
SAFE_CAST(V1032067 AS FLOAT64) V1032067,
SAFE_CAST(V1032068 AS FLOAT64) V1032068,
SAFE_CAST(V1032069 AS FLOAT64) V1032069,
SAFE_CAST(V1032070 AS FLOAT64) V1032070,
SAFE_CAST(V1032071 AS FLOAT64) V1032071,
SAFE_CAST(V1032072 AS FLOAT64) V1032072,
SAFE_CAST(V1032073 AS FLOAT64) V1032073,
SAFE_CAST(V1032074 AS FLOAT64) V1032074,
SAFE_CAST(V1032075 AS FLOAT64) V1032075,
SAFE_CAST(V1032076 AS FLOAT64) V1032076,
SAFE_CAST(V1032077 AS FLOAT64) V1032077,
SAFE_CAST(V1032078 AS FLOAT64) V1032078,
SAFE_CAST(V1032079 AS FLOAT64) V1032079,
SAFE_CAST(V1032080 AS FLOAT64) V1032080,
SAFE_CAST(V1032081 AS FLOAT64) V1032081,
SAFE_CAST(V1032082 AS FLOAT64) V1032082,
SAFE_CAST(V1032083 AS FLOAT64) V1032083,
SAFE_CAST(V1032084 AS FLOAT64) V1032084,
SAFE_CAST(V1032085 AS FLOAT64) V1032085,
SAFE_CAST(V1032086 AS FLOAT64) V1032086,
SAFE_CAST(V1032087 AS FLOAT64) V1032087,
SAFE_CAST(V1032088 AS FLOAT64) V1032088,
SAFE_CAST(V1032089 AS FLOAT64) V1032089,
SAFE_CAST(V1032090 AS FLOAT64) V1032090,
SAFE_CAST(V1032091 AS FLOAT64) V1032091,
SAFE_CAST(V1032092 AS FLOAT64) V1032092,
SAFE_CAST(V1032093 AS FLOAT64) V1032093,
SAFE_CAST(V1032094 AS FLOAT64) V1032094,
SAFE_CAST(V1032095 AS FLOAT64) V1032095,
SAFE_CAST(V1032096 AS FLOAT64) V1032096,
SAFE_CAST(V1032097 AS FLOAT64) V1032097,
SAFE_CAST(V1032098 AS FLOAT64) V1032098,
SAFE_CAST(V1032099 AS FLOAT64) V1032099,
SAFE_CAST(V1032100 AS FLOAT64) V1032100,
SAFE_CAST(V1032101 AS FLOAT64) V1032101,
SAFE_CAST(V1032102 AS FLOAT64) V1032102,
SAFE_CAST(V1032103 AS FLOAT64) V1032103,
SAFE_CAST(V1032104 AS FLOAT64) V1032104,
SAFE_CAST(V1032105 AS FLOAT64) V1032105,
SAFE_CAST(V1032106 AS FLOAT64) V1032106,
SAFE_CAST(V1032107 AS FLOAT64) V1032107,
SAFE_CAST(V1032108 AS FLOAT64) V1032108,
SAFE_CAST(V1032109 AS FLOAT64) V1032109,
SAFE_CAST(V1032110 AS FLOAT64) V1032110,
SAFE_CAST(V1032111 AS FLOAT64) V1032111,
SAFE_CAST(V1032112 AS FLOAT64) V1032112,
SAFE_CAST(V1032113 AS FLOAT64) V1032113,
SAFE_CAST(V1032114 AS FLOAT64) V1032114,
SAFE_CAST(V1032115 AS FLOAT64) V1032115,
SAFE_CAST(V1032116 AS FLOAT64) V1032116,
SAFE_CAST(V1032117 AS FLOAT64) V1032117,
SAFE_CAST(V1032118 AS FLOAT64) V1032118,
SAFE_CAST(V1032119 AS FLOAT64) V1032119,
SAFE_CAST(V1032120 AS FLOAT64) V1032120,
SAFE_CAST(V1032121 AS FLOAT64) V1032121,
SAFE_CAST(V1032122 AS FLOAT64) V1032122,
SAFE_CAST(V1032123 AS FLOAT64) V1032123,
SAFE_CAST(V1032124 AS FLOAT64) V1032124,
SAFE_CAST(V1032125 AS FLOAT64) V1032125,
SAFE_CAST(V1032126 AS FLOAT64) V1032126,
SAFE_CAST(V1032127 AS FLOAT64) V1032127,
SAFE_CAST(V1032128 AS FLOAT64) V1032128,
SAFE_CAST(V1032129 AS FLOAT64) V1032129,
SAFE_CAST(V1032130 AS FLOAT64) V1032130,
SAFE_CAST(V1032131 AS FLOAT64) V1032131,
SAFE_CAST(V1032132 AS FLOAT64) V1032132,
SAFE_CAST(V1032133 AS FLOAT64) V1032133,
SAFE_CAST(V1032134 AS FLOAT64) V1032134,
SAFE_CAST(V1032135 AS FLOAT64) V1032135,
SAFE_CAST(V1032136 AS FLOAT64) V1032136,
SAFE_CAST(V1032137 AS FLOAT64) V1032137,
SAFE_CAST(V1032138 AS FLOAT64) V1032138,
SAFE_CAST(V1032139 AS FLOAT64) V1032139,
SAFE_CAST(V1032140 AS FLOAT64) V1032140,
SAFE_CAST(V1032141 AS FLOAT64) V1032141,
SAFE_CAST(V1032142 AS FLOAT64) V1032142,
SAFE_CAST(V1032143 AS FLOAT64) V1032143,
SAFE_CAST(V1032144 AS FLOAT64) V1032144,
SAFE_CAST(V1032145 AS FLOAT64) V1032145,
SAFE_CAST(V1032146 AS FLOAT64) V1032146,
SAFE_CAST(V1032147 AS FLOAT64) V1032147,
SAFE_CAST(V1032148 AS FLOAT64) V1032148,
SAFE_CAST(V1032149 AS FLOAT64) V1032149,
SAFE_CAST(V1032150 AS FLOAT64) V1032150,
SAFE_CAST(V1032151 AS FLOAT64) V1032151,
SAFE_CAST(V1032152 AS FLOAT64) V1032152,
SAFE_CAST(V1032153 AS FLOAT64) V1032153,
SAFE_CAST(V1032154 AS FLOAT64) V1032154,
SAFE_CAST(V1032155 AS FLOAT64) V1032155,
SAFE_CAST(V1032156 AS FLOAT64) V1032156,
SAFE_CAST(V1032157 AS FLOAT64) V1032157,
SAFE_CAST(V1032158 AS FLOAT64) V1032158,
SAFE_CAST(V1032159 AS FLOAT64) V1032159,
SAFE_CAST(V1032160 AS FLOAT64) V1032160,
SAFE_CAST(V1032161 AS FLOAT64) V1032161,
SAFE_CAST(V1032162 AS FLOAT64) V1032162,
SAFE_CAST(V1032163 AS FLOAT64) V1032163,
SAFE_CAST(V1032164 AS FLOAT64) V1032164,
SAFE_CAST(V1032165 AS FLOAT64) V1032165,
SAFE_CAST(V1032166 AS FLOAT64) V1032166,
SAFE_CAST(V1032167 AS FLOAT64) V1032167,
SAFE_CAST(V1032168 AS FLOAT64) V1032168,
SAFE_CAST(V1032169 AS FLOAT64) V1032169,
SAFE_CAST(V1032170 AS FLOAT64) V1032170,
SAFE_CAST(V1032171 AS FLOAT64) V1032171,
SAFE_CAST(V1032172 AS FLOAT64) V1032172,
SAFE_CAST(V1032173 AS FLOAT64) V1032173,
SAFE_CAST(V1032174 AS FLOAT64) V1032174,
SAFE_CAST(V1032175 AS FLOAT64) V1032175,
SAFE_CAST(V1032176 AS FLOAT64) V1032176,
SAFE_CAST(V1032177 AS FLOAT64) V1032177,
SAFE_CAST(V1032178 AS FLOAT64) V1032178,
SAFE_CAST(V1032179 AS FLOAT64) V1032179,
SAFE_CAST(V1032180 AS FLOAT64) V1032180,
SAFE_CAST(V1032181 AS FLOAT64) V1032181,
SAFE_CAST(V1032182 AS FLOAT64) V1032182,
SAFE_CAST(V1032183 AS FLOAT64) V1032183,
SAFE_CAST(V1032184 AS FLOAT64) V1032184,
SAFE_CAST(V1032185 AS FLOAT64) V1032185,
SAFE_CAST(V1032186 AS FLOAT64) V1032186,
SAFE_CAST(V1032187 AS FLOAT64) V1032187,
SAFE_CAST(V1032188 AS FLOAT64) V1032188,
SAFE_CAST(V1032189 AS FLOAT64) V1032189,
SAFE_CAST(V1032190 AS FLOAT64) V1032190,
SAFE_CAST(V1032191 AS FLOAT64) V1032191,
SAFE_CAST(V1032192 AS FLOAT64) V1032192,
SAFE_CAST(V1032193 AS FLOAT64) V1032193,
SAFE_CAST(V1032194 AS FLOAT64) V1032194,
SAFE_CAST(V1032195 AS FLOAT64) V1032195,
SAFE_CAST(V1032196 AS FLOAT64) V1032196,
SAFE_CAST(V1032197 AS FLOAT64) V1032197,
SAFE_CAST(V1032198 AS FLOAT64) V1032198,
SAFE_CAST(V1032199 AS FLOAT64) V1032199,
SAFE_CAST(V1032200 AS FLOAT64) V1032200
FROM basedosdados-dev.br_ibge_pnadc_staging.rendimentos_outras_fontes AS t