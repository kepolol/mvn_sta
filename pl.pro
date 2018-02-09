pro pl

  init_crib_colors
  dprint, 'начало временного интервала'
  yy1 = ''
  read, yy1, prompt = ('yyyy:  ')
  mo1 = ''
  read, mo1, prompt = ('MM:  ')
  day1 = ''
  read, day1, prompt = ('DD:  ')
  ho1 = ''
  read, ho1, prompt = ('HH:  ')
  min1 = ''
  read, min1, prompt = ('MM:  ')
  sec1 = ''
  read, sec1, prompt = ('SS:  ')

  dprint, 'конец временного интервала'
  ho2 = ''
  read, ho2, prompt = ('HH:  ')
  min2 = ''
  read, min2, prompt = ('MM:  ')
  sec2 = ''
  read, sec2, prompt = ('SS:  ')
  t1=yy1 + '-' + mo1 + '-' + day1 + '/' + ho1 + ':' +  min1 + ':' + sec1
  t2=yy1 + '-' + mo1 + '-' + day1 + '/' + ho2 + ':' +  min2 + ':' + sec2
  t3=yy1 + '-' + mo1 + '-' + day1 + '    ' + ho1 + ':' +  min1 + ':' + sec1 + ' - ' + ho2 + ':' +  min2 + ':' + sec2
  timespan, [t1, t2]
  name = 'mvn_mag_l2*'+'_'+yy1+mo1+day1+'_'+'*.sts'
  CD, 'D:\\MAVEN\data\maven\data\sci\mag\l2\'+yy1+'\'+mo1
  sts_filename = FILE_SEARCH(name,/FULLY_QUALIFY_PATH)
  B = mvn_mag_sts_read(sts_filename)
  store_data, 'mag', data = B
  get_data, 'mag.OB_B_X', ti, d1
  get_data, 'mag.OB_B_Y', ti, d2
  get_data, 'mag.OB_B_Z', ti, d3
  mvn_sta_l2_load
  a1=dblarr(4,n_elements(B))
  a1[0,*]=ti
  a1[1,*]=d1
  a1[2,*]=d2
  a1[3,*]=d3
