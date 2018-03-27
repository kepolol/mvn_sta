pro to_mathlab
  t1='2016-01-31/02:10:00'
  t2='2016-02-01/02:28:00' 
  timespan, [t1, t2]
  mvn_swe_load_l2, /all
  mvn_lpw_load_l2, ['lpnt'],trange=[t1,t2], /noTPLOT
  tplot_ascii, 'mvn_swe_spec_dens', dir = 'C:\Users\Vladimir\Desktop\IDL_files\'
  tplot_ascii, 'mvn_lpw_lp_ne_l2', dir = 'C:\Users\Vladimir\Desktop\IDL_files\'
end