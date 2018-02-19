pro old
  t1='2016-01-19 21:40:02'
  t2='2016-01-19 21:57:58'
  timespan, [t1, t2]
  init_crib_colors
  mvn_sta_l2_load
  mvn_swe_load_l2, /all
  mvn_swe_sumplot
  mvn_sta_l2_tplot
  mvn_swe_n1d
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
  store_data, 'nions', data=['np','nh2','nhe','nhe2','no','no2','nco2']
  options, 'nions', colors=['o','r','g','b','o','r','g','b'],labels=['np','nh2','nhe','nhe2','no','no2','nco2'], labflag=2,ytitle='density, [cm-3]', yrange=[0.01, 1000], ylog=1, xticklen=1, yticklen=1
  calc,"'n'='np'+'nh2'+'nhe'+'nhe2'+'no'+'no2'+'nco2'+'n?'"
  store_data, 'nall', data=['n', 'mvn_swe_spec_dens']
  options, 'nall', colors=['o','r'],labels=['n_ions','n_e'], labflag=2,ytitle='total ions and e density, [cm-3]', yrange=[0.01, 1000], ylog=1, xticklen=1, yticklen=1
  tplot, ['nions', 'nall']
  makepng, 'den+temp', /timetag
  end