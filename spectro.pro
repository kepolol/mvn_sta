pro spectro
cols=get_colors()
if not keyword_set(all) then begin
  store_data,delete='mvn_STA_*'
  store_data,delete='mvn_sta_*'
endif

common mvn_d1,mvn_d1_ind,mvn_d1_dat

if size(mvn_d1_dat,/type) eq 8 then begin

  npts = n_elements(mvn_d1_dat.time)
  mode = mvn_d1_dat.mode
  rate = mvn_d1_dat.rate
  iswp = mvn_d1_dat.swp_ind
  ieff = mvn_d1_dat.eff_ind
  iatt = mvn_d1_dat.att_ind
  mlut = mvn_d1_dat.mlut_ind
  nenergy = mvn_d1_dat.nenergy
  nbins = mvn_d1_dat.nbins
  ndef = mvn_d1_dat.ndef
  nanode = mvn_d1_dat.nanode
  nmass = mvn_d1_dat.nmass
  qf = (mvn_d1_dat.quality_flag and 128)/128 or (mvn_d1_dat.quality_flag and 64)/64

  time = (mvn_d1_dat.time + mvn_d1_dat.end_time)/2.
  data = mvn_d1_dat.data
  energy = reform(mvn_d1_dat.energy[iswp,*,0,0])
  mass = reform(total(mvn_d1_dat.mass_arr[iswp,*,0,*],2)/nenergy)
  theta = total(reform(mvn_d1_dat.theta[iswp,nenergy-1,*,0],npts,ndef,nanode),3)/nanode
  phi = total(reform(mvn_d1_dat.phi[iswp,nenergy-1,*,0],npts,ndef,nanode),2)/ndef
  str_element,mvn_d1_dat,'eflux',eflux,success=success
  eflux = total(eflux, 3)
  spectrP=dblarr(n_elements(time),32)
  spectrO=dblarr(n_elements(time),32)
  spectrO2=dblarr(n_elements(time),32)
  spectrP=eflux[*, *, 0]
  store_data,'spectrP',data={x:time,y:spectrP/nbins,v:energy}
  ylim,'spectrP',1.e0,1.e4,1
  zlim,'spectrP',1.e3,1.e9,1
  options,'spectrP','spec',1
  options,'spectrP',ytitle='P Energy!CeV'
  spectrO=eflux[*, *, 4]
  store_data,'spectrO',data={x:time,y:spectrO/nbins,v:energy}
  ylim,'spectrO',1.e0,1.e4,1
  zlim,'spectrO',1.e3,1.e9,1
  options,'spectrO','spec',1
  options,'spectrO',ytitle='O+ Energy!CeV'
  options,'spectrO',ztitle='eflux'
  spectrO2=eflux[*, *, 5]
  store_data,'spectrO2',data={x:time,y:spectrO2/nbins,v:energy}
  ylim,'spectrO2',1.e0,1.e4,1
  zlim,'spectrO2',1.e3,1.e9,1
  options,'spectrO2','spec',1
  options,'spectrO2',ytitle='O2+ Energy!CeV'
 endif
 end 
  
  
  
  
  
  
  