mvn_sta_l2_tplot
  ;---------------------------------------------
  ;p+
  ;---------------------------------------------
  get_4dt, 'T_4d', 'mvn_sta_get_d1', mass=[0,3]
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[0,3]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[0,3]
  split_vec, 'v_4d_mvn_sta_get_d1'
  split_vec, 'T_4d_mvn_sta_get_d1'
  calc, "'np'='n_4d_mvn_sta_get_d1'"
  calc, "'Tp'='T_4d_mvn_sta_get_d1_1'"
  calc,"'Vp'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  calc, "'Vpx'='v_4d_mvn_sta_get_d1_x'"
  calc, "'Vpy'='v_4d_mvn_sta_get_d1_y'"
  calc, "'Vpz'='v_4d_mvn_sta_get_d1_z'"
  calc,"'Ep'='n_4d_mvn_sta_get_d1'*'T_4d_mvn_sta_get_d1_1'"
  calc, "'E1'='np'*(1.6726219*10^(-27))*('Vp'^2)*(6.24151*10^(24))/2"
  ;---------------------------------------------
  ;O+
  ;---------------------------------------------
  get_4dt, 'T_4d', 'mvn_sta_get_d1', mass=[15,18]
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[15,18]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[15,18]
  split_vec, 'v_4d_mvn_sta_get_d1'
  split_vec, 'T_4d_mvn_sta_get_d1'
  calc, "'no'='n_4d_mvn_sta_get_d1'"
  calc, "'To'='T_4d_mvn_sta_get_d1_3'"
  calc,"'Vo'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  calc, "'Vox'='v_4d_mvn_sta_get_d1_x'"
  calc, "'Voy'='v_4d_mvn_sta_get_d1_y'"
  calc, "'Voz'='v_4d_mvn_sta_get_d1_z'"
  calc,"'Eo'='n_4d_mvn_sta_get_d1'*'T_4d_mvn_sta_get_d1_1'"
  calc, "'E2'='no'*(16*1.66053904*10^(-27))*('Vo'^2)*(6.24151*10^(24))/2"
  ;---------------------------------------------
  ;O2+
  ;--------------------------------------------
  get_4dt, 'T_4d', 'mvn_sta_get_d1', mass=[31,33]
  get_4dt, 'n_4d', 'mvn_sta_get_d1', mass=[31,33]
  get_4dt, 'v_4d', 'mvn_sta_get_d1', mass=[31,33]
  split_vec, 'v_4d_mvn_sta_get_d1'
  split_vec, 'T_4d_mvn_sta_get_d1'
  calc, "'no2'='n_4d_mvn_sta_get_d1'"
  calc, "'To2'='T_4d_mvn_sta_get_d1_3'"
  calc,"'Vo2'=sqrt('v_4d_mvn_sta_get_d1_x'^2+'v_4d_mvn_sta_get_d1_y'^2+'v_4d_mvn_sta_get_d1_z'^2)"
  calc, "'Vo2x'='v_4d_mvn_sta_get_d1_x'"
  calc, "'Vo2y'='v_4d_mvn_sta_get_d1_y'"
  calc, "'Vo2z'='v_4d_mvn_sta_get_d1_z'"
  calc,"'Eo2'='n_4d_mvn_sta_get_d1'*'T_4d_mvn_sta_get_d1_1'"
  calc, "'E3'='no2'*(32*1.66053904*10^(-27))*('Vo2'^2)*(6.24151*10^(24))/2"
  ;----------------------------------------------
  ;nheavy/np
  ;----------------------------------------------
  calc,"'nh'='no'+'no2'"
  calc,"'nh/np'='nh'/'np'"
  calc,"'nall'='np'+'no'+'no2'"
  ;----------------------------------------------
  ;сравнение для мага
  ;----------------------------------------------
  get_data,'Vpx',ty, Vpx
  a3=dblarr(1,n_elements(ty))
  a3[0,*]=ty
  s=0
  a4=long(a1[0,*])
  a5=long(a3)
  for j = 0, n_elements(a4[0,*])-1 do begin
    for l = 0,  n_elements(a5[0,*])-1 do begin
      if a4[0, j] eq a5[0, l] then begin
        s=s+1
      endif
    endfor
  endfor
  corr=dblarr(4, s)
  s=0
  for j = 0, n_elements(a4[0,*])-1 do begin
    for l = 0,  n_elements(a5[0,*])-1 do begin
      if a4[0, j] eq a5[0, l] then begin
        corr[0,s]=a1[0,j]
        corr[1,s]=a1[1,j]
        corr[2,s]=a1[2,j]
        corr[3,s]=a1[3,j]
        s=s+1
      endif
    endfor
  endfor
  tran=transpose(corr)
  store_data, 'Bx', data ={x:tran[*,0], y:tran[*,1]}
  store_data, 'By', data ={x:tran[*,0], y:tran[*,2]}
  store_data, 'Bz', data ={x:tran[*,0], y:tran[*,3]}
  ;---------------------------------------------
  ;B field
  ;---------------------------------------------
  calc,"'B'=sqrt('mag.OB_B_X'^2+'mag.OB_B_Y'^2+'mag.OB_B_Z'^2)"
  ;----------------------------------------------
  ;energy
  ;----------------------------------------------

  calc, "'Eb' = ('B'^2)*(6.24150965*10)/(8*3.1415)"
  calc, "'Eth' = 'Ep' + 'Eo' + 'Eo2'"
  calc, "'Ek' = 'E1' + 'E2' + 'E3'"
  ;----------------------------------------------
  ;angle
  ;----------------------------------------------
  get_data,'Vpx',ty, Vpx
  get_data,'Vpy',ty, Vpy
  get_data,'Vpz',ty, Vpz
  get_data,'Vox',ty, Vox
  get_data,'Voy',ty, Voy
  get_data,'Voz',ty, Voz
  get_data,'Vo2x',ty, Vo2x
  get_data,'Vo2y',ty, Vo2y
  get_data,'Vo2z',ty, Vo2z
  ang=dblarr(16,n_elements(corr[0,*]))
  ang[0,*] = corr[0,*] ;time
  ang[1,*] = corr[1,*] ;Bx
  ang[2,*] = corr[2,*] ;By
  ang[3,*] = corr[3,*] ;Bz
  ang[4,*] = Vpx
  ang[5,*] = Vpy
  ang[6,*] = Vpz
  ang[7,*] = Vox
  ang[8,*] = Voy
  ang[9,*] = Voz
  ang[10,*] = Vo2x
  ang[11,*] = Vo2y
  ang[12,*] = Vo2z
  ang[13,*] = 180/!PI*acos((ang[1,*]*ang[4,*]+ang[2,*]*ang[5,*]+ang[3,*]*ang[6,*])/(sqrt((ang[1,*])^2+(ang[2,*])^2+(ang[3,*])^2)*sqrt((ang[4,*])^2+(ang[5,*])^2+(ang[6,*])^2)))
  ang[14,*] = 180/!PI*acos((ang[1,*]*ang[7,*]+ang[2,*]*ang[8,*]+ang[3,*]*ang[9,*])/(sqrt((ang[1,*])^2+(ang[2,*])^2+(ang[3,*])^2)*sqrt((ang[7,*])^2+(ang[8,*])^2+(ang[9,*])^2)))
  ang[15,*] = 180/!PI*acos((ang[1,*]*ang[10,*]+ang[2,*]*ang[11,*]+ang[3,*]*ang[12,*])/(sqrt((ang[1,*])^2+(ang[2,*])^2+(ang[3,*])^2)*sqrt((ang[10,*])^2+(ang[11,*])^2+(ang[12,*])^2)))
  angl=transpose(ang)
  store_data, 'angleP', data ={x:angl[*,0], y:angl[*,13], labels:['P'], labflag:1 }
  store_data, 'angleO', data ={x:angl[*,0], y:angl[*,14], labels:['O'], labflag:1 }
  store_data, 'angleO2', data ={x:angl[*,0], y:angl[*,15], labels:['O2'], labflag:1 }
  ;----------------------------------------------
  mvn_swe_load_l2, /all
  mvn_swe_sumplot
  mvn_swe_n1d
  get_data, 'mvn_swe_spec_dens', tim, dswe
  get_data, 'nall', tim1, nall
  swe=dblarr(2, n_elements(tim))
  swe[0, *] = tim
  swe[1, *] = dswe
  swe1=dblarr(3, n_elements(ty))
  swe1[0, *] = ty
  swe1[2, *] = nall
  if (ty[0] - swe[0,0]) < 2 then begin
    for r = 0, n_elements(ty)-1 do begin
      e = 0 + r*2
      swe1[1,r] = (swe[1, e]+swe[1, (e+1)])/2
    endfor
  endif else begin
    if (ty[0] - swe[0,1]) < 2 then begin
      for r = 0, n_elements(ty)-1 do begin
        e = 1 + r*2
        swe1[1,r] = (swe[1, e]+swe[1, (e+1)])/2
      endfor
    endif
  endelse
  swe1 = transpose(swe1)
  q=plot(swe1[*, 2],swe1[*, 1], 'r*')
  ;----------------------------------------------
  store_data, 'n', data=['np', 'no', 'no2']
  store_data, 'Ball', data=['B','mag.OB_B_X','mag.OB_B_Y','mag.OB_B_Z']
  store_data, 'V', data=['Vp', 'Vo', 'Vo2']
  store_data, 'E', data=['Ek', 'Eb', 'Eth']
  store_data, 'angle', data=['angleP','angleO','angleO2']
  options, 'nall', colors=['o'],labels=['n_all'], labflag=2, yrange=[0.1, 1000],ytitle='total ions density, [cm-3]', ylog=1, xticklen=1, yticklen=1
  options, 'Ball', colors=['o','b','r', 'g'],labels=['|B|','Bx','By','Bz'], labflag=2, yrange=[-20, 20],ytitle='B, [nT]', xticklen=1, yticklen=1
  options, 'n', colors=['o','b','r'],labels=['P','O','O2'], labflag=2, yrange=[0.01, 1000],ytitle='density, [cm-3]', ylog=1, xticklen=1, yticklen=1
  options, 'V', colors=['o','b','r'],labels=['P','O','O2'], labflag=2, yrange=[1, 1000],ytitle='velocity, [km/s]', ylog=1, xticklen=1, yticklen=1
  options, 'E', colors=['o','b','r'],labels=['nmV^2/2','B^2/((8pi)','nkT'], labflag=2, yrange=[10, 10000],ytitle='[eV*cm-3]', ylog=1 , xticklen=1, yticklen=1
  options, 'angle',colors=['o','b','r'],legend=['p','O','O2'], labflag=2, yrange=[0, 180],ytitle='V-B angle, [grad]', xticklen=1, yticklen=1
  tplot_options, title = t3
  tplot,['mvn_sta_d1_E','n','nall','mvn_swe_spec_dens']


end