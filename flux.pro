pro flux
  timespan, ['2016-01-31 08:52:40', '2016-01-31 08:56:35']
  mvn_sta_l2_load                                                                                   ;включать с новой сессии
  mvn_sta_l2_tplot
  cd, 'D:\MAVEN\data\maven\data\sci\sta\l2\2016\01', current=c
  id = cdf_open('mvn_sta_l2_d1-32e4d16a8m_20160131_v01.cdf')
  cdf_control, id, get_var_info=info, variable='pos_sc_mso'
  cdf_varget, id, 'pos_sc_mso', xyz, rec_count=info.maxrec
  cdf_control, id, get_var_info=inf, variable='time_unix'
  cdf_varget, id, 'time_unix', time, rec_count=inf.maxrec
  ;a1
  a1=dblarr(4,n_elements(time))
  a1[0,*]=time
  a1[1,*]=xyz[0,*]
  a1[2,*]=xyz[1,*]
  a1[3,*]=xyz[2,*]
  
  ;a2
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[0,3]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[0,3]
  split_vec, 'v_4d_mvn_sta_get_d1'
  calc, "'np'='n_4d_mvn_sta_get_d1'"
  calc, "'Vp'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  get_data,'np', t, d1
  get_data,'Vp', t, d2
  a2=dblarr(3,n_elements(t))
  a2[0,*]=t
  a2[1,*]=d1
  a2[2,*]=d2
  s=0 
  poisk=dblarr(6, n_elements(a1[0,*]))
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a2[0,*])-1 do begin
      if a1[0, j] eq a2[0, l] then begin
        s=s+1
      endif
    endfor
  endfor
  corr=dblarr(6, s)
  s=0
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a2[0,*])-1 do begin
      if a1[0, j] eq a2[0, l] then begin
        corr[0,s]=a1[0,j]
        corr[1,s]=a1[1,j]
        corr[2,s]=a1[2,j]
        corr[3,s]=a1[3,j]
        corr[4,s]=a2[1,l]
        corr[5,s]=a2[2,l]
        s=s+1
      endif
    endfor
  endfor
  tran=transpose(corr)
  arr5=dblarr(n_elements(corr))
  arr5=sqrt(corr[1,*]*corr[1,*]+corr[2,*]*corr[2,*]+corr[3,*]*corr[3,*])
  arr6=dblarr(n_elements(corr))
  arr7=dblarr(n_elements(corr))
  arr7=shift(arr5,-1)    ;сдвиг на -1
  arr6=sqrt((arr7-arr5)^2)
  arr8=transpose(arr6)
  store_data, 'pos_x', data ={x:tran[*,0], y:tran[*,1]}
  store_data, 'pos_y', data ={x:tran[*,0], y:tran[*,2]}
  store_data, 'pos_z', data ={x:tran[*,0], y:tran[*,3]}
  calc, "'|pos|'=sqrt('pos_x'^2+'pos_y'^2+'pos_z'^2)-3390"
  store_data, 'dh', data={x:tran[*,0], y:arr8[*,0]}
;  store_data, 'np', data ={x:tran[*,0], y:tran[*,4]}
;  store_data, 'Vp', data ={x:tran[*,0], y:tran[*,5]}
  calc, "'xn'=('pos_z'+('pos_y'^2)/'pos_z')/'pos_x'"
  calc, "'yn'='pos_y'/'pos_z'"
  calc, "'zn'='pos_x'^0"
  calc, "'cosp'=('xn'*'v_4d_mvn_sta_get_d1_x'+'yn'*'v_4d_mvn_sta_get_d1_y'+'zn'*'v_4d_mvn_sta_get_d1_z')/(sqrt('xn'^2+'yn'^2+'zn'^2)*sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2))"
  calc, "'fp'='np'*'Vp'*'cosp'*10^5"
  calc, "'intp'='fp'*'dh'*10^5"
  get_data,'intp', t, fp
;  ;a3
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[15,18]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[15,18]
  split_vec, 'v_4d_mvn_sta_get_d1'
  calc, "'no'='n_4d_mvn_sta_get_d1'"
  calc,"'Vo'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  calc, "'coso'=('xn'*'v_4d_mvn_sta_get_d1_x'+'yn'*'v_4d_mvn_sta_get_d1_y'+'zn'*'v_4d_mvn_sta_get_d1_z')/(sqrt('xn'^2+'yn'^2+'zn'^2)*sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2))"
  get_data,'no', t, q1
  get_data,'Vo', t, q2
  a3=dblarr(3,n_elements(t))
  a3[0,*]=t
  a3[1,*]=q1
  a3[2,*]=q2 
  s=0
  poisk=dblarr(6, n_elements(a1[0,*]))
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a3[0,*])-1 do begin
      if a1[0, j] eq a3[0, l] then begin
        s=s+1
      endif
    endfor
  endfor
  corr=dblarr(6, s)
  s=0
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a3[0,*])-1 do begin
      if a1[0, j] eq a3[0, l] then begin
        corr[0,s]=a1[0,j]
        corr[1,s]=a1[1,j]
        corr[2,s]=a1[2,j]
        corr[3,s]=a1[3,j]
        corr[4,s]=a3[1,l]
        corr[5,s]=a3[2,l]
        s=s+1
      endif
    endfor
  endfor
  calc, "'fo'='no'*'Vo'*'coso'*10^5"
  calc, "'into'='fo'*'dh'*10^5"
  get_data,'into', t, fo
; ;a4
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[31,33]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[31,33]
  split_vec, 'v_4d_mvn_sta_get_d1'
  calc, "'no2'='n_4d_mvn_sta_get_d1'"
  calc,"'Vo2'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  calc, "'coso2'=('xn'*'v_4d_mvn_sta_get_d1_x'+'yn'*'v_4d_mvn_sta_get_d1_y'+'zn'*'v_4d_mvn_sta_get_d1_z')/(sqrt('xn'^2+'yn'^2+'zn'^2)*sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2))"
  get_data,'no2', t, w1
  get_data,'Vo2', t, w2
  a4=dblarr(3,n_elements(t))
  a4[0,*]=t
  a4[1,*]=w1
  a4[2,*]=w2
  s=0
  poisk=dblarr(6, n_elements(a1[0,*]))
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a4[0,*])-1 do begin
      if a1[0, j] eq a4[0, l] then begin
        s=s+1
      endif
    endfor
  endfor
  corr=dblarr(6, s)
  s=0
  for j = 0, n_elements(a1[0,*])-1 do begin
    for l = 0,  n_elements(a4[0,*])-1 do begin
      if a1[0, j] eq a4[0, l] then begin
        corr[0,s]=a1[0,j]
        corr[1,s]=a1[1,j]
        corr[2,s]=a1[2,j]
        corr[3,s]=a1[3,j]
        corr[4,s]=a4[1,l]
        corr[5,s]=a4[2,l]
        s=s+1
      endif
    endfor
  endfor
  calc, "'fo2'='no2'*'Vo2'*'coso2'*10^5"
  calc, "'into2'='fo2'*'dh'*10^5"
  get_data,'into2', t, fo2
  
  init_crib_colors
  tplot,['fp','fo','fo2','|pos|','cosp']
  fluxp=total(abs(fp), /NaN)
  fluxo=total(abs(fo), /NaN)
  fluxo2=total(abs(fo2), /NaN)
  flux_all= fluxp + fluxo + fluxo2
  dprint, 'flux_p', fluxp
  dprint, 'flux_o', fluxo
  dprint, 'flux_o2', fluxo2
  dprint, 'flux_all', flux_all
 ; stop, c
  end
  
