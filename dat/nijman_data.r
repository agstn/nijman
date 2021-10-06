pacman::p_load(tidyverse, rio) 
pacman::p_load(labelled)

# Risk factors for in-hospital mortality in laboratory-confirmed COVID-19 patients 
# in the Netherlands: A competing risk survival analysis
# https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0249231

nijman_data <- import("C:/R/Wonderful-Wednesdays/2021-09-08/dat/journal.pone.0249231.s004.csv") %>% 
   mutate(sex = as.factor(sex),
          status = factor(status, labels = c('censored','died','recovered')) )

nijman_data <- nijman_data %>% 
        mutate(across(c(starts_with('adm_'),-adm_anticoag,-adm_ace_arb), ~log1p(.x), .names = "{.col}_log1p"))

var_label(nijman_data) <- 
   list(age = 'Age (years)',
        sex = 'Sex',
        bmi = 'BMI',
        comorb_dm = 'Diabetes Mellitus',
        comorb_cvd = 'Cardiovascular Disease',
        comorb_cvd_hypertension = 'Cardiovascular (incl. hypertension)',
        comorb_pulm_dis = 'Pulmonary disease',
        immunocompromised = 'Immunocompromised',
        adm_anticoag  = 'Chronic use of anticoagulant',
        adm_ace_arb = 'Chronic use of ACE inhibitors and/or angitensin II receptors',
        
        xray_new = 'Chest X-Ray',
        ct_sevscore_total  = 'CT scan severity score',
        sympt_duration = 'Symptom duration (days)',
        sympt_fever = 'Symptoms, fever',
        sympt_dyspnea = 'Symptoms, dyspnea',
        mews = 'Modified Early Warning Score (MEWS)',
        
        adm_neutrotolymphorate = 'Neutrophil-to-lymphocyte rate',
        adm_ldh  = 'Lactate dehydrogenase (U/L)', 
        adm_creat         = 'Creatinine (umol/L)',
        adm_procalcitonin = 'Procalcitonin (ug/L)',
        adm_crp      = 'C-REactive Protein (mg/L)',
        adm_ferritin = 'Ferritin (ug/L)',
        adm_ddimer_new = 'D-dimer (ng/L)',
        
        adm_neutrotolymphorate_log1p = 'Neutrophil-to-lymphocyte rate',
        adm_ldh_log1p  = 'Lactate dehydrogenase (U/L)', 
        adm_creat_log1p         = 'Creatinine (umol/L)',
        adm_procalcitonin_log1p = 'Procalcitonin (ug/L)',
        adm_crp_log1p      = 'C-REactive Protein (mg/L)',
        adm_ferritin_log1p = 'Ferritin (ug/L)',
        adm_ddimer_new_log1p = 'D-dimer (ng/L)',
        
        ftime = 'Duration of hospital admission (days)',
        status = 'Patient status at end of follow-up')

rio::export(nijman_data, "C:/R/Wonderful-Wednesdays/2021-09-08/dat/nijman_data.rds")
