select
    safe_cast(country_iso3_code as string) country_iso3_code,
    safe_cast(country_id as string) country_id,
    safe_cast(population_id as string) population_id,
    safe_cast(standardized_grade_id as string) standardized_grade_id,
    safe_cast(grade_id as string) grade_id,
    safe_cast(student_wave_indicator as string) student_wave_indicator,
    safe_cast(school_id as string) school_id,
    safe_cast(class_id as string) class_id,
    safe_cast(student_id as string) student_id,
    safe_cast(sex_student as string) sex_student,
    safe_cast(test_administrator_position as string) test_administrator_position,
    safe_cast(locale_student_test_id as string) locale_student_test_id,
    safe_cast(
        language_student_achievement_test as string
    ) language_student_achievement_test,
    safe_cast(
        language_student_achievement_questionnaire as string
    ) language_student_achievement_questionnaire,
    safe_cast(
        locale_student_questionnaire_id as string
    ) locale_student_questionnaire_id,
    safe_cast(booklet_id as string) booklet_id,
    safe_cast(asbg01 as string) asbg01,
    safe_cast(asbg03 as string) asbg03,
    safe_cast(asbg04 as string) asbg04,
    safe_cast(asbg05a as bool) asbg05a,
    safe_cast(asbg05b as bool) asbg05b,
    safe_cast(asbg05c as bool) asbg05c,
    safe_cast(asbg05d as bool) asbg05d,
    safe_cast(asbg05e as bool) asbg05e,
    safe_cast(asbg05f as bool) asbg05f,
    safe_cast(asbg05g as bool) asbg05g,
    safe_cast(asbg05h as bool) asbg05h,
    safe_cast(asbg05i as bool) asbg05i,
    safe_cast(asbg05j as bool) asbg05j,
    safe_cast(asbg05k as bool) asbg05k,
    safe_cast(asbg06 as string) asbg06,
    safe_cast(asbg07a as string) asbg07a,
    safe_cast(asbg07b as string) asbg07b,
    safe_cast(asbg08a as string) asbg08a,
    safe_cast(asbg08b as string) asbg08b,
    safe_cast(asbg09a as string) asbg09a,
    safe_cast(asbg09b as string) asbg09b,
    safe_cast(asbg09c as string) asbg09c,
    safe_cast(asbg09d as string) asbg09d,
    safe_cast(asbg09e as string) asbg09e,
    safe_cast(asbg09f as string) asbg09f,
    safe_cast(asbg09g as string) asbg09g,
    safe_cast(asbg09h as string) asbg09h,
    safe_cast(asbg10a as string) asbg10a,
    safe_cast(asbg10b as string) asbg10b,
    safe_cast(asbg10c as string) asbg10c,
    safe_cast(asbg10d as string) asbg10d,
    safe_cast(asbg10e as string) asbg10e,
    safe_cast(asbg10f as string) asbg10f,
    safe_cast(asbg11a as string) asbg11a,
    safe_cast(asbg11b as string) asbg11b,
    safe_cast(asbg11c as string) asbg11c,
    safe_cast(asbg11d as string) asbg11d,
    safe_cast(asbg11e as string) asbg11e,
    safe_cast(asbg11f as string) asbg11f,
    safe_cast(asbg11g as string) asbg11g,
    safe_cast(asbg11h as string) asbg11h,
    safe_cast(asbg11i as string) asbg11i,
    safe_cast(asbg11j as string) asbg11j,
    safe_cast(asbr01a as string) asbr01a,
    safe_cast(asbr01b as string) asbr01b,
    safe_cast(asbr01c as string) asbr01c,
    safe_cast(asbr01d as string) asbr01d,
    safe_cast(asbr01e as string) asbr01e,
    safe_cast(asbr01f as string) asbr01f,
    safe_cast(asbr01g as string) asbr01g,
    safe_cast(asbr01h as string) asbr01h,
    safe_cast(asbr01i as string) asbr01i,
    safe_cast(asbr02a as string) asbr02a,
    safe_cast(asbr02b as string) asbr02b,
    safe_cast(asbr02c as string) asbr02c,
    safe_cast(asbr02d as string) asbr02d,
    safe_cast(asbr02e as string) asbr02e,
    safe_cast(asbr03a as string) asbr03a,
    safe_cast(asbr03b as string) asbr03b,
    safe_cast(asbr03c as string) asbr03c,
    safe_cast(asbr04 as string) asbr04,
    safe_cast(asbr05 as string) asbr05,
    safe_cast(asbr06a as string) asbr06a,
    safe_cast(asbr06b as string) asbr06b,
    safe_cast(asbr07a as string) asbr07a,
    safe_cast(asbr07b as string) asbr07b,
    safe_cast(asbr07c as string) asbr07c,
    safe_cast(asbr07d as string) asbr07d,
    safe_cast(asbr07e as string) asbr07e,
    safe_cast(asbr07f as string) asbr07f,
    safe_cast(asbr07g as string) asbr07g,
    safe_cast(asbr07h as string) asbr07h,
    safe_cast(asbr08a as string) asbr08a,
    safe_cast(asbr08b as string) asbr08b,
    safe_cast(asbr08c as string) asbr08c,
    safe_cast(asbr08d as string) asbr08d,
    safe_cast(asbr08e as string) asbr08e,
    safe_cast(asbr08f as string) asbr08f,
    safe_cast(asdage as float64) asdage,
    safe_cast(houwgt as float64) houwgt,
    safe_cast(totwgt as float64) totwgt,
    safe_cast(senwgt as float64) senwgt,
    safe_cast(wgtadj1 as float64) wgtadj1,
    safe_cast(wgtadj2 as float64) wgtadj2,
    safe_cast(wgtadj3 as float64) wgtadj3,
    safe_cast(wgtfac1 as float64) wgtfac1,
    safe_cast(wgtfac2 as float64) wgtfac2,
    safe_cast(wgtfac3 as float64) wgtfac3,
    safe_cast(jkrep as string) jkrep,
    safe_cast(jkzone as string) jkzone,
    safe_cast(asrrea01 as float64) asrrea01,
    safe_cast(asrrea02 as float64) asrrea02,
    safe_cast(asrrea03 as float64) asrrea03,
    safe_cast(asrrea04 as float64) asrrea04,
    safe_cast(asrrea05 as float64) asrrea05,
    safe_cast(asrlit01 as float64) asrlit01,
    safe_cast(asrlit02 as float64) asrlit02,
    safe_cast(asrlit03 as float64) asrlit03,
    safe_cast(asrlit04 as float64) asrlit04,
    safe_cast(asrlit05 as float64) asrlit05,
    safe_cast(asrinf01 as float64) asrinf01,
    safe_cast(asrinf02 as float64) asrinf02,
    safe_cast(asrinf03 as float64) asrinf03,
    safe_cast(asrinf04 as float64) asrinf04,
    safe_cast(asrinf05 as float64) asrinf05,
    safe_cast(asriie01 as float64) asriie01,
    safe_cast(asriie02 as float64) asriie02,
    safe_cast(asriie03 as float64) asriie03,
    safe_cast(asriie04 as float64) asriie04,
    safe_cast(asriie05 as float64) asriie05,
    safe_cast(asrrsi01 as float64) asrrsi01,
    safe_cast(asrrsi02 as float64) asrrsi02,
    safe_cast(asrrsi03 as float64) asrrsi03,
    safe_cast(asrrsi04 as float64) asrrsi04,
    safe_cast(asrrsi05 as float64) asrrsi05,
    safe_cast(asribm01 as string) asribm01,
    safe_cast(asribm02 as string) asribm02,
    safe_cast(asribm03 as string) asribm03,
    safe_cast(asribm04 as string) asribm04,
    safe_cast(asribm05 as string) asribm05,
    safe_cast(asbgsec as float64) asbgsec,
    safe_cast(asdgsec as string) asdgsec,
    safe_cast(asbgssb as float64) asbgssb,
    safe_cast(asdgssb as string) asdgssb,
    safe_cast(asbgsb as float64) asbgsb,
    safe_cast(asdgsb as string) asdgsb,
    safe_cast(asbgerl as float64) asbgerl,
    safe_cast(asdgerl as string) asdgerl,
    safe_cast(asbgdrl as float64) asbgdrl,
    safe_cast(asdgdrl as string) asdgdrl,
    safe_cast(asbgslr as float64) asbgslr,
    safe_cast(asdgslr as string) asdgslr,
    safe_cast(asbghrl as float64) asbghrl,
    safe_cast(asdghrl as string) asdghrl,
    safe_cast(asbgscr as float64) asbgscr,
    safe_cast(asdgscr as string) asdgscr,
    safe_cast(asdg05s as string) asdg05s,
    safe_cast(asdrlowp as bool) asdrlowp,
    safe_cast(version as string) version,
    safe_cast(scope as string) scope,
    safe_cast(pirls_type as string) pirls_type,
from `basedosdados-dev.world_iea_pirls_staging.student_context` as t
