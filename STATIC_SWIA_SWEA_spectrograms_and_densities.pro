pro STATIC_SWIA_SWEA_spectrograms_and_densities
  init_crib_colors
  
  t1='2016-01-20/02:10:00'
  t2='2016-01-20/02:28:00'
  timespan, [t1, t2]
  
  mvn_sta_l2_load
  mvn_sta_l2_tplot
  
  mvn_swe_load_l2, /all
  mvn_scpot
  mvn_swe_sumplot
  mvn_lpw_load_l2, ['lpnt'],trange=[t1,t2], /noTPLOT
  mvn_swia_load_l2_data,/loadall,/tplot,/eflux
  
  ;tplot,['swe_a4','mvn_swe_spec_dens']
  ;---------------------------------------------
  ;p+  m=1,04383
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[0.5,1.4]
  calc, "'np'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ; H2+ m=2,13344
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[1.8,2.4]
  calc, "'nh2'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;He+  m=4,48742
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[4,5]
  calc, "'nhe'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;He2+  m=9,10292
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[8,10]
  calc, "'nhe2'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;O+  m=16,8944
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[16,17.5]
  calc, "'no'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;O2+
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[31,32]
  calc, "'no2'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;CO2+  m=45,7374
  ;---------------------------------------------
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[42,49]
  calc, "'nco2'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;????  m=74,8438
  ;---------------------------------------------
;  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[70,80]
;  calc, "'n?'='n_4d_mvn_sta_get_d1'"
  ;---------------------------------------------
  ;e-
  ;---------------------------------------------
  mvn_swe_n1d
  ;---------------------------------------------
  ;all
  ;---------------------------------------------

  store_data, 'nions', data=['np','no','no2']
  options, 'nions', colors=['o','r','g','b','o','r','g','b'],labels=['n_p','n_O','n_O2'], labflag=2,ytitle='density, [cm-3]', yrange=[0.01, 1000], ylog=1, xticklen=1, yticklen=1
  calc,"'n'='np'+'no'+'no2'"
  mvn_lpw_load_l2, ['lpnt'],trange=[t1,t2], /noTPLOT
  store_data, 'nall', data=['n', 'mvn_swe_spec_dens', 'mvn_swim_density', 'mvn_lpw_lp_ne_l2']
  options, 'nall', colors=['o','r','b', 'g'],labels=['n_STATIC','n_SWEA','n_SWIA', 'n_LPW'], labflag=2,ytitle='densities, [cm-3]', yrange=[0.01, 1000], ylog=1, xticklen=1, yticklen=1
  tplot, ['mvn_sta_c0_E', 'mvn_swics_en_eflux', 'swe_a4', 'nions', 'nall']

  ;makepng, 'C:\Users\Vladimir\Desktop\densities', window = 0, /timetag
  